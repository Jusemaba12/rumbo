// Recibe la HV en PDF (base64), la lee con IA y devuelve el perfil extraído.
// No guarda nada del perfil: la app lo muestra para revisarlo.
import { generateJson } from "../_shared/ai.ts";
import {
  aiErrorResponse,
  aiQuotaExceeded,
  json,
  logAiCall,
  preflight,
  requireUser,
} from "../_shared/http.ts";
import {
  type ExtractedProfile,
  INSTRUCTIONS,
  MAX_PDF_BYTES,
  SCHEMA,
} from "./resume_schema.ts";

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return preflight();
  if (request.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }
  const user = await requireUser(request);
  if (!user) return json({ error: "unauthorized" }, 401);
  const overQuota = await aiQuotaExceeded(user.id);
  if (overQuota) return overQuota;

  let pdfBase64: unknown;
  try {
    ({ pdf_base64: pdfBase64 } = await request.json());
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  if (typeof pdfBase64 !== "string" || pdfBase64.length === 0) {
    return json({ error: "invalid_body" }, 400);
  }
  // base64 ocupa 4/3 del tamaño original.
  if (pdfBase64.length * 0.75 > MAX_PDF_BYTES) {
    return json({ error: "file_too_large" }, 413);
  }

  const startedAt = Date.now();
  try {
    const result = await generateJson<ExtractedProfile>({
      prompt: INSTRUCTIONS,
      schema: SCHEMA,
      pdfBase64,
    });
    await logAiCall({
      userId: user.id,
      functionName: "import-resume",
      model: result.model,
      inputTokens: result.inputTokens,
      outputTokens: result.outputTokens,
      startedAt,
    });
    return json(result.data);
  } catch (error) {
    return aiErrorResponse(error, "import-resume");
  }
});
