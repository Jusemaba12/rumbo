// Alertas de empleo de LinkedIn que llegan al Gmail del usuario. LinkedIn no
// tiene API pública de ofertas y no se puede leer su web con bots: solo se usa
// el correo que el propio usuario recibe.
//
// El formato del correo cambia con el idioma y con el tiempo, así que no se
// interpreta línea a línea: se sacan los enlaces a ofertas
// (linkedin.com/jobs/view/<número>), que son estables, con el texto que los
// acompaña, y la IA extrae cargo, empresa y ubicación. Solo se aceptan números
// de oferta que aparecen en el correo: la IA no puede inventarse ofertas.

import { PROFILE_RULES } from "../_shared/profile_rules.ts";

export const PROMPT_VERSION = "linkedin-alerts/v1";

/** Remitentes de las alertas de empleo de LinkedIn. */
export const ALERT_SENDERS = [
  "jobalerts-noreply@linkedin.com",
  "jobs-noreply@linkedin.com",
];

export const MAX_ALERT_MESSAGES = 10;
export const MAX_ALERT_BODY_CHARS = 20_000;

/** Ofertas que se puntúan por sincronización (una sola llamada de IA). */
export const MAX_ALERT_JOBS = 15;

/** Texto que acompaña a cada oferta en el correo. */
const CONTEXT_CHARS = 600;

export interface AlertJob {
  jobId: string;
  url: string;
  /** Texto del correo alrededor del enlace (cargo, empresa, ubicación…). */
  text: string;
  /** Fecha del correo. */
  receivedAt: Date | null;
}

const JOB_LINK =
  /https?:\/\/(?:[a-z]{2,3}\.)?(?:www\.)?linkedin\.com\/(?:comm\/)?jobs\/view\/(?:[\w%-]*?-)?(\d{6,12})\b[^\s<>")\]]*/gi;
const ANY_LINK = /https?:\/\/[^\s<>")\]]+/g;

function cleanText(value: string): string {
  return value
    .replace(ANY_LINK, " ")
    .replace(/[-–—_=*·•|]{3,}/g, " ")
    .replace(/[ \t]+/g, " ")
    .replace(/\s*\n\s*/g, "\n")
    .replace(/\n{2,}/g, "\n")
    .trim();
}

/**
 * Ofertas que menciona un correo de alerta, en orden. Un mismo número puede
 * aparecer varias veces (logo, título, «Ver empleo»): se juntan sus textos.
 */
export function extractAlertJobs(
  body: string,
  receivedAt: Date | null = null,
): AlertJob[] {
  const jobs = new Map<string, AlertJob>();
  let previousEnd = 0;
  for (const match of body.matchAll(JOB_LINK)) {
    const jobId = match[1];
    const before = cleanText(body.slice(previousEnd, match.index))
      .slice(-CONTEXT_CHARS);
    previousEnd = (match.index ?? 0) + match[0].length;
    const current = jobs.get(jobId);
    if (current) {
      if (before && !current.text.includes(before)) {
        current.text = `${current.text}\n${before}`.slice(0, CONTEXT_CHARS);
      }
      continue;
    }
    jobs.set(jobId, {
      jobId,
      url: `https://www.linkedin.com/jobs/view/${jobId}/`,
      text: before,
      receivedAt,
    });
  }
  return [...jobs.values()];
}

export interface ExtractedJob {
  index: number;
  is_job: boolean;
  title: string;
  company: string;
  location: string;
  work_mode: "remote" | "hybrid" | "onsite" | "unknown";
  requirements: string[];
  score: number;
  met: string[];
  missing: string[];
  explanation: string;
}

const strings = { type: "array", items: { type: "string" } };

export const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["jobs"],
  properties: {
    jobs: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: [
          "index",
          "is_job",
          "title",
          "company",
          "location",
          "work_mode",
          "requirements",
          "score",
          "met",
          "missing",
          "explanation",
        ],
        properties: {
          index: { type: "integer" },
          is_job: { type: "boolean" },
          title: { type: "string" },
          company: { type: "string" },
          location: { type: "string" },
          work_mode: {
            type: "string",
            enum: ["remote", "hybrid", "onsite", "unknown"],
          },
          requirements: strings,
          score: { type: "integer", minimum: 0, maximum: 100 },
          met: strings,
          missing: strings,
          explanation: { type: "string" },
        },
      },
    },
  },
};

export function buildPrompt(profile: unknown, jobs: AlertJob[]): string {
  const list = jobs.map((job, index) => ({ index, text: job.text }));
  return `Estos fragmentos vienen de correos de alertas de empleo de LinkedIn. Cada uno acompaña al enlace de una oferta. Devuelve un elemento por fragmento con su mismo index.

Para cada fragmento:
- is_job: false si no describe una oferta concreta (pie del correo, «ver todas», publicidad). En ese caso deja el resto vacío y score 0.
- title, company, location: tal como aparecen en el fragmento. Si no aparece, cadena vacía. No inventes.
- work_mode: remote, hybrid u onsite si el fragmento lo dice (Remoto, En remoto, Híbrido, Presencial, Remote, Hybrid, On-site); si no, unknown.
- requirements: lo que se deduzca del cargo (por ejemplo Flutter, Dart, móvil), como mucho 6 frases cortas.
- score de 0 a 100 según el cargo y el perfil. Solo hay el título: sé prudente; más de 80 solo si el cargo encaja de lleno con la experiencia del candidato.
- met y missing: breves, a partir del cargo y del perfil.
- explanation: 1 frase en español; di que la nota sale del título porque el correo no trae la descripción completa.
- Usa solo lo que aparece en el perfil. No supongas experiencia que no está escrita.
${PROFILE_RULES}

<perfil>
${JSON.stringify(profile)}
</perfil>

<fragmentos>
${JSON.stringify(list)}
</fragmentos>`;
}

export function workModeOf(
  value: ExtractedJob["work_mode"],
): "remote" | "hybrid" | "onsite" | null {
  return value === "unknown" ? null : value;
}
