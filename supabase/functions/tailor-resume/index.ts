// Adapta la HV del usuario a una oferta guardada y escribe una carta de
// presentación. Un validador descarta lo que no está respaldado por el
// perfil. No guarda nada: la app muestra el resultado para revisarlo.
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
  type ModelOutput,
  type ProfileInput,
  PROMPT_VERSION,
  SCHEMA,
  validate,
} from "./tailoring.ts";

async function loadProfile(userId: string): Promise<ProfileInput> {
  const select = (table: string) =>
    supabaseAdmin.from(table).select("*").eq("user_id", userId);
  const [profile, experiences, skills, projects] = await Promise.all([
    select("profiles"),
    select("experiences").order("start_date", { ascending: false }),
    select("skills"),
    select("projects"),
  ]);
  return {
    profile: profile.data?.[0] ?? null,
    experiences: experiences.data ?? [],
    skills: skills.data ?? [],
    projects: projects.data ?? [],
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

  let jobId: unknown;
  try {
    ({ job_id: jobId } = await request.json());
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  if (typeof jobId !== "string") return json({ error: "invalid_body" }, 400);

  const { data: job } = await supabaseAdmin
    .from("jobs")
    .select("title, company, location, work_mode, requirements, description")
    .eq("id", jobId)
    .eq("user_id", user.id)
    .maybeSingle();
  if (!job) return json({ error: "job_not_found" }, 404);

  const profile = await loadProfile(user.id);
  if (profile.experiences.length === 0) {
    return json({ error: "empty_profile" }, 422);
  }

  const startedAt = Date.now();
  try {
    const result = await generateJson<ModelOutput>({
      prompt: buildPrompt(profile, job),
      schema: SCHEMA,
    });
    await logAiCall({
      userId: user.id,
      functionName: "tailor-resume",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    const { resume, validation } = validate(profile, result.data);
    return json({
      language: result.data.language,
      resume,
      cover_letter: result.data.cover_letter.trim(),
      changes: result.data.changes,
      keywords: result.data.keywords,
      validation,
      model: result.model,
      prompt_version: PROMPT_VERSION,
    });
  } catch (error) {
    return aiErrorResponse(error, "tailor-resume");
  }
});
