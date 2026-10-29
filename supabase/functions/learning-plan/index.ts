// Plan para aprender un tema del plan de aprendizaje: por qué importa, pasos,
// recursos gratuitos (con enlaces comprobados), un mini proyecto y las horas.
// Se guarda en learning_topics.plan.
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

const PROMPT_VERSION = "learning-plan/v1";
const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["why", "steps", "resources", "project", "hours"],
  properties: {
    why: { type: "string" },
    steps: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["title", "detail"],
        properties: { title: { type: "string" }, detail: { type: "string" } },
      },
    },
    resources: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["title", "url", "kind"],
        properties: {
          title: { type: "string" },
          url: { type: "string" },
          kind: { type: "string", enum: ["docs", "course", "video", "article"] },
        },
      },
    },
    project: { type: "string" },
    hours: { type: "integer" },
  },
};

/** El enlace responde (no inventado ni roto). */
async function reachable(url: string): Promise<boolean> {
  try {
    const parsed = new URL(url);
    if (parsed.protocol !== "https:") return false;
    const response = await fetch(url, {
      method: "GET",
      redirect: "follow",
      headers: { "User-Agent": "Mozilla/5.0 (Rumbo)" },
      signal: AbortSignal.timeout(6000),
    });
    await response.body?.cancel();
    return response.ok;
  } catch {
    return false;
  }
}

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return preflight();
  if (request.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }
  const user = await requireUser(request);
  if (!user) return json({ error: "unauthorized" }, 401);

  let topicId: unknown;
  try {
    ({ topic_id: topicId } = await request.json());
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  if (typeof topicId !== "string") return json({ error: "invalid_body" }, 400);

  const [{ data: topic }, { data: profile }, { data: skills }, { data: prefs }] =
    await Promise.all([
      supabaseAdmin
        .from("learning_topics")
        .select("topic")
        .eq("id", topicId)
        .eq("user_id", user.id)
        .maybeSingle(),
      supabaseAdmin
        .from("profiles")
        .select("headline")
        .eq("user_id", user.id)
        .maybeSingle(),
      supabaseAdmin.from("skills").select("name").eq("user_id", user.id),
      supabaseAdmin
        .from("search_preferences")
        .select("roles")
        .eq("user_id", user.id)
        .maybeSingle(),
    ]);
  if (!topic) return json({ error: "not_found" }, 404);

  const overQuota = await aiQuotaExceeded(user.id);
  if (overQuota) return overQuota;

  const prompt = `Prepara un plan breve y práctico para que una persona aprenda «${topic.topic}» y pueda demostrarlo en entrevistas de trabajo. Todo en español.

Contexto: ${JSON.stringify({
    titular: profile?.headline ?? "",
    cargos_que_busca: prefs?.roles ?? [],
    habilidades_actuales: (skills ?? []).map((s) => s.name).slice(0, 30),
  })}

- why: 1 o 2 frases de por qué lo piden en esos cargos.
- steps: 3 a 5 pasos concretos, ordenados, partiendo de lo que ya sabe (title corto; detail de 1 o 2 frases).
- resources: 3 recursos GRATUITOS con su URL exacta, priorizando documentación oficial (docs.flutter.dev, pub.dev, dart.dev, docs.github.com, developer.android.com, developer.apple.com) y cursos abiertos conocidos. Solo URLs que estés seguro de que existen; mejor la página principal de la documentación que una profunda que podría no existir.
- project: un mini proyecto de 1 a 3 frases que pueda enseñar en GitHub o mencionar como logro.
- hours: horas estimadas en total (número entero realista).`;

  const startedAt = Date.now();
  try {
    // deno-lint-ignore no-explicit-any
    const result = await generateJson<any>({ prompt, schema: SCHEMA });
    await logAiCall({
      userId: user.id,
      functionName: "learning-plan",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    // deno-lint-ignore no-explicit-any
    const candidates = (result.data.resources ?? []).slice(0, 5) as any[];
    const checks = await Promise.all(candidates.map((r) => reachable(r.url)));
    const plan = {
      why: result.data.why,
      steps: (result.data.steps ?? []).slice(0, 6),
      resources: candidates.filter((_, i) => checks[i]),
      project: result.data.project,
      hours: Math.max(1, Math.min(200, Number(result.data.hours) || 0)),
      generated_at: new Date().toISOString(),
      prompt_version: PROMPT_VERSION,
    };
    await supabaseAdmin
      .from("learning_topics")
      .update({ plan, updated_at: new Date().toISOString() })
      .eq("id", topicId)
      .eq("user_id", user.id);
    return json(plan);
  } catch (error) {
    return aiErrorResponse(error, "learning-plan");
  }
});
