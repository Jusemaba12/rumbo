export const PROMPT_VERSION = "tailor-resume/v2";

export interface ProfileExperience {
  id: string;
  company: string;
  role: string;
  start_date: string;
  end_date: string | null;
  achievements: string[];
  technologies: string[];
}

export interface ProfileInput {
  profile: { headline: string; summary: string; full_name: string } | null;
  experiences: ProfileExperience[];
  skills: { name: string }[];
  projects: { name: string; description: string; technologies: string[] }[];
}

/** Lo que devuelve el modelo, antes de validar. */
export interface ModelOutput {
  language: "es" | "en";
  headline: string;
  summary: string;
  experiences: {
    experience_id: string;
    bullets: { text: string; source_achievement: number | null }[];
  }[];
  skills: string[];
  cover_letter: string;
  changes: { section: string; before: string; after: string; reason: string }[];
  keywords: string[];
}

export interface TailoredResume {
  headline: string;
  summary: string;
  experiences: {
    experience_id: string;
    company: string;
    role: string;
    start_date: string;
    end_date: string | null;
    bullets: string[];
  }[];
  skills: string[];
}

export interface Validation {
  /** Frases descartadas por citar datos que no están en el perfil. */
  rejected: string[];
  summary_restored: boolean;
  headline_restored: boolean;
}

const strings = { type: "array", items: { type: "string" } };

export const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: [
    "language",
    "headline",
    "summary",
    "experiences",
    "skills",
    "cover_letter",
    "changes",
    "keywords",
  ],
  properties: {
    language: { type: "string", enum: ["es", "en"] },
    headline: { type: "string" },
    summary: { type: "string" },
    experiences: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["experience_id", "bullets"],
        properties: {
          experience_id: { type: "string" },
          bullets: {
            type: "array",
            items: {
              type: "object",
              additionalProperties: false,
              required: ["text", "source_achievement"],
              properties: {
                text: { type: "string" },
                source_achievement: {
                  anyOf: [{ type: "integer" }, { type: "null" }],
                },
              },
            },
          },
        },
      },
    },
    skills: strings,
    cover_letter: { type: "string" },
    changes: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["section", "before", "after", "reason"],
        properties: {
          section: { type: "string" },
          before: { type: "string" },
          after: { type: "string" },
          reason: { type: "string" },
        },
      },
    },
    keywords: strings,
  },
};

export function buildPrompt(profile: ProfileInput, job: unknown): string {
  return `Adapta la hoja de vida de este candidato a la oferta, para pasar filtros ATS y convencer a quien la lea.

Reglas obligatorias:
- Usa SOLO información del perfil. No inventes empresas, cargos, fechas, tecnologías, cifras ni logros. Si el perfil no lo dice, no lo escribas.
- Puedes reordenar, resumir y reformular, y usar el vocabulario de la oferta cuando describa lo mismo que el perfil (p. ej. "gestión de estado" para Riverpod).
- No exageres: mantén la duración real de la experiencia (no escribas "amplia experiencia", "experto" ni "senior" si el perfil no lo respalda) y no cambies el nivel del cargo.
- Escribe en el idioma de la oferta e indícalo en language (es o en; si no es ninguno de los dos, usa en).
- headline: titular profesional corto orientado a este puesto.
- summary: 3 o 4 frases con lo más relevante para la oferta.
- experiences: para cada experiencia del perfil (usa su id en experience_id), hasta 5 viñetas ordenadas por relevancia, empezando con un verbo de acción. En source_achievement pon el índice (desde 0) del logro del perfil en que se basa la viñeta, o null si se basa en el cargo o las tecnologías.
- skills: habilidades del perfil ordenadas por relevancia para la oferta. Solo nombres que estén en el perfil.
- cover_letter: carta de 180 a 250 palabras, concreta, sin frases hechas, que conecte 2 o 3 logros reales con lo que pide la oferta. Firma con el nombre del candidato.
- changes: los cambios más importantes respecto al perfil original. section es el nombre de la sección escrito para el candidato en español (Titular, Resumen, Experiencia, Habilidades); before, after y reason, breves.
- keywords: palabras clave de la oferta que la HV adaptada ya cubre.

<perfil>
${JSON.stringify(profile)}
</perfil>

<oferta>
${JSON.stringify(job)}
</oferta>`;
}

/** Números (cifras, porcentajes, años) que aparecen en un texto. */
export function numbersIn(text: string): string[] {
  return [...text.matchAll(/\d+(?:[.,]\d+)?/g)].map((m) =>
    m[0].replace(",", ".")
  );
}

/** Cada número de [text] debe aparecer en [source]. */
export function numbersSupported(text: string, source: string): boolean {
  const available = new Set(numbersIn(source));
  return numbersIn(text).every((n) => available.has(n));
}

/**
 * Aplica las reglas contra datos inventados y completa lo que el modelo
 * omitió: cada experiencia del perfil aparece, con sus datos originales.
 */
export function validate(
  profile: ProfileInput,
  output: ModelOutput,
): { resume: TailoredResume; validation: Validation } {
  const rejected: string[] = [];
  const profileText = JSON.stringify(profile);
  const byId = new Map(output.experiences.map((e) => [e.experience_id, e]));

  const experiences = profile.experiences.map((experience) => {
    const tailored = byId.get(experience.id);
    const context = [
      experience.role,
      experience.company,
      ...experience.technologies,
    ].join(" ");
    const bullets: string[] = [];
    for (const bullet of tailored?.bullets ?? []) {
      const index = bullet.source_achievement;
      const source = index !== null && index >= 0 &&
          index < experience.achievements.length
        ? experience.achievements[index]
        : experience.achievements.join(" ");
      if (numbersSupported(bullet.text, `${source} ${context}`)) {
        bullets.push(bullet.text.trim());
      } else {
        rejected.push(bullet.text);
        // Si citaba un logro concreto, se conserva el original.
        if (source && index !== null) bullets.push(source);
      }
    }
    return {
      experience_id: experience.id,
      company: experience.company,
      role: experience.role,
      start_date: experience.start_date,
      end_date: experience.end_date,
      bullets: bullets.length > 0
        ? [...new Set(bullets)]
        : experience.achievements,
    };
  });

  const known = new Map<string, string>();
  for (const skill of profile.skills) known.set(skill.name.toLowerCase(), skill.name);
  for (const experience of profile.experiences) {
    for (const tech of experience.technologies) {
      if (!known.has(tech.toLowerCase())) known.set(tech.toLowerCase(), tech);
    }
  }
  const skills: string[] = [];
  for (const name of output.skills) {
    const match = known.get(name.trim().toLowerCase());
    if (match && !skills.includes(match)) skills.push(match);
    else if (!match) rejected.push(name);
  }
  for (const skill of profile.skills) {
    if (!skills.includes(skill.name)) skills.push(skill.name);
  }

  const original = profile.profile ?? { headline: "", summary: "" };
  const summaryOk = numbersSupported(output.summary, profileText);
  const headlineOk = numbersSupported(output.headline, profileText);
  if (!summaryOk) rejected.push(output.summary);
  if (!headlineOk) rejected.push(output.headline);

  return {
    resume: {
      headline: headlineOk ? output.headline.trim() : original.headline,
      summary: summaryOk ? output.summary.trim() : original.summary,
      experiences,
      skills,
    },
    validation: {
      rejected,
      summary_restored: !summaryOk,
      headline_restored: !headlineOk,
    },
  };
}
