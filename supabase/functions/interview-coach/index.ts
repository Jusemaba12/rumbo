// Simulador de entrevistas: hace la siguiente pregunta y evalúa la última
// respuesta. No guarda la sesión: la app envía el historial en cada turno.
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
  buildPrompt,
  type CoachOutput,
  DEFAULT_QUESTIONS,
  MAX_ANSWER_CHARS,
  MAX_QUESTIONS,
  type Mode,
  MODES,
  normalizeOutput,
  SCHEMA,
  type Turn,
} from "./coach.ts";

async function loadProfile(userId: string) {
  const select = (table: string) =>
    supabaseAdmin.from(table).select("*").eq("user_id", userId);
  const [profile, experiences, projects, skills] = await Promise.all([
    select("profiles"),
    select("experiences"),
    select("projects"),
    select("skills"),
  ]);
  const strip = (rows: Record<string, unknown>[] | null) =>
    (rows ?? []).map(({ id: _id, user_id: _u, ...rest }) => rest);
  return {
    profile: strip(profile.data)[0] ?? null,
    experiences: strip(experiences.data),
    projects: strip(projects.data),
    skills: (skills.data ?? []).map((s) => s.name),
  };
}

function parseTurns(value: unknown): Turn[] | null {
  if (!Array.isArray(value) || value.length > MAX_QUESTIONS) return null;
  const turns: Turn[] = [];
  for (const item of value) {
    if (typeof item?.question !== "string" || typeof item?.answer !== "string") {
      return null;
    }
    turns.push({
      question: item.question.slice(0, 1000),
      answer: item.answer.slice(0, MAX_ANSWER_CHARS),
    });
  }
  return turns;
}

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return preflight();
  if (request.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }
  const user = await requireUser(request);
  if (!user) return json({ error: "unauthorized" }, 401);
  const overQuota = await aiQuotaExceeded(user.id);
  if (overQuota) return overQuota;

  // deno-lint-ignore no-explicit-any
  let body: any;
  try {
    body = await request.json();
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  const mode: Mode = MODES.includes(body.mode) ? body.mode : "mixed";
  const language = body.language === "en" ? "en" : "es";
  const total = Number.isInteger(body.total_questions)
    ? Math.max(1, Math.min(MAX_QUESTIONS, body.total_questions))
    : DEFAULT_QUESTIONS;
  const turns = parseTurns(body.turns ?? []);
  if (!turns || typeof body.job_id !== "string") {
    return json({ error: "invalid_body" }, 400);
  }

  const { data: job } = await supabaseAdmin
    .from("jobs")
    .select("title, company, requirements, description")
    .eq("id", body.job_id)
    .eq("user_id", user.id)
    .maybeSingle();
  if (!job) return json({ error: "job_not_found" }, 404);

  const startedAt = Date.now();
  try {
    const result = await generateJson<CoachOutput>({
      prompt: buildPrompt({
        profile: await loadProfile(user.id),
        job: { ...job, description: String(job.description).slice(0, 6000) },
        mode,
        language,
        turns,
        totalQuestions: total,
      }),
      schema: SCHEMA,
    });
    await logAiCall({
      userId: user.id,
      functionName: "interview-coach",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    return json(normalizeOutput(result.data, turns.length, total));
  } catch (error) {
    return aiErrorResponse(error, "interview-coach");
  }
});
