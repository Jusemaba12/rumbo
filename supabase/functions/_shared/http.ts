import { createClient, type User } from "@supabase/supabase-js";

import { ExtractionError, ProviderError } from "./ai.ts";

export const supabaseAdmin = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

/** La versión web llama desde otro dominio: el navegador exige CORS. La
 * sesión va en el encabezado Authorization (sin cookies), así que «*» vale. */
export const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

export const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });

/** Respuesta a la consulta previa (OPTIONS) que hace el navegador. */
export const preflight = () => new Response("ok", { headers: corsHeaders });

/** Usuario dueño del token del encabezado Authorization, o nulo. */
export async function requireUser(request: Request): Promise<User | null> {
  const token = request.headers.get("Authorization")?.replace(/^Bearer /, "");
  if (!token) return null;
  const { data } = await supabaseAdmin.auth.getUser(token);
  return data.user;
}

/** Usos de IA por persona y día; se cambia con el secreto AI_DAILY_LIMIT. */
const AI_DAILY_LIMIT = Number(Deno.env.get("AI_DAILY_LIMIT") ?? "40");

/**
 * Corta la petición si la persona ya usó la IA AI_DAILY_LIMIT veces en las
 * últimas 24 horas, para que nadie agote la cuota gratuita compartida.
 * Devuelve la respuesta 429 que hay que enviar, o null si puede seguir.
 */
export async function aiQuotaExceeded(userId: string): Promise<Response | null> {
  const since = new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString();
  const { count, error } = await supabaseAdmin
    .from("ai_calls")
    .select("id", { count: "exact", head: true })
    .eq("user_id", userId)
    .gte("created_at", since);
  // Si no se puede contar, mejor dejar pasar que bloquear.
  if (error) {
    console.error("ai quota count failed", error.message);
    return null;
  }
  return (count ?? 0) >= AI_DAILY_LIMIT
    ? json({ error: "daily_limit", limit: AI_DAILY_LIMIT }, 429)
    : null;
}

/** Registra el gasto de una llamada de IA; un fallo aquí no rompe la petición. */
export async function logAiCall(entry: {
  userId: string;
  functionName: string;
  model: string;
  inputTokens: number;
  outputTokens: number;
  startedAt: number;
}) {
  const { error } = await supabaseAdmin.from("ai_calls").insert({
    user_id: entry.userId,
    function_name: entry.functionName,
    model: entry.model,
    input_tokens: entry.inputTokens,
    output_tokens: entry.outputTokens,
    duration_ms: Date.now() - entry.startedAt,
  });
  if (error) console.error("ai_calls insert failed", error.message);
}

/** Traduce los errores de IA a una respuesta que la app sabe mostrar. */
export function aiErrorResponse(error: unknown, functionName: string): Response {
  if (error instanceof ExtractionError) {
    return json({ error: error.code }, 422);
  }
  if (error instanceof ProviderError) {
    console.error(`${functionName}: AI provider ${error.code}`, error.message);
    switch (error.code) {
      case "rate_limited":
        return json({ error: "rate_limited" }, 429);
      case "busy":
        return json({ error: "ai_busy" }, 503);
      case "bad_request":
        return json({ error: "ai_bad_request", detail: error.message }, 422);
    }
  }
  console.error(`${functionName} failed`, error);
  // Solo lo ve el dueño de la cuenta; ayuda a diagnosticar fallos.
  return json({ error: "internal", detail: String(error) }, 500);
}
