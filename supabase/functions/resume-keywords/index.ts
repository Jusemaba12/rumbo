// Palabras clave que los ATS buscan para los cargos objetivo del usuario.
// No dice cuáles tiene: eso lo comprueba la app buscando en la HV, para que
// la IA no pueda inventar que el usuario ya las tiene.
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

const PROMPT_VERSION = "resume-keywords/v2";
/** El resultado guardado sirve mientras no cambien los cargos ni pase esto. */
const CACHE_DAYS = 30;
const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["keywords"],
  properties: {
    keywords: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["keyword", "aliases", "importance", "reason"],
        properties: {
          keyword: { type: "string" },
          aliases: { type: "array", items: { type: "string" } },
          importance: { type: "string", enum: ["high", "medium"] },
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
  let force = false;
  try {
    force = (await request.json())?.force === true;
  } catch {
    // Sin cuerpo: usa lo guardado si sirve.
  }

  const [{ data: prefs }, { data: profile }] = await Promise.all([
    supabaseAdmin
      .from("search_preferences")
      .select("roles, technologies, countries")
      .eq("user_id", user.id)
      .maybeSingle(),
    supabaseAdmin
      .from("profiles")
      .select("headline")
      .eq("user_id", user.id)
      .maybeSingle(),
  ]);
  const roles: string[] = prefs?.roles?.length
    ? prefs.roles
    : profile?.headline
    ? [profile.headline]
    : [];
  if (roles.length === 0) return json({ error: "no_roles" }, 422);

  // Lo guardado sirve si los cargos son los mismos y no es muy antiguo.
  const sameRoles = (a: string[], b: string[]) =>
    JSON.stringify([...a].sort()) === JSON.stringify([...b].sort());
  if (!force) {
    const { data: cached } = await supabaseAdmin
      .from("resume_keywords")
      .select("roles, keywords, prompt_version, created_at")
      .eq("user_id", user.id)
      .maybeSingle();
    const fresh = cached &&
      Date.now() - Date.parse(cached.created_at) <
        CACHE_DAYS * 24 * 60 * 60 * 1000;
    if (
      fresh && sameRoles(cached.roles ?? [], roles) &&
      cached.prompt_version === PROMPT_VERSION
    ) {
      return json({
        roles,
        keywords: cached.keywords,
        prompt_version: PROMPT_VERSION,
        created_at: cached.created_at,
        cached: true,
      });
    }
  }
  const overQuota = await aiQuotaExceeded(user.id);
  if (overQuota) return overQuota;

  const prompt = `Eres reclutador técnico. Lista las 15 palabras clave que los sistemas ATS y los reclutadores buscan en una hoja de vida para estos cargos.

Cargos objetivo: ${JSON.stringify(roles.slice(0, 5))}
Tecnologías que ya trabaja la persona (contexto, no las repitas todas): ${JSON.stringify((prefs?.technologies ?? []).slice(0, 15))}
Mercado: ${JSON.stringify(prefs?.countries?.length ? prefs.countries : ["Latinoamérica"])}, trabajo remoto incluido.

Reglas:
- keyword: el término tal como aparece en las ofertas (tecnologías y herramientas en inglés: "Flutter", "CI/CD", "Unit testing"; metodologías y habilidades como se publiquen). Una o tres palabras como máximo, sin explicaciones.
- importance: "high" si aparece en la mayoría de ofertas de estos cargos; "medium" si es frecuente pero no imprescindible.
- aliases: otras formas en que aparece en ofertas y hojas de vida, en inglés y en español (p. ej. para "REST API": ["RESTful", "APIs REST", "REST"]; para "CI/CD": ["integración continua", "continuous integration", "GitHub Actions"]). Máximo 5; lista vacía si no hay.
- reason: una frase corta en español de por qué la piden.
- Mezcla tecnologías, prácticas (testing, arquitectura, CI/CD…) y habilidades. Nada de palabras vacías como "proactivo".
- Ordena de más a menos importante.`;

  const startedAt = Date.now();
  try {
    const result = await generateJson<{ keywords: unknown[] }>({
      prompt,
      schema: SCHEMA,
    });
    await logAiCall({
      userId: user.id,
      functionName: "resume-keywords",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    const keywords = result.data.keywords.slice(0, 20);
    const createdAt = new Date().toISOString();
    const { error: saveError } = await supabaseAdmin
      .from("resume_keywords")
      .upsert({
        user_id: user.id,
        roles,
        keywords,
        prompt_version: PROMPT_VERSION,
        created_at: createdAt,
      });
    // Sin la tabla (migración pendiente) se responde igual, sin guardar.
    if (saveError) console.error("resume_keywords save", saveError.message);
    return json({
      roles,
      keywords,
      prompt_version: PROMPT_VERSION,
      created_at: createdAt,
      cached: false,
    });
  } catch (error) {
    return aiErrorResponse(error, "resume-keywords");
  }
});
