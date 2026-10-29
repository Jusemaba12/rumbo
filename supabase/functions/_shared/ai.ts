// Genera JSON con el proveedor de IA configurado en el secreto AI_PROVIDER:
// "gemini" (por defecto, nivel gratuito) o "claude". Con Gemini, si todos sus
// modelos están saturados, lentos o sin cuota, se usa Groq como respaldo
// (también gratuito) cuando existe el secreto GROQ_API_KEY.
import Anthropic from "@anthropic-ai/sdk";
import { ApiError, FinishReason, GoogleGenAI } from "@google/genai";

// Si uno está saturado se prueba el siguiente; todos con nivel gratuito.
// Los «lite» son menos precisos pero suelen tener más capacidad libre.
const GEMINI_MODELS = [
  "gemini-3.8-flash",
  "gemini-3.6-flash",
  "gemini-3.5-flash-lite",
];
const ATTEMPTS_PER_MODEL = 1;
const CLAUDE_MODEL = "claude-opus-5-5";

/** Respaldo: modelo de Groq con salida JSON estricta (cambiable con GROQ_MODEL). */
const GROQ_URL = "https://api.groq.com/openai/v1/chat/completions";
const GROQ_DEFAULT_MODEL = "openai/gpt-oss-120b";

/** Las funciones tienen ~150 s; se deja margen para guardar y responder. */
const TOTAL_BUDGET_MS = 120_000;
/** Lo que se reserva para Groq si Gemini no contesta. */
const GROQ_BUDGET_MS = 40_000;
/** Un modelo de Gemini que tarda más que esto se da por saturado. */
const GEMINI_TIMEOUT_MS = 45_000;

/** La respuesta del modelo no sirve (rechazo, cortada o sin JSON). */
export class ExtractionError extends Error {
  constructor(
    readonly code: "refused" | "truncated" | "invalid_output",
    message: string,
  ) {
    super(message);
  }
}

/** Error del proveedor que se traduce a una respuesta HTTP concreta. */
export class ProviderError extends Error {
  constructor(
    readonly code: "rate_limited" | "bad_request" | "busy",
    message: string,
  ) {
    super(message);
  }
}

export interface JsonResult<T> {
  data: T;
  model: string;
  inputTokens: number;
  outputTokens: number;
}

export interface JsonRequest {
  prompt: string;
  schema: Record<string, unknown>;
  /** PDF opcional que se envía antes del texto. */
  pdfBase64?: string;
}

export function generateJson<T>(request: JsonRequest): Promise<JsonResult<T>> {
  return Deno.env.get("AI_PROVIDER") === "claude"
    ? withClaude<T>(request)
    : withGemini<T>(request);
}

function parse<T>(text: string | undefined): T {
  try {
    return JSON.parse(text ?? "") as T;
  } catch {
    throw new ExtractionError("invalid_output", "La respuesta no es JSON.");
  }
}

const sleep = (ms: number) => new Promise((done) => setTimeout(done, ms));

/** Gemini tardó demasiado en responder. */
class TimeoutError extends Error {}

/**
 * Errores pasajeros de Google (saturación, caída, cuota por minuto agotada
 * o demasiado lento): se prueba el siguiente modelo o el respaldo.
 */
const isTransient = (error: unknown) =>
  error instanceof TimeoutError ||
  (error instanceof ProviderError && error.code === "rate_limited") ||
  (error instanceof ApiError && [500, 503, 504].includes(error.status));

/** Modelo retirado o inexistente: se salta al siguiente de la lista. */
const isModelGone = (error: unknown) =>
  error instanceof ApiError && error.status === 404;

function withTimeout<T>(promise: Promise<T>, ms: number): Promise<T> {
  let timer: number | undefined;
  return Promise.race([
    promise,
    new Promise<never>((_, reject) => {
      timer = setTimeout(
        () => reject(new TimeoutError(`Sin respuesta en ${ms} ms`)),
        ms,
      );
    }),
  ]).finally(() => clearTimeout(timer));
}

async function withGemini<T>(request: JsonRequest): Promise<JsonResult<T>> {
  const startedAt = Date.now();
  // Groq no lee PDF: con PDF solo hay Gemini.
  const fallback = Deno.env.get("GROQ_API_KEY") && !request.pdfBase64;
  const geminiBudget = TOTAL_BUDGET_MS - (fallback ? GROQ_BUDGET_MS : 0);
  let lastError: unknown;
  models: for (const model of GEMINI_MODELS) {
    for (let attempt = 0; attempt < ATTEMPTS_PER_MODEL; attempt++) {
      const remaining = geminiBudget - (Date.now() - startedAt);
      if (remaining < 5_000) break models;
      try {
        return await withTimeout(
          callGemini<T>(model, request),
          Math.min(GEMINI_TIMEOUT_MS, remaining),
        );
      } catch (error) {
        if (isModelGone(error)) {
          console.error(`Gemini ${model} ya no existe: quitarlo de la lista`);
          lastError = error;
          break;
        }
        if (!isTransient(error)) throw error;
        lastError = error;
        console.warn(`Gemini ${model} no disponible: ${String(error)}`);
        await sleep(500);
      }
    }
  }
  if (fallback) {
    console.warn("Gemini no disponible: se usa Groq");
    try {
      return await withTimeout(withGroq<T>(request), GROQ_BUDGET_MS);
    } catch (error) {
      if (error instanceof ExtractionError) throw error;
      console.error("Groq tampoco respondió", String(error));
      lastError = error;
    }
  }
  // Rate limit de Google sin respaldo: se avisa como límite, no saturación.
  if (lastError instanceof ProviderError && lastError.code === "rate_limited") {
    throw lastError;
  }
  throw new ProviderError("busy", String(lastError));
}

