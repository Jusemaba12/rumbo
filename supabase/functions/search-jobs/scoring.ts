import { PROFILE_RULES } from "../_shared/profile_rules.ts";
import type { RawJob } from "./sources.ts";

export const PROMPT_VERSION = "search-jobs/v1";

/** Recorte de cada descripción para que la llamada única no sea enorme. */
const DESCRIPTION_CHARS = 1500;

export interface ScoredJob {
  index: number;
  title: string;
  company: string;
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
          "requirements",
          "score",
          "met",
          "missing",
          "explanation",
        ],
        properties: {
          index: { type: "integer" },
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

export function buildPrompt(profile: unknown, jobs: RawJob[]): string {
  const list = jobs.map((job, index) => ({
    index,
    title: job.title,
    company: job.company,
    location: job.location,
    work_mode: job.workMode,
    description: job.description.slice(0, DESCRIPTION_CHARS),
  }));
  return `Evalúa la compatibilidad de cada oferta con este candidato. Devuelve un elemento por oferta con su mismo index.

Para cada oferta:
- requirements: hasta 8 requisitos o tecnologías que pide, frases cortas.
- score de 0 a 100. Sé exigente: 85 o más solo si cumple casi todos los requisitos importantes; un requisito obligatorio que falta baja mucho la nota.
- met: requisitos que el perfil cumple, con evidencia breve.
- missing: requisitos que el perfil no demuestra.
- explanation: 1 o 2 frases en español para el candidato.
- Usa solo lo que aparece en el perfil. No supongas experiencia que no está escrita.
${PROFILE_RULES}

<perfil>
${JSON.stringify(profile)}
</perfil>

<ofertas>
${JSON.stringify(list)}
</ofertas>`;
}
