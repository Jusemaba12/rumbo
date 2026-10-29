export const PROMPT_VERSION = "email-sync/v1";

/** Estados que un correo puede proponer. */
export const EMAIL_STATUSES = [
  "in_review",
  "technical_test",
  "interview",
  "offer",
  "rejected",
] as const;
export type EmailStatus = (typeof EMAIL_STATUSES)[number];

export interface IncomingMessage {
  id: string;
  from: string;
  subject: string;
  date: string;
  body: string;
}

export interface ActiveProcess {
  id: string;
  company: string;
  title: string;
}

export interface Classification {
  index: number;
  relevant: boolean;
  status: EmailStatus | "none";
  interview_at: string | null;
  summary: string;
}

export const MAX_MESSAGES = 20;
export const MAX_BODY_CHARS = 4000;

const normalize = (value: string) =>
  value.toLowerCase().normalize("NFD").replace(/\p{Diacritic}/gu, "");

/**
 * Proceso al que pertenece un correo: el nombre de la empresa debe aparecer
 * en el remitente, el asunto o el cuerpo. Si coinciden varios, gana el
 * nombre más largo (más específico).
 */
export function matchProcess(
  message: IncomingMessage,
  processes: ActiveProcess[],
): ActiveProcess | null {
  const text = normalize(`${message.from}\n${message.subject}\n${message.body}`);
  let best: ActiveProcess | null = null;
  for (const process of processes) {
    const company = normalize(process.company).trim();
    if (company.length < 3) continue;
    const pattern = new RegExp(
      `(^|[^a-z0-9])${company.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}([^a-z0-9]|$)`,
    );
    if (pattern.test(text) && (!best || company.length > best.company.length)) {
      best = process;
    }
  }
  return best;
}

export const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["results"],
  properties: {
    results: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["index", "relevant", "status", "interview_at", "summary"],
        properties: {
          index: { type: "integer" },
          relevant: { type: "boolean" },
          status: {
            type: "string",
            enum: [...EMAIL_STATUSES, "none"],
          },
          interview_at: { anyOf: [{ type: "string" }, { type: "null" }] },
          summary: { type: "string" },
        },
      },
    },
  },
};

export function buildPrompt(
  items: { message: IncomingMessage; process: ActiveProcess }[],
  timezone: string,
): string {
  const list = items.map(({ message, process }, index) => ({
    index,
    process: `${process.title} en ${process.company}`,
    from: message.from,
    subject: message.subject,
    date: message.date,
    body: message.body.slice(0, MAX_BODY_CHARS),
  }));
  return `Eres el asistente de un candidato que sigue sus procesos de selección. Para cada correo, decide si trata sobre ese proceso y qué significa.

- relevant: true solo si el correo es de la empresa o del reclutador sobre ese proceso. Boletines, publicidad, alertas de empleo genéricas y correos enviados por el propio candidato son false.
- status:
  - in_review: confirman que revisan la candidatura o piden más información.
  - technical_test: envían una prueba técnica o un ejercicio.
  - interview: invitan a una entrevista o la confirman.
  - offer: hacen una oferta de empleo.
  - rejected: descartan la candidatura.
  - none: no cambia nada (p. ej. acuse automático de recepción).
- interview_at: fecha y hora de la entrevista o del plazo de la prueba en ISO 8601 con zona horaria, solo si el correo da una fecha concreta. Si la hora no indica zona, asume ${timezone}. Si no hay fecha, null.
- summary: una frase en español para el candidato, con lo importante (qué piden y para cuándo).
- No inventes fechas ni datos que no estén en el correo.

<correos>
${JSON.stringify(list)}
</correos>`;
}