/** Llamada a Groq (API compatible con OpenAI) con salida JSON por esquema. */
async function withGroq<T>(request: JsonRequest): Promise<JsonResult<T>> {
  const model = Deno.env.get("GROQ_MODEL") || GROQ_DEFAULT_MODEL;
  const call = (strict: boolean) =>
    fetch(GROQ_URL, {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${Deno.env.get("GROQ_API_KEY")}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        model,
        messages: [{ role: "user", content: request.prompt }],
        response_format: {
          type: "json_schema",
          json_schema: { name: "respuesta", strict, schema: request.schema },
        },
        max_completion_tokens: 16000,
      }),
    });
  let response = await call(true);
  // Si el esquema no admite el modo estricto, se pide en modo flexible.
  if (response.status === 400) {
    console.warn("Groq rechazó el esquema estricto", await response.text());
    response = await call(false);
  }
  if (!response.ok) {
    throw new ProviderError(
      response.status === 400 ? "bad_request" : "busy",
      `Groq ${response.status}: ${(await response.text()).slice(0, 300)}`,
    );
  }
  // deno-lint-ignore no-explicit-any
  const body: any = await response.json();
  const choice = body.choices?.[0];
  if (choice?.finish_reason === "length") {
    throw new ExtractionError("truncated", "La respuesta quedó incompleta.");
  }
  return {
    data: parse<T>(choice?.message?.content),
    model: `groq/${body.model ?? model}`,
    inputTokens: body.usage?.prompt_tokens ?? 0,
    outputTokens: body.usage?.completion_tokens ?? 0,
  };
}

async function callGemini<T>(
  model: string,
  request: JsonRequest,
): Promise<JsonResult<T>> {
  const ai = new GoogleGenAI({ apiKey: Deno.env.get("GEMINI_API_KEY") });
  let response;
  try {
    response = await ai.models.generateContent({
      model,
      contents: [
        ...(request.pdfBase64
          ? [{
            inlineData: {
              mimeType: "application/pdf",
              data: request.pdfBase64,
            },
          }]
          : []),
        { text: request.prompt },
      ],
      config: {
        responseMimeType: "application/json",
        responseJsonSchema: request.schema,
        maxOutputTokens: 16000,
      },
    });
  } catch (error) {
    if (error instanceof ApiError && error.status === 429) {
      throw new ProviderError("rate_limited", error.message);
    }
    if (error instanceof ApiError && error.status === 400) {
      throw new ProviderError("bad_request", error.message);
    }
    throw error;
  }

  const finish = response.candidates?.[0]?.finishReason;
  if (finish === FinishReason.MAX_TOKENS) {
    throw new ExtractionError("truncated", "La respuesta quedó incompleta.");
  }
  if (finish && finish !== FinishReason.STOP) {
    throw new ExtractionError("refused", `El modelo se detuvo: ${finish}.`);
  }
  const usage = response.usageMetadata;
  return {
    data: parse<T>(response.text),
    model: response.modelVersion ?? model,
    inputTokens: usage?.promptTokenCount ?? 0,
    outputTokens: (usage?.candidatesTokenCount ?? 0) +
      (usage?.thoughtsTokenCount ?? 0),
  };
}

async function withClaude<T>(request: JsonRequest): Promise<JsonResult<T>> {
  const client = new Anthropic({ apiKey: Deno.env.get("ANTHROPIC_API_KEY") });
  let response;
  try {
    response = await client.beta.messages.create({
      model: CLAUDE_MODEL,
      max_tokens: 16000,
      output_config: {
        effort: "medium",
        format: { type: "json_schema", schema: request.schema },
      },
      betas: ["server-side-fallback-2026-07-01"],
      // Si el modelo rechaza la petición, Anthropic la repite con otro modelo.
      fallbacks: "default",
      messages: [
        {
          role: "user",
          content: [
            ...(request.pdfBase64
              ? [{
                type: "document" as const,
                source: {
                  type: "base64" as const,
                  media_type: "application/pdf" as const,
                  data: request.pdfBase64,
                },
              }]
              : []),
            { type: "text", text: request.prompt },
          ],
        },
      ],
    });
  } catch (error) {
    if (error instanceof Anthropic.RateLimitError) {
      throw new ProviderError("rate_limited", error.message);
    }
    if (error instanceof Anthropic.BadRequestError) {
      throw new ProviderError("bad_request", error.message);
    }
    throw error;
  }

  if (response.stop_reason === "refusal") {
    throw new ExtractionError("refused", "El modelo no procesó la petición.");
  }
  if (response.stop_reason === "max_tokens") {
    throw new ExtractionError("truncated", "La respuesta quedó incompleta.");
  }
  const text = response.content
    .flatMap((block) => (block.type === "text" ? [block.text] : []))
    .join("");
  return {
    data: parse<T>(text),
    model: response.model,
    inputTokens: response.usage.input_tokens,
    outputTokens: response.usage.output_tokens,
  };
}
