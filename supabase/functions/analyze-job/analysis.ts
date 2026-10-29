import { PROFILE_RULES } from "../_shared/profile_rules.ts";

export const PROMPT_VERSION = "analyze-job/v1";

/** Por debajo de esto no hay suficiente texto para analizar la oferta. */
export const MIN_DESCRIPTION_CHARS = 200;
export const MAX_DESCRIPTION_CHARS = 20_000;

export interface JobAnalysis {
  job: {
    title: string;
    company: string;
    location: string;
    work_mode: "remote" | "hybrid" | "onsite" | null;
    requirements: string[];
    salary_min: number | null;
    salary_max: number | null;
    salary_currency: string | null;
    recruiter_name: string | null;
    recruiter_email: string | null;
    recruiter_linkedin: string | null;
    apply_method: "email" | "direct_message" | "portal" | null;
    apply_subject: string | null;
    asks_salary: boolean;
  };
  match: {
    score: number;
    met: string[];
    missing: string[];
    explanation: string;
  };
}

const strings = { type: "array", items: { type: "string" } };
const nullableNumber = { anyOf: [{ type: "number" }, { type: "null" }] };
const nullableString = { anyOf: [{ type: "string" }, { type: "null" }] };

export const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["job", "match"],
  properties: {
    job: {
      type: "object",
      additionalProperties: false,
      required: [
        "title",
        "company",
        "location",
        "work_mode",
        "requirements",
        "salary_min",
        "salary_max",
        "salary_currency",
        "recruiter_name",
        "recruiter_email",
        "recruiter_linkedin",
        "apply_method",
        "apply_subject",
        "asks_salary",
      ],
      properties: {
        title: { type: "string" },
        company: { type: "string" },
        location: { type: "string" },
        work_mode: {
          anyOf: [
            { type: "string", enum: ["remote", "hybrid", "onsite"] },
            { type: "null" },
          ],
        },
        requirements: strings,
        salary_min: nullableNumber,
        salary_max: nullableNumber,
        salary_currency: { anyOf: [{ type: "string" }, { type: "null" }] },
        recruiter_name: nullableString,
        recruiter_email: nullableString,
        recruiter_linkedin: nullableString,
        apply_method: {
          anyOf: [
            { type: "string", enum: ["email", "direct_message", "portal"] },
            { type: "null" },
          ],
        },
        apply_subject: nullableString,
        asks_salary: { type: "boolean" },
      },
    },
    match: {
      type: "object",
      additionalProperties: false,
      required: ["score", "met", "missing", "explanation"],
      properties: {
        score: { type: "integer", minimum: 0, maximum: 100 },
        met: strings,
        missing: strings,
        explanation: { type: "string" },
      },
    },
  },
};

export function buildPrompt(profile: unknown, jobText: string): string {
  return `Analiza esta oferta de empleo para un candidato concreto.

1. Extrae los datos de la oferta:
- title, company, location: tal como aparecen; texto vacío si no aparecen.
- work_mode: remote, hybrid u onsite solo si la oferta lo indica; si no, null.
- requirements: requisitos y tecnologías pedidas, uno por elemento, frases cortas.
- salary_min, salary_max, salary_currency (código ISO, p. ej. USD, COP): solo si la oferta da cifras; si no, null. Un salario único va en los dos campos.
- recruiter_name, recruiter_email, recruiter_linkedin: la persona o el correo de contacto que da la publicación, copiados tal cual (recruiter_linkedin es un enlace de linkedin.com al perfil o a la publicación); null si no aparecen. No los inventes.
- apply_method: email si piden enviar la HV a un correo, direct_message si piden escribir por mensaje directo o comentar la publicación, portal si hay que postular en una web o formulario; null si no se sabe.
- apply_subject: el asunto exacto que piden para el correo, copiado tal cual; null si no piden uno.
- asks_salary: true si piden indicar la expectativa o aspiración salarial.

2. Evalúa la compatibilidad con el perfil del candidato:
- score de 0 a 100. Sé exigente: 85 o más solo si cumple casi todos los requisitos importantes; un requisito obligatorio que falta debe bajar mucho la nota.
- met: requisitos de la oferta que el perfil cumple, con la evidencia breve (p. ej. "Flutter: 2 años en GSE").
- missing: requisitos que el perfil no demuestra.
- explanation: 2 o 3 frases en español para el candidato: si le conviene postularse y qué destacar.
- Usa solo lo que aparece en el perfil. No supongas experiencia que no está escrita.
${PROFILE_RULES}

<perfil>
${JSON.stringify(profile)}
</perfil>

<oferta>
${jobText}
</oferta>`;
}

const normalize = (value: string) =>
  value.toLowerCase().replace(/\s+/g, " ").trim();

/**
 * Deja solo los datos de contacto que aparecen de verdad en el texto de la
 * oferta: la IA no puede inventarse un correo, un enlace ni un asunto.
 */
export function verifyContact(
  job: JobAnalysis["job"],
  text: string,
): JobAnalysis["job"] {
  const source = normalize(text);
  const present = (value: string | null) =>
    value && source.includes(normalize(value)) ? value.trim() : null;
  const email = present(job.recruiter_email);
  const linkedin = present(job.recruiter_linkedin);
  return {
    ...job,
    recruiter_name: present(job.recruiter_name),
    recruiter_email: email && /^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)
      ? email
      : null,
    recruiter_linkedin: linkedin && /linkedin\.com\//i.test(linkedin)
      ? linkedin
      : null,
    apply_subject: present(job.apply_subject),
    asks_salary: job.asks_salary === true,
  };
}
