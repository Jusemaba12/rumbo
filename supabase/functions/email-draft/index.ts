// Borrador de correo para un proceso: seguimiento, agradecimiento tras una
// entrevista o respuesta a un rechazo. Con kind = application y job_id,
// el correo para postular a una oferta (la app adjunta la HV adaptada). No envía nada: la app lo muestra para
// editarlo, copiarlo o abrirlo en el correo.
import { generateJson } from "../_shared/ai.ts";
import {
  aiErrorResponse,
  aiQuotaExceeded,
  json,
  logAiCall,
  preflight,
  requireUser,
  supabaseAdmin,
} from "../_shared/http.ts";
import {
  buildEmailPrompt,
  KINDS,
  type Kind,
  salaryExpectation,
} from "./prompt.ts";

const PROMPT_VERSION = "email-draft/v1";
const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["subject", "body"],
  properties: {
    subject: { type: "string" },
    body: { type: "string" },
  },
};

/** «Ana Gómez <ana@acme.com>» → «ana@acme.com». */
function emailFrom(sender: string): string {
  const match = sender.match(/[^\s<>"]+@[^\s<>"]+\.[^\s<>"]+/);
  return match ? match[0] : "";
}

async function generate(userId: string, prompt: string, to: string) {
  const startedAt = Date.now();
  try {
    const result = await generateJson<{ subject: string; body: string }>({
      prompt,
      schema: SCHEMA,
    });
    await logAiCall({
      userId,
      functionName: "email-draft",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    return json({
      subject: result.data.subject.trim(),
      body: result.data.body.trim(),
      to,
      prompt_version: PROMPT_VERSION,
    });
  } catch (error) {
    return aiErrorResponse(error, "email-draft");
  }
}

/** Correo para postular a una oferta guardada (sin proceso todavía). */
async function draftApplication(
  userId: string,
  jobId: string,
  extra: string,
): Promise<Response> {
  const [{ data: job }, { data: profile }, { data: skills }] = await Promise
    .all([
      supabaseAdmin
        .from("jobs")
        .select(
          "title, company, description, requirements, salary_currency, recruiter_name, recruiter_email, apply_subject, asks_salary",
        )
        .eq("id", jobId)
        .eq("user_id", userId)
        .maybeSingle(),
      supabaseAdmin
        .from("profiles")
        .select(
          "full_name, headline, email, phone, salary_cop_min, salary_cop_max, salary_usd_min, salary_usd_max",
        )
        .eq("user_id", userId)
        .maybeSingle(),
      supabaseAdmin.from("skills").select("name").eq("user_id", userId),
    ]);
  if (!job) return json({ error: "not_found" }, 404);
  const overQuota = await aiQuotaExceeded(userId);
  if (overQuota) return overQuota;

  const expectation = salaryExpectation(profile, job);
  const prompt = buildEmailPrompt(
    "application",
    {
      candidato: {
        nombre: profile?.full_name ?? "",
        titular: profile?.headline ?? "",
        correo: profile?.email ?? "",
        telefono: profile?.phone ?? "",
      },
      puesto: job.title ?? "",
      empresa: job.company ?? "",
      requisitos: (job.requirements ?? []).slice(0, 8),
      reclutador: job.recruiter_name ?? null,
      asunto_exigido: job.apply_subject ?? null,
      piden_expectativa: job.asks_salary === true,
      // Solo si la piden: no se ofrece el salario sin que lo pregunten.
      expectativa_salarial: job.asks_salary === true ? expectation : null,
      habilidades_del_candidato: (skills ?? []).map((s) => s.name).slice(0, 25),
      indicaciones_extra: extra,
    },
    String(job.description ?? ""),
  );
  return generate(userId, prompt, job.recruiter_email ?? "");
}

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return preflight();
  if (request.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }
  const user = await requireUser(request);
  if (!user) return json({ error: "unauthorized" }, 401);

  // deno-lint-ignore no-explicit-any
  let body: any;
  try {
    body = await request.json();
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  const kind = body.kind as Kind;
  if (!(kind in KINDS)) return json({ error: "invalid_body" }, 400);
  const extra = typeof body.notes === "string" ? body.notes.slice(0, 1000) : "";
  if (kind === "application") {
    if (typeof body.job_id !== "string") {
      return json({ error: "invalid_body" }, 400);
    }
    return draftApplication(user.id, body.job_id, extra);
  }
  if (typeof body.application_id !== "string") {
    return json({ error: "invalid_body" }, 400);
  }

  const [
    { data: application },
    { data: profile },
    { data: interviews },
    { data: emails },
    { data: skills },
  ] = await Promise.all([
    supabaseAdmin
      .from("applications")
      .select(
        "status, applied_at, notes, jobs(title, company, description, requirements, recruiter_name, recruiter_email)",
      )
      .eq("id", body.application_id)
      .eq("user_id", user.id)
      .maybeSingle(),
    supabaseAdmin
      .from("profiles")
      .select("full_name, headline, email, phone")
      .eq("user_id", user.id)
      .maybeSingle(),
    supabaseAdmin
      .from("interviews")
      .select("kind, scheduled_at, notes")
      .eq("application_id", body.application_id)
      .eq("user_id", user.id)
      .order("scheduled_at", { ascending: false })
      .limit(1),
    supabaseAdmin
      .from("email_updates")
      .select("sender, subject, received_at")
      .eq("application_id", body.application_id)
      .eq("user_id", user.id)
      .order("received_at", { ascending: false })
      .limit(1),
    supabaseAdmin.from("skills").select("name").eq("user_id", user.id),
  ]);
  if (!application) return json({ error: "not_found" }, 404);

  const overQuota = await aiQuotaExceeded(user.id);
  if (overQuota) return overQuota;

  // deno-lint-ignore no-explicit-any
  const job: any = application.jobs ?? {};
  const lastEmail = emails?.[0];
  const prompt = buildEmailPrompt(
    kind,
    {
    candidato: {
      nombre: profile?.full_name ?? "",
      titular: profile?.headline ?? "",
      correo: profile?.email ?? "",
      telefono: profile?.phone ?? "",
    },
    puesto: job.title ?? "",
    empresa: job.company ?? "",
    requisitos: (job.requirements ?? []).slice(0, 8),
    postulado_el: application.applied_at ?? null,
    notas_del_proceso: String(application.notes ?? "").slice(0, 800),
    ultima_entrevista: interviews?.[0] ?? null,
    reclutador: job.recruiter_name ?? null,
    ultimo_correo_de_la_empresa: lastEmail
      ? { de: lastEmail.sender, asunto: lastEmail.subject }
      : null,
    habilidades_del_candidato: (skills ?? []).map((s) => s.name).slice(0, 25),
    indicaciones_extra: extra,
    },
    String(job.description ?? ""),
  );

  // Destinatario: quien escribió por última vez o, si nadie, el reclutador.
  return generate(
    user.id,
    prompt,
    lastEmail ? emailFrom(lastEmail.sender) : job.recruiter_email ?? "",
  );
});
