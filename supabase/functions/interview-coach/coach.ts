export const PROMPT_VERSION = "interview-coach/v1";

export const MODES = ["technical", "behavioral", "mixed"] as const;
export type Mode = (typeof MODES)[number];

export const DEFAULT_QUESTIONS = 5;
export const MAX_QUESTIONS = 10;
export const MAX_ANSWER_CHARS = 4000;

export interface Turn {
  question: string;
  answer: string;
}

export interface Feedback {
  score: number;
  strengths: string[];
  improve: string[];
  better_answer: string;
}

export interface Summary {
  score: number;
  overall: string;
  strengths: string[];
  improve: string[];
}

export interface CoachOutput {
  feedback: Feedback | null;
  next_question: string | null;
  summary: Summary | null;
}

const strings = { type: "array", items: { type: "string" } };
const score = { type: "integer", minimum: 1, maximum: 5 };

export const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["feedback", "next_question", "summary"],
  properties: {
    feedback: {
      anyOf: [
        { type: "null" },
        {
          type: "object",
          additionalProperties: false,
          required: ["score", "strengths", "improve", "better_answer"],
          properties: {
            score,
            strengths: strings,
            improve: strings,
            better_answer: { type: "string" },
          },
        },
      ],
    },
    next_question: { anyOf: [{ type: "string" }, { type: "null" }] },
    summary: {
      anyOf: [
        { type: "null" },
        {
          type: "object",
          additionalProperties: false,
          required: ["score", "overall", "strengths", "improve"],
          properties: {
            score,
            overall: { type: "string" },
            strengths: strings,
            improve: strings,
          },
        },
      ],
    },
  },
};

const MODE_TEXT: Record<Mode, string> = {
  technical:
    "técnicas: arquitectura, gestión de estado, rendimiento, pruebas, APIs y decisiones de diseño relacionadas con los requisitos de la oferta",
  behavioral:
    "de comportamiento: trabajo en equipo, conflictos, errores, logros, motivación y adaptación (método STAR)",
  mixed: "alternando técnicas y de comportamiento",
};

export function buildPrompt(input: {
  profile: unknown;
  job: unknown;
  mode: Mode;
  language: "es" | "en";
  turns: Turn[];
  totalQuestions: number;
}): string {
  const { turns, totalQuestions } = input;
  const answered = turns.length;
  const finished = answered >= totalQuestions;
  const language = input.language === "en" ? "inglés" : "español";
  return `Eres un entrevistador experimentado para esta oferta y, a la vez, un coach que ayuda al candidato a mejorar. La entrevista es en ${language} y tiene ${totalQuestions} preguntas ${MODE_TEXT[input.mode]}.

Ya se hicieron ${answered} preguntas (abajo, con las respuestas del candidato).

Devuelve:
- feedback: ${
    answered === 0
      ? "null (aún no hay respuestas)."
      : `evaluación de la ÚLTIMA respuesta: score de 1 a 5 (5 = respuesta que haría avanzar al candidato), strengths y improve concretos y breves, y better_answer: una versión mejorada de su respuesta, en primera persona y en ${language}.`
  }
- next_question: ${
    finished
      ? "null (la entrevista terminó)."
      : `la pregunta ${answered + 1} de ${totalQuestions}. Una sola pregunta, como la diría un entrevistador real, sin repetir temas anteriores y basada en los requisitos de la oferta. Si la respuesta anterior fue vaga, puedes repreguntar sobre ella.`
  }
- summary: ${
    finished
      ? "valoración global: score de 1 a 5, overall (2 o 3 frases en español), strengths e improve (máximo 4 cada uno)."
      : "null."
  }

Reglas para better_answer:
- Usa SOLO experiencia, tecnologías, cifras y logros que aparecen en el perfil o en lo que respondió el candidato. No inventes proyectos, empresas, cifras ni años de experiencia.
- Si al candidato le falta experiencia para responder bien, la mejor respuesta lo reconoce con honestidad y muestra cómo lo abordaría.
- strengths, improve y overall van siempre en español, para el candidato.

<perfil>
${JSON.stringify(input.profile)}
</perfil>

<oferta>
${JSON.stringify(input.job)}
</oferta>

<entrevista>
${JSON.stringify(turns)}
</entrevista>`;
}

/** Garantiza la forma que espera la app aunque el modelo se desvíe. */
export function normalizeOutput(
  output: CoachOutput,
  answered: number,
  totalQuestions: number,
): CoachOutput {
  const finished = answered >= totalQuestions;
  const clamp = (n: number) => Math.max(1, Math.min(5, Math.round(n || 1)));
  return {
    feedback: answered === 0 || !output.feedback
      ? null
      : { ...output.feedback, score: clamp(output.feedback.score) },
    next_question: finished ? null : (output.next_question?.trim() || null),
    summary: finished && output.summary
      ? { ...output.summary, score: clamp(output.summary.score) }
      : null,
  };
}
