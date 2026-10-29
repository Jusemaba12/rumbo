export const PROMPT_VERSION = "import-resume/v1";
export const MAX_PDF_BYTES = 5 * 1024 * 1024;

/** Lo que devuelve la extracción; coincide con ProfileData en la app. */
export interface ExtractedProfile {
  profile: {
    full_name: string;
    headline: string;
    summary: string;
    location: string;
    email: string;
    phone: string;
    links: { linkedin: string; github: string; portfolio: string };
  };
  education: {
    institution: string;
    degree: string;
    start_date: string | null;
    end_date: string | null;
  }[];
  experiences: {
    company: string;
    role: string;
    start_date: string;
    end_date: string | null;
    achievements: string[];
    technologies: string[];
  }[];
  projects: {
    name: string;
    description: string;
    url: string | null;
    technologies: string[];
  }[];
  skills: {
    name: string;
    category: "language" | "framework" | "tool" | "other";
    years: number | null;
  }[];
}

const stringArray = { type: "array", items: { type: "string" } };

export const SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["profile", "experiences", "projects", "skills", "education"],
  properties: {
    profile: {
      type: "object",
      additionalProperties: false,
      required: [
        "full_name",
        "headline",
        "summary",
        "location",
        "email",
        "phone",
        "links",
      ],
      properties: {
        full_name: { type: "string" },
        headline: { type: "string" },
        summary: { type: "string" },
        location: { type: "string" },
        email: { type: "string" },
        phone: { type: "string" },
        links: {
          type: "object",
          additionalProperties: false,
          required: ["linkedin", "github", "portfolio"],
          properties: {
            linkedin: { type: "string" },
            github: { type: "string" },
            portfolio: { type: "string" },
          },
        },
      },
    },
    experiences: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: [
          "company",
          "role",
          "start_date",
          "end_date",
          "achievements",
          "technologies",
        ],
        properties: {
          company: { type: "string" },
          role: { type: "string" },
          start_date: { type: "string" },
          end_date: { anyOf: [{ type: "string" }, { type: "null" }] },
          achievements: stringArray,
          technologies: stringArray,
        },
      },
    },
    projects: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["name", "description", "url", "technologies"],
        properties: {
          name: { type: "string" },
          description: { type: "string" },
          url: { anyOf: [{ type: "string" }, { type: "null" }] },
          technologies: stringArray,
        },
      },
    },
    education: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["institution", "degree", "start_date", "end_date"],
        properties: {
          institution: { type: "string" },
          degree: { type: "string" },
          start_date: { anyOf: [{ type: "string" }, { type: "null" }] },
          end_date: { anyOf: [{ type: "string" }, { type: "null" }] },
        },
      },
    },
    skills: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["name", "category", "years"],
        properties: {
          name: { type: "string" },
          category: {
            type: "string",
            enum: ["language", "framework", "tool", "other"],
          },
          years: { anyOf: [{ type: "integer" }, { type: "null" }] },
        },
      },
    },
  },
};

export const INSTRUCTIONS = `Extrae la información de esta hoja de vida para rellenar un perfil profesional.

Reglas:
- Copia solo lo que aparece en el documento. No inventes, no completes ni mejores nada: si un dato no está, deja el texto vacío, la lista vacía o null.
- Conserva el idioma original del documento y las cifras exactas de los logros.
- Fechas en formato YYYY-MM-01. Si solo aparece el año, usa el mes 01. Si el trabajo sigue en curso ("actualidad", "present"), end_date es null.
- achievements: un logro o responsabilidad por elemento, tal como aparece, sin viñetas.
- technologies: herramientas y tecnologías mencionadas en esa experiencia o proyecto.
- skills: cada habilidad técnica una sola vez. Categoría: language (lenguajes de programación), framework (frameworks y librerías), tool (herramientas, servicios, plataformas), other (el resto). years solo si el documento lo indica.
- email y phone: tal como aparecen en el documento; texto vacío si no están.
- education: estudios formales (universidad, técnico, bootcamp), con fechas como las de la experiencia; null si no aparecen.
- links: URL completas con https:// cuando aparezcan; si no, texto vacío.`;
