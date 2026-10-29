// Propone reescribir los logros débiles de una experiencia (o redactar
// borradores si no tiene) con verbo de acción y huecos para las cifras
// reales. No guarda nada: el usuario completa los huecos y decide.
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
import { acceptRewrite, type Suggestion } from "./rewrite.ts";

const PROMPT_VERSION = "rewrite-achievements/v1";
const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["suggestions"],
  properties: {
    suggestions: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["index", "rewritten", "reason"],
        properties: {
          index: { type: ["integer", "null"] },
          rewritten: { type: "string" },
          reason: { type: "string" },
        },
      },
    },
  },
};

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return preflight();
  if (request.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }
  const user = await requireUser(request);
  if (!user) return json({ error: "unauthorized" }, 401);

  let experienceId: unknown;
  try {
    ({ experience_id: experienceId } = await request.json());
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  if (typeof experienceId !== "string") {
    return json({ error: "invalid_body" }, 400);
  }
  const { data: experience } = await supabaseAdmin
    .from("experiences")
    .select("company, role, achievements, technologies")
    .eq("id", experienceId)
    .eq("user_id", user.id)
    .maybeSingle();
  if (!experience) return json({ error: "not_found" }, 404);

  const overQuota = await aiQuotaExceeded(user.id);
  if (overQuota) return overQuota;

  const achievements: string[] = (experience.achievements ?? [])
    .map((a: unknown) => String(a).trim())
    .filter(Boolean);
  const prompt = `Eres un experto en hojas de vida para ATS. Mejora los logros de esta experiencia laboral.

Experiencia: ${JSON.stringify({
    cargo: experience.role,
    empresa: experience.company,
    tecnologias: experience.technologies ?? [],
    logros: achievements.map((text, index) => ({ index, text })),
  })}

${
    achievements.length === 0
      ? "No tiene logros: redacta 3 borradores (index: null) típicos de este cargo y estas tecnologías, para que la persona los adapte."
      : "Reescribe solo los logros débiles (sin cifras, que empiezan como tarea, en primera persona o demasiado largos); deja fuera los que ya están bien. Usa el index del original."
  }

Reglas estrictas:
- Empieza con un verbo de acción en pasado y primera persona sin sujeto («Reduje», «Lancé», «Automaticé», «Integré»).
- NUNCA inventes cifras, porcentajes, cantidades, nombres de clientes ni tecnologías que no estén en el original o en las tecnologías de la experiencia. Donde convendría una cifra que no está, pon un hueco entre corchetes para que la persona lo complete: [X %], [N usuarios], [N apps], [tiempo].
- Una sola frase, máximo 200 caracteres. Mismo idioma que el original.
- reason: en español, una frase corta de qué mejora (p. ej. «Empieza con verbo y pide el impacto medible»).
- Máximo 6 propuestas.`;

  const startedAt = Date.now();
  try {
    const result = await generateJson<{
      suggestions: { index: number | null; rewritten: string; reason: string }[];
    }>({ prompt, schema: SCHEMA });
    await logAiCall({
      userId: user.id,
      functionName: "rewrite-achievements",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    const suggestions: Suggestion[] = [];
    for (const item of result.data.suggestions.slice(0, 6)) {
      const index = typeof item.index === "number" &&
          item.index >= 0 && item.index < achievements.length
        ? item.index
        : null;
      // Sin logros solo valen borradores nuevos; con logros, solo mejoras.
      if ((index === null) !== (achievements.length === 0)) continue;
      const original = index === null ? "" : achievements[index];
      const rewritten = acceptRewrite(original, item.rewritten);
      if (rewritten) {
        suggestions.push({ index, original, rewritten, reason: item.reason });
      }
    }
    return json({ suggestions, prompt_version: PROMPT_VERSION });
  } catch (error) {
    return aiErrorResponse(error, "rewrite-achievements");
  }
});
