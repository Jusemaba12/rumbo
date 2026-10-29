// Reglas para aceptar una reescritura de logro: la IA no puede añadir cifras
// ni hechos; los datos que falten van como huecos entre corchetes.

export interface Suggestion {
  /** Índice del logro original; null si es un logro nuevo. */
  index: number | null;
  original: string;
  rewritten: string;
  reason: string;
}

/** Números fuera de los corchetes ([X %] es un hueco, no un dato). */
function numbersOutsidePlaceholders(text: string): string[] {
  return text.replace(/\[[^\]]*\]/g, " ").match(/\d+(?:[.,]\d+)?/g) ?? [];
}

/**
 * Acepta la propuesta solo si cada número que trae ya estaba en el original
 * y no es más larga de la cuenta. Devuelve el texto limpio o null.
 */
export function acceptRewrite(
  original: string,
  rewritten: string,
  maxLength = 240,
): string | null {
  const text = rewritten.replace(/\s+/g, " ").trim();
  if (!text || text.length > maxLength) return null;
  const known = new Set(numbersOutsidePlaceholders(original));
  for (const number of numbersOutsidePlaceholders(text)) {
    if (!known.has(number)) return null;
  }
  // Sin cambios no aporta nada.
  if (text.toLowerCase() === original.trim().toLowerCase()) return null;
  return text;
}
