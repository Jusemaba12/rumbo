// Filtro previo sin IA: decide qué ofertas merecen gastar una puntuación.
import type { RawJob, WorkMode } from "./sources.ts";

export interface Preferences {
  roles: string[];
  technologies: string[];
  workModes: WorkMode[];
  countries: string[];
}

/** Ofertas publicadas hace más de esto se ignoran. */
export const MAX_AGE_DAYS = 30;
/** Cuántas ofertas nuevas se puntúan por búsqueda (una sola llamada de IA). */
export const MAX_TO_SCORE = 12;
/** Coincidencia mínima: una tecnología en el título, o dos en el texto. */
export const MIN_KEYWORD_SCORE = 2;

/** Regiones que incluyen Colombia y al resto de Latinoamérica. */
const OPEN_REGION =
  /(^|[^a-z])(worldwide|anywhere|global|latam|latin america|south america|americas|amer|todo el mundo|latinoamerica)([^a-z]|$)/;
/** Palabras que solo dicen «remoto», sin limitar países. */
const PLAIN_REMOTE = new Set(["remote", "remoto", "fully remote", "100% remote"]);

/** Igual que Job.dedupeKey en la app. */
export function dedupeKey(job: Pick<RawJob, "company" | "title" | "location">) {
  return [job.company, job.title, job.location]
    .map((part) => part.trim().toLowerCase())
    .join("|");
}

const normalize = (value: string) =>
  value.toLowerCase().normalize("NFD").replace(/\p{Diacritic}/gu, "");

/** Términos para consultar a los portales: tecnologías primero, luego cargos. */
export function buildQueries(prefs: Preferences): string[] {
  const terms = [...prefs.technologies, ...prefs.roles]
    .map((term) => term.trim())
    .filter(Boolean);
  return [...new Set(terms.map((t) => t.toLowerCase()))].slice(0, 2);
}

/**
 * Puntos por coincidencias de texto; 0 = descartar.
 * El título pesa más que la descripción.
 */
export function keywordScore(job: RawJob, prefs: Preferences): number {
  const title = normalize(job.title);
  const body = normalize(`${job.tags.join(" ")} ${job.description}`);
  let score = 0;
  for (const tech of prefs.technologies) {
    const term = normalize(tech.trim());
    if (!term) continue;
    if (title.includes(term)) score += 3;
    else if (body.includes(term)) score += 1;
  }
  for (const role of prefs.roles) {
    const words = normalize(role).split(/\s+/).filter((w) => w.length > 3);
    if (words.length && words.every((w) => title.includes(w))) score += 2;
  }
  return score;
}

export function passesFilters(
  job: RawJob,
  prefs: Preferences,
  now: Date,
): boolean {
  if (!job.title || !job.company || !job.url) return false;
  if (job.publishedAt) {
    const ageDays = (now.getTime() - job.publishedAt.getTime()) / 86_400_000;
    if (ageDays > MAX_AGE_DAYS) return false;
  }
  if (prefs.workModes.length && job.workMode &&
    !prefs.workModes.includes(job.workMode)) {
    return false;
  }
  return locationAllowed(job, prefs.countries);
}

/**
 * Presencial o híbrido: la ubicación debe incluir uno de los países.
 * Remoto: vale si está abierto (mundial, LATAM, América) o incluye un país;
 * un remoto «solo desde Estados Unidos» no sirve desde Colombia.
 */
export function locationAllowed(
  job: Pick<RawJob, "location" | "workMode">,
  countries: string[],
): boolean {
  if (!countries.length) return true;
  const location = normalize(job.location).trim();
  if (countries.some((c) => location.includes(normalize(c)))) return true;
  if (job.workMode !== "remote") return false;
  if (location === "" || OPEN_REGION.test(location)) return true;
  // «Remote» solo es abierto si no va acompañado de un país: «Remote, France»
  // es remoto desde Francia.
  return location
    .split(/[,;|/()–-]+/)
    .map((part) => part.trim())
    .filter(Boolean)
    .every((part) => PLAIN_REMOTE.has(part));
}

/** Selecciona las mejores ofertas nuevas para puntuar. */
export function pickCandidates(
  jobs: RawJob[],
  prefs: Preferences,
  knownKeys: Set<string>,
  now: Date,
): RawJob[] {
  const seen = new Set(knownKeys);
  const candidates: { job: RawJob; score: number }[] = [];
  for (const job of jobs) {
    const key = dedupeKey(job);
    if (seen.has(key)) continue;
    seen.add(key);
    if (!passesFilters(job, prefs, now)) continue;
    const score = keywordScore(job, prefs);
    if (score >= MIN_KEYWORD_SCORE) candidates.push({ job, score });
  }
  candidates.sort((a, b) =>
    b.score - a.score ||
    (b.job.publishedAt?.getTime() ?? 0) - (a.job.publishedAt?.getTime() ?? 0)
  );
  // Reparto por turnos entre portales para que no domine uno solo.
  const bySource = new Map<string, RawJob[]>();
  for (const { job } of candidates) {
    bySource.set(job.source, [...(bySource.get(job.source) ?? []), job]);
  }
  const queues = [...bySource.values()];
  const picked: RawJob[] = [];
  while (picked.length < MAX_TO_SCORE && queues.some((q) => q.length)) {
    for (const queue of queues) {
      const next = queue.shift();
      if (next && picked.length < MAX_TO_SCORE) picked.push(next);
    }
  }
  return picked;
}
