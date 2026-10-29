// Recibe correos del script de Google Apps Script del usuario, los asocia a
// sus procesos activos y propone cambios de estado con IA. No cambia nada:
// guarda propuestas que el usuario aplica o ignora en la app.
//
// También recibe las alertas de empleo de LinkedIn del usuario (acción
// linkedin_alerts) y las guarda como sugerencias en Ofertas (linkedin.ts).
//
// Autenticación: encabezado x-sync-key con la clave que generó la app (en la
// base de datos solo está su hash).
import { generateJson } from "../_shared/ai.ts";
import {
  aiErrorResponse,
  json,
  logAiCall,
  preflight,
  supabaseAdmin,
} from "../_shared/http.ts";
import { loadProfile } from "../_shared/profile.ts";
import { dedupeKey } from "../search-jobs/matching.ts";
import {
  type ActiveProcess,
  buildPrompt,
  type Classification,
  EMAIL_STATUSES,
  type IncomingMessage,
  matchProcess,
  MAX_BODY_CHARS,
  MAX_MESSAGES,
  SCHEMA,
} from "./classify.ts";
import {
  ALERT_SENDERS,
  type AlertJob,
  buildPrompt as buildAlertPrompt,
  type ExtractedJob,
  extractAlertJobs,
  MAX_ALERT_BODY_CHARS,
  MAX_ALERT_JOBS,
  MAX_ALERT_MESSAGES,
  PROMPT_VERSION as ALERT_PROMPT_VERSION,
  SCHEMA as ALERT_SCHEMA,
  workModeOf,
} from "./linkedin.ts";

/** Estados en los que un proceso puede recibir correos de la empresa. */
const ACTIVE_STATUSES = [
  "applied",
  "in_review",
  "technical_test",
  "interview",
  "offer",
  "no_response",
];

