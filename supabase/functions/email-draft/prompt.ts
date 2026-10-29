// Prompt del borrador de correo, separado para poder probarlo aparte.

export const KINDS = {
  follow_up:
    "Seguimiento educado de una postulación sin respuesta: recuerda el interés en el puesto, aporta en una frase por qué encaja y pregunta por el estado del proceso y los siguientes pasos.",
  thank_you:
    "Agradecimiento tras la entrevista: agradece el tiempo, menciona algo concreto de la conversación si está en las notas, refuerza el encaje en una frase y queda disponible.",
  rejection_reply:
    "Respuesta a un rechazo: agradece la respuesta con elegancia, pide brevemente retroalimentación y deja la puerta abierta para futuras vacantes.",
  application:
    "Postulación a la vacante: presentación breve del candidato (titular y 1 o 2 habilidades que pida el puesto), interés en el puesto, aviso de que adjunta su hoja de vida y disponibilidad para conversar.",
} as const;
export type Kind = keyof typeof KINDS;


export function buildEmailPrompt(
  kind: Kind,
  data: Record<string, unknown>,
  jobDescription: string,
): string {
  return `Redacta un correo breve y profesional de una persona que busca empleo.

Tipo: ${KINDS[kind]}

Datos:
${JSON.stringify(data)}

Reglas:
- Escribe en el idioma de la oferta (${
    /\b(the|and|with|you|we)\b/i.test(jobDescription)
      ? "parece inglés"
      : "parece español"
  }); si hay dudas, en español. Trato de usted en español salvo que el correo de la empresa tutee.
- Ortografía impecable, con todas las tildes («postulación», «gustaría», «selección»).
- 80 a 150 palabras. Sin relleno ni adulación. Nada de emojis.
- Para decir por qué encajas, menciona solo habilidades que estén en habilidades_del_candidato y que pida el puesto; si no coincide ninguna, no hables de habilidades. Los requisitos son de la oferta, no del candidato.
- No inventes hechos: ni nombres de personas que no aparezcan, ni fechas, ni logros que no estén en los datos. Si conoces el nombre de quien escribió, salúdalo por su nombre; si no, usa un saludo general.
- Firma con el nombre del candidato y, debajo, su teléfono si lo hay.
- subject: asunto corto y concreto con el puesto. Si responde a un correo de la empresa, usa «Re: » + su asunto. Si los datos traen asunto_exigido, el subject es exactamente ese texto, sin cambiar nada.
- Si los datos traen expectativa_salarial, inclúyela en una frase («Mi expectativa salarial es de …») con esas cifras exactas. Si piden_expectativa es true y no hay expectativa_salarial, escribe [tu expectativa salarial] para que el candidato la complete. Nunca inventes cifras.
- body: solo el texto del correo, con saltos de línea entre párrafos.`;
}

/**
 * Expectativa del candidato en la moneda que conviene para la oferta: USD si
 * la oferta paga o habla en dólares, si no COP. Nula si no la tiene.
 */
export function salaryExpectation(
  profile: Record<string, unknown> | null,
  job: { salary_currency?: string | null; description?: string | null },
): string | null {
  const number = (key: string) =>
    typeof profile?.[key] === "number" ? profile[key] as number : null;
  const wantsUsd = job.salary_currency === "USD" ||
    /\b(usd|us\$|d[oó]lares)\b/i.test(job.description ?? "");
  const pick = (currency: "cop" | "usd") => {
    const min = number(`salary_${currency}_min`);
    const max = number(`salary_${currency}_max`);
    if (min == null && max == null) return null;
    const format = (n: number) => n.toLocaleString("es-CO");
    const range = min != null && max != null && min !== max
      ? `${format(min)} - ${format(max)}`
      : format((min ?? max)!);
    return `${currency.toUpperCase()} ${range} mensuales`;
  };
  return wantsUsd ? pick("usd") ?? pick("cop") : pick("cop") ?? pick("usd");
}
