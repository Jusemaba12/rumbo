// Prepara un borrador de respuesta a una oferta con una contraoferta y los
// argumentos para defenderla. No envía nada: el usuario copia el texto.
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

interface Draft {
  email: string;
  talking_points: string[];
  risks: string[];
}

const strings = { type: "array", items: { type: "string" } };
const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["email", "talking_points", "risks"],
  properties: {
    email: { type: "string" },
    talking_points: strings,
    risks: strings,
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

  // deno-lint-ignore no-explicit-any
  let body: any;
  try {
    body = await request.json();
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  if (typeof body.application_id !== "string") {
    return json({ error: "invalid_body" }, 400);
  }
  const target = Number(body.target_salary);
  const priorities = typeof body.priorities === "string"
    ? body.priorities.slice(0, 1000)
    : "";
  const language = body.language === "en" ? "inglés" : "español";

  const [{ data: application }, { data: offer }, { data: profile }, { data: experiences }] =
    await Promise.all([
      supabaseAdmin
        .from("applications")
        .select("status, jobs(title, company, requirements, salary_min, salary_max, salary_currency)")
        .eq("id", body.application_id)
        .eq("user_id", user.id)
        .maybeSingle(),
      supabaseAdmin
        .from("job_offers")
        .select("salary, currency, period, work_mode, start_date, deadline, benefits, notes")
        .eq("application_id", body.application_id)
        .eq("user_id", user.id)
        .maybeSingle(),
      supabaseAdmin
        .from("profiles")
        .select("full_name, headline, summary")
        .eq("user_id", user.id)
        .maybeSingle(),
      supabaseAdmin
        .from("experiences")
        .select("company, role, start_date, end_date, achievements")
        .eq("user_id", user.id),
    ]);
  if (!application) return json({ error: "not_found" }, 404);

  const prompt = `Ayuda a este candidato a responder una oferta de empleo y negociar.

Escribe en ${language}:
- email: respuesta breve y cordial a la empresa (120-200 palabras). Agradece la oferta, muestra interés real y${
    Number.isFinite(target) && target > 0
      ? ` propone ${target} ${offer?.currency ?? ""} (mismo periodo que la oferta) como contraoferta`
      : " pide revisar las condiciones"
  }, justificándolo con 1 o 2 logros reales del perfil y con lo que pide el puesto.${
    priorities ? ` Ten en cuenta sus prioridades: ${priorities}.` : ""
  } Firma con su nombre. No uses frases hechas ni presiones con ultimátums.
- talking_points: 3 a 5 argumentos concretos para una llamada de negociación, en español.
- risks: 1 a 3 riesgos o cosas a confirmar antes de aceptar (en español).
- Usa SOLO datos del perfil y de la oferta. No inventes ofertas de otras empresas, cifras de mercado ni logros.

<oferta>
${JSON.stringify({ proceso: application, condiciones: offer })}
</oferta>

<perfil>
${JSON.stringify({ ...profile, experiencias: experiences })}
</perfil>`;

  const startedAt = Date.now();
  try {
    const result = await generateJson<Draft>({ prompt, schema: SCHEMA });
    await logAiCall({
      userId: user.id,
      functionName: "negotiation-draft",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    return json(result.data);
  } catch (error) {
    return aiErrorResponse(error, "negotiation-draft");
  }
});
