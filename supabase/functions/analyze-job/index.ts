// Analiza una oferta (texto pegado o enlace) y calcula su compatibilidad con
// el perfil del usuario. No guarda nada: la app muestra el resultado y el
// usuario decide si guardar la oferta.
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
  type JobAnalysis,
  MAX_DESCRIPTION_CHARS,
  MIN_DESCRIPTION_CHARS,
  PROMPT_VERSION,
  SCHEMA,
  verifyContact,
} from "./analysis.ts";
import { fetchPageText } from "../_shared/page_text.ts";

async function loadProfile(userId: string) {
  const [profile, experiences, projects, skills] = await Promise.all(
    ["profiles", "experiences", "projects", "skills"].map((table) =>
      supabaseAdmin.from(table).select("*").eq("user_id", userId)
    ),
  );
  const strip = (rows: Record<string, unknown>[] | null) =>
    (rows ?? []).map(({ id: _id, user_id: _userId, ...rest }) => rest);
  return {
    profile: strip(profile.data)[0] ?? null,
    experiences: strip(experiences.data),
    projects: strip(projects.data),
    skills: strip(skills.data),
  };
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

  let body: { url?: unknown; text?: unknown };
  try {
    body = await request.json();
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  const url = typeof body.url === "string" ? body.url.trim() : "";
  let text = typeof body.text === "string" ? body.text.trim() : "";
  if (text.length < MIN_DESCRIPTION_CHARS && url) {
    text = (await fetchPageText(url)) ?? text;
  }
  if (text.length < MIN_DESCRIPTION_CHARS) {
    // La app pide pegar la descripción a mano.
    return json({ error: "no_description" }, 422);
  }
  text = text.slice(0, MAX_DESCRIPTION_CHARS);

  const startedAt = Date.now();
  try {
    const profile = await loadProfile(user.id);
    const result = await generateJson<JobAnalysis>({
      prompt: buildPrompt(profile, text),
      schema: SCHEMA,
    });
    await logAiCall({
      userId: user.id,
      functionName: "analyze-job",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    const { match } = result.data;
    const job = verifyContact(result.data.job, text);
    return json({
      job: { ...job, url: url || null, description: text },
      match: {
        ...match,
        score: Math.max(0, Math.min(100, Math.round(match.score))),
        model: result.model,
        prompt_version: PROMPT_VERSION,
      },
    });
  } catch (error) {
    return aiErrorResponse(error, "analyze-job");
  }
});