async function sha256Hex(value: string): Promise<string> {
  const digest = await crypto.subtle.digest(
    "SHA-256",
    new TextEncoder().encode(value),
  );
  return [...new Uint8Array(digest)]
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

async function userForKey(key: string | null): Promise<string | null> {
  if (!key || key.length < 32) return null;
  const { data } = await supabaseAdmin
    .from("email_sync_keys")
    .select("user_id")
    .eq("key_hash", await sha256Hex(key))
    .maybeSingle();
  if (!data) return null;
  await supabaseAdmin
    .from("email_sync_keys")
    .update({ last_used_at: new Date().toISOString() })
    .eq("user_id", data.user_id);
  return data.user_id;
}

async function activeProcesses(userId: string): Promise<ActiveProcess[]> {
  const { data } = await supabaseAdmin
    .from("applications")
    .select("id, jobs(company, title)")
    .eq("user_id", userId)
    .in("status", ACTIVE_STATUSES);
  return (data ?? []).flatMap((row) => {
    // deno-lint-ignore no-explicit-any
    const job = row.jobs as any;
    const company = typeof job?.company === "string" ? job.company.trim() : "";
    return company ? [{ id: row.id, company, title: job.title ?? "" }] : [];
  });
}

function parseMessages(
  value: unknown,
  maxMessages = MAX_MESSAGES,
  maxBody = MAX_BODY_CHARS,
): IncomingMessage[] | null {
  if (!Array.isArray(value)) return null;
  const messages: IncomingMessage[] = [];
  for (const item of value.slice(0, maxMessages)) {
    if (!item || typeof item.id !== "string") return null;
    const str = (v: unknown) => (typeof v === "string" ? v : "");
    messages.push({
      id: item.id,
      from: str(item.from).slice(0, 300),
      subject: str(item.subject).slice(0, 500),
      date: str(item.date),
      body: str(item.body).slice(0, maxBody),
    });
  }
  return messages;
}

/**
 * Alertas de empleo de LinkedIn: saca las ofertas, las puntúa en una sola
 * llamada y las guarda como sugerencias. Las alertas las configura el propio
 * usuario en LinkedIn, así que se guardan todas aunque la nota sea baja.
 */
async function handleLinkedInAlerts(
  userId: string,
  value: unknown,
): Promise<Response> {
  const messages = parseMessages(
    value,
    MAX_ALERT_MESSAGES,
    MAX_ALERT_BODY_CHARS,
  );
  if (!messages) return json({ error: "invalid_body" }, 400);
  const byId = new Map<string, AlertJob>();
  for (const message of messages) {
    const from = message.from.toLowerCase();
    if (!ALERT_SENDERS.some((sender) => from.includes(sender))) continue;
    const received = Date.parse(message.date);
    const date = isNaN(received) ? null : new Date(received);
    for (const job of extractAlertJobs(message.body, date)) {
      if (!byId.has(job.jobId)) byId.set(job.jobId, job);
    }
  }
  const summary = { received: messages.length, found: byId.size, scored: 0, suggested: 0 };
  if (byId.size === 0) return json(summary);

  const { data: known } = await supabaseAdmin
    .from("jobs")
    .select("external_id")
    .eq("user_id", userId)
    .eq("source", "linkedin")
    .in("external_id", [...byId.keys()]);
  const knownIds = new Set((known ?? []).map((row) => row.external_id));
  const jobs = [...byId.values()]
    .filter((job) => !knownIds.has(job.jobId) && job.text)
    .slice(0, MAX_ALERT_JOBS);
  summary.scored = jobs.length;
  if (jobs.length === 0) return json(summary);

  const startedAt = Date.now();
  let results: ExtractedJob[];
  let model: string;
  try {
    const result = await generateJson<{ jobs: ExtractedJob[] }>({
      prompt: buildAlertPrompt(await loadProfile(userId), jobs),
      schema: ALERT_SCHEMA,
    });
    await logAiCall({
      userId,
      functionName: "email-sync",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    results = result.data.jobs;
    model = result.model;
  } catch (error) {
    return aiErrorResponse(error, "email-sync");
  }

  for (const item of results) {
    const job = jobs[item.index];
    const title = item.title?.trim() ?? "";
    const company = item.company?.trim() ?? "";
    if (!job || !item.is_job || !title || !company) continue;
    const location = item.location?.trim() ?? "";
    const { data: inserted, error } = await supabaseAdmin
      .from("jobs")
      .insert({
        user_id: userId,
        source: "linkedin",
        external_id: job.jobId,
        url: job.url,
        dedupe_hash: dedupeKey({ company, title, location }),
        title,
        company,
        location,
        work_mode: workModeOf(item.work_mode),
        description: job.text,
        requirements: item.requirements ?? [],
        published_at: job.receivedAt?.toISOString() ?? null,
        discovered: true,
      })
      .select("id")
      .single();
    if (error || !inserted) {
      // 23505: ya estaba (otra alerta o la búsqueda la guardó antes).
      if (error?.code !== "23505") console.error("insert linkedin job", error);
      continue;
    }
    await supabaseAdmin.from("job_matches").insert({
      job_id: inserted.id,
      user_id: userId,
      score: Math.max(0, Math.min(100, Math.round(item.score))),
      met: item.met ?? [],
      missing: item.missing ?? [],
      explanation: item.explanation ?? "",
      model,
      prompt_version: ALERT_PROMPT_VERSION,
    });
    summary.suggested++;
  }
  return json(summary);
}

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return preflight();
  if (request.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }
  const userId = await userForKey(request.headers.get("x-sync-key"));
  if (!userId) return json({ error: "unauthorized" }, 401);

  let body: { action?: unknown; messages?: unknown };
  try {
    body = await request.json();
  } catch {
    return json({ error: "invalid_body" }, 400);
  }

  if (body.action === "linkedin_alerts") {
    return handleLinkedInAlerts(userId, body.messages);
  }

  const processes = await activeProcesses(userId);

  // El script pide primero las empresas para buscar solo esos correos.
  if (body.action === "companies") {
    return json({
      companies: [...new Set(processes.map((p) => p.company))],
    });
  }
  if (body.action !== "messages") return json({ error: "invalid_body" }, 400);

  const messages = parseMessages(body.messages);
  if (!messages) return json({ error: "invalid_body" }, 400);

  const { data: seen } = await supabaseAdmin
    .from("email_updates")
    .select("gmail_message_id")
    .eq("user_id", userId)
    .in("gmail_message_id", messages.map((m) => m.id));
  const seenIds = new Set((seen ?? []).map((row) => row.gmail_message_id));

  const items = messages
    .filter((message) => !seenIds.has(message.id))
    .flatMap((message) => {
      const process = matchProcess(message, processes);
      return process ? [{ message, process }] : [];
    });
  const summary = { received: messages.length, matched: items.length, proposed: 0 };
  if (items.length === 0) return json(summary);

  const { data: profile } = await supabaseAdmin
    .from("profiles")
    .select("timezone")
    .eq("user_id", userId)
    .maybeSingle();

  const startedAt = Date.now();
  let results: Classification[];
  try {
    const result = await generateJson<{ results: Classification[] }>({
      prompt: buildPrompt(items, profile?.timezone || "America/Bogota"),
      schema: SCHEMA,
    });
    await logAiCall({
      userId,
      functionName: "email-sync",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    results = result.data.results;
  } catch (error) {
    return aiErrorResponse(error, "email-sync");
  }

  for (const item of results) {
    const match = items[item.index];
    if (!match || !item.relevant) continue;
    const status = (EMAIL_STATUSES as readonly string[]).includes(item.status)
      ? item.status
      : null;
    const interviewAt = item.interview_at && !isNaN(Date.parse(item.interview_at))
      ? new Date(item.interview_at).toISOString()
      : null;
    if (!status && !interviewAt) continue;
    const received = Date.parse(match.message.date);
    const { error } = await supabaseAdmin.from("email_updates").insert({
      user_id: userId,
      application_id: match.process.id,
      gmail_message_id: match.message.id,
      received_at: isNaN(received) ? null : new Date(received).toISOString(),
      sender: match.message.from,
      subject: match.message.subject,
      summary: item.summary.slice(0, 500),
      suggested_status: status,
      interview_at: interviewAt,
    });
    if (error && error.code !== "23505") console.error("insert update", error);
    if (!error) summary.proposed++;
  }
  return json(summary);
});
