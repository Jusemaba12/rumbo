// Lee un PDF de HV como lo haría un ATS: extrae el texto en orden de lectura
// con pdf.js (sin IA). La app comprueba después qué datos se reconocen.
// El worker se carga en el mismo hilo: en Edge Functions no hay Web Workers.
import "pdfjs-dist/legacy/build/pdf.worker.mjs";
import { getDocument } from "pdfjs-dist/legacy/build/pdf.mjs";
import {
  json,
  preflight,
  requireUser,
} from "../_shared/http.ts";

/** Una HV no debería pesar más; evita abusar de la función. */
const MAX_BYTES = 3 * 1024 * 1024;

/** Junta los trozos de texto: salto de línea cuando cambia la altura. */
// deno-lint-ignore no-explicit-any
function pageText(items: any[]): string {
  let out = "";
  let lastY: number | null = null;
  for (const item of items) {
    if (typeof item.str !== "string") continue;
    const y = item.transform?.[5] ?? 0;
    if (lastY !== null && Math.abs(y - lastY) > 2) out += "\n";
    else if (lastY !== null && !out.endsWith(" ") && !item.str.startsWith(" ")) {
      out += " ";
    }
    out += item.str;
    lastY = y;
  }
  return out;
}

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return preflight();
  if (request.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }
  const user = await requireUser(request);
  if (!user) return json({ error: "unauthorized" }, 401);

  let pdfBase64: unknown;
  try {
    ({ pdf_base64: pdfBase64 } = await request.json());
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  if (typeof pdfBase64 !== "string" || pdfBase64.length === 0) {
    return json({ error: "invalid_body" }, 400);
  }
  let data: Uint8Array;
  try {
    data = Uint8Array.from(atob(pdfBase64), (c) => c.charCodeAt(0));
  } catch {
    return json({ error: "invalid_body" }, 400);
  }
  if (data.length > MAX_BYTES) return json({ error: "too_large" }, 413);

  try {
    const doc = await getDocument({
      data,
      useSystemFonts: false,
      isEvalSupported: false,
    }).promise;
    const pages: string[] = [];
    for (let number = 1; number <= doc.numPages; number++) {
      const page = await doc.getPage(number);
      pages.push(pageText((await page.getTextContent()).items));
    }
    return json({ pages: doc.numPages, text: pages.join("\n") });
  } catch (error) {
    console.error("ats-read failed", error);
    return json({ error: "unreadable" }, 422);
  }
});
