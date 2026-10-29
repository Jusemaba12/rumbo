// Ficha de la empresa de una oferta: qué hace, equipo, cultura, preguntas
// para la entrevista y señales de alerta. Se guarda en jobs.company_brief.
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

const PROMPT_VERSION = "company-brief/v1";
const strings = { type: "array", items: { type: "string" } };
const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: [
    "summary",
    "team_and_stack",
    "culture",
    "questions_to_ask",
    "red_flags",
    "general_knowledge",
  ],
  properties: {
    summary: { type: "string" },
    team_and_stack: strings,
    culture: strings,
    questions_to_ask: strings,
    red_flags: strings,
    general_knowledge: { type: "string" },
  },
};

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
    .select("title, company, location, work_mode, requirements, description, url")
    .eq("id", jobId)
    .eq("user_id", user.id)
    .maybeSingle();
  if (!job) return json({ error: "job_not_found" }, 404);

  const prompt = `Prepara una ficha breve de la empresa de esta oferta para un candidato que va a postularse o a entrevistarse. Todo en español.

- summary: 2 o 3 frases sobre qué hace la empresa y qué busca con este puesto, según la oferta.
- team_and_stack: lo que la oferta dice del equipo, producto y tecnologías (máx. 5).
- culture: señales de cultura, forma de trabajo y beneficios que aparecen en la oferta (máx. 5).
- questions_to_ask: 4 o 5 preguntas inteligentes que el candidato puede hacer en la entrevista, basadas en lo que la oferta no aclara.
- red_flags: cosas que conviene aclarar o que podrían ser un problema (requisitos contradictorios, salario ausente, exceso de funciones…). Lista vacía si no hay.
- general_knowledge: lo que sabes de la empresa por información general SOLO si es una empresa conocida y estás seguro (1 o 2 frases). Si no, texto vacío. Nunca inventes datos sobre empresas pequeñas.
- Fuera de general_knowledge usa solo lo que dice la oferta.

<oferta>
${JSON.stringify({ ...job, description: String(job.description).slice(0, 8000) })}
</oferta>`;

  const startedAt = Date.now();
  try {
    const result = await generateJson<Record<string, unknown>>({
      prompt,
      schema: SCHEMA,
    });
    await logAiCall({
      userId: user.id,
      functionName: "company-brief",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    const brief = {
      ...result.data,
      generated_at: new Date().toISOString(),
      prompt_version: PROMPT_VERSION,
    };
    await supabaseAdmin
      .from("jobs")
      .update({ company_brief: brief })
      .eq("id", jobId)
      .eq("user_id", user.id);
    return json(brief);
  } catch (error) {
    return aiErrorResponse(error, "company-brief");
  }
});
