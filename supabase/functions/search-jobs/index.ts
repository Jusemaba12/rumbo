// Busca ofertas nuevas en portales públicos según las preferencias del
// usuario, las puntúa con IA en una sola llamada y guarda como sugerencias
// las que superan su nota mínima.
//
// Dos formas de llamarla:
// - Desde la app, con la sesión del usuario: busca para ese usuario.
// - Desde pg_cron, con el encabezado x-cron-secret: busca para cada usuario
//   con preferencias configuradas (búsqueda diaria).
import { generateJson } from "../_shared/ai.ts";
import {
  aiErrorResponse,
  aiQuotaExceeded,
  json,
  logAiCall,
  preflight,
  requireUser,
  supabaseAdmin,
} from "../_shared/http.ts";
import { loadProfile } from "../_shared/profile.ts";
import { buildQueries, dedupeKey, pickCandidates } from "./matching.ts";
import {
  buildPrompt,
  PROMPT_VERSION,
  SCHEMA,
  type ScoredJob,
} from "./scoring.ts";
import {
  BOARD_PROVIDERS,
  searchAll,
  SOURCES,
  type SourceId,
  type WatchedBoard,
} from "./sources.ts";

/** Evita repetir búsquedas seguidas (y gastar cuota de IA). */
const MIN_MINUTES_BETWEEN_RUNS = 10;

/** La búsqueda programada se salta a quien buscó hace menos de esto. */
const SCHEDULED_SKIP_HOURS = 3;

interface Summary {
  found: number;
  scored: number;
  suggested: number;
  failed_sources: string[];
}

// deno-lint-ignore no-explicit-any
type PreferencesRow = any;

const isConfigured = (row: PreferencesRow) =>
  !!row && row.roles.length + row.technologies.length > 0;

/** Busca y guarda sugerencias para un usuario. Lanza errores de IA. */
async function runSearch(
  userId: string,
  prefsRow: PreferencesRow,
): Promise<Summary> {
  const prefs = {
    roles: prefsRow.roles as string[],
    technologies: prefsRow.technologies as string[],
    workModes: prefsRow.work_modes as ("remote" | "hybrid" | "onsite")[],
    countries: prefsRow.countries as string[],
  };
  const sources = ((prefsRow.active_sources as string[]).length
    ? prefsRow.active_sources
    : SOURCES).filter((s: string) =>
      (SOURCES as readonly string[]).includes(s)
    ) as SourceId[];

  // Se marca antes de buscar para que dos peticiones seguidas no dupliquen.
  await supabaseAdmin
    .from("search_preferences")
    .update({ last_run_at: new Date().toISOString() })
    .eq("user_id", userId);

  const boards = (Array.isArray(prefsRow.watched_boards)
    ? prefsRow.watched_boards
    : []).filter((b: WatchedBoard) =>
      (BOARD_PROVIDERS as readonly string[]).includes(b?.provider) &&
      typeof b.token === "string" && /^[a-z0-9._-]+$/i.test(b.token)
    ) as WatchedBoard[];
  const { jobs: found, failed } = await searchAll(
    sources,
    buildQueries(prefs),
    boards,
  );
  const { data: known } = await supabaseAdmin
    .from("jobs")
    .select("dedupe_hash")
    .eq("user_id", userId);
  const candidates = pickCandidates(
    found,
    prefs,
    new Set((known ?? []).map((row) => row.dedupe_hash)),
    new Date(),
  );

  const summary: Summary = {
    found: found.length,
    scored: candidates.length,
    suggested: 0,
    failed_sources: failed,
  };
  if (candidates.length === 0) return summary;

  const startedAt = Date.now();
  const result = await generateJson<{ jobs: ScoredJob[] }>({
    prompt: buildPrompt(await loadProfile(userId), candidates),
    schema: SCHEMA,
  });
  await logAiCall({
    userId,
    functionName: "search-jobs",
    model: result.model,
    inputTokens: result.inputTokens,
    outputTokens: result.outputTokens,
    startedAt,
  });

  const minScore = prefsRow.min_score as number;
  for (const item of result.data.jobs) {
    const job = candidates[item.index];
    const score = Math.max(0, Math.min(100, Math.round(item.score)));
    if (!job || score < minScore) continue;
    const { data: inserted, error } = await supabaseAdmin
      .from("jobs")
      .insert({
        user_id: userId,
        source: job.source,
        external_id: job.externalId,
        url: job.url,
        dedupe_hash: dedupeKey(job),
        title: job.title,
        company: job.company,
        location: job.location,
        work_mode: job.workMode,
        description: job.description.slice(0, 20_000),
        requirements: item.requirements,
        salary_min: job.salaryMin,
        salary_max: job.salaryMax,
        salary_currency: job.salaryCurrency,
        published_at: job.publishedAt?.toISOString() ?? null,
        discovered: true,
      })
      .select("id")
      .single();
    if (error || !inserted) {
      // 23505: ya existía (otra búsqueda la guardó a la vez).
      if (error?.code !== "23505") console.error("insert job", error);
      continue;
    }
    await supabaseAdmin.from("job_matches").insert({
      job_id: inserted.id,
      user_id: userId,
      score,
      met: item.met,
      missing: item.missing,
      explanation: item.explanation,
      model: result.model,
      prompt_version: PROMPT_VERSION,
    });
    summary.suggested++;
  }
  return summary;
}

/** Búsqueda diaria: recorre a los usuarios con preferencias. */
async function runScheduled(): Promise<Response> {
  const { data: rows, error } = await supabaseAdmin
    .from("search_preferences")
    .select("*");
  if (error) return json({ error: "internal", detail: error.message }, 500);

  const cutoff = Date.now() - SCHEDULED_SKIP_HOURS * 3_600_000;
  const results: Record<string, unknown>[] = [];
  for (const row of rows ?? []) {
    if (!isConfigured(row)) continue;
    if (row.last_run_at && new Date(row.last_run_at).getTime() > cutoff) {
      results.push({ user_id: row.user_id, skipped: "recent" });
      continue;
    }
    try {
      results.push({ user_id: row.user_id, ...await runSearch(row.user_id, row) });
    } catch (error) {
      // Un usuario que falla (p. ej. IA saturada) no detiene a los demás.
      console.error("scheduled search failed", row.user_id, error);
      results.push({ user_id: row.user_id, error: String(error) });
    }
  }
  console.log("scheduled search", JSON.stringify(results));
  return json({ runs: results });
}

/** Compara en tiempo constante para no filtrar la clave por tiempos. */
function sameSecret(given: string | null, expected: string | undefined) {
  if (!given || !expected || given.length !== expected.length) return false;
  let diff = 0;
  for (let i = 0; i < given.length; i++) {
    diff |= given.charCodeAt(i) ^ expected.charCodeAt(i);
  }
  return diff === 0;
}

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return preflight();
  if (request.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }

  const cronSecret = request.headers.get("x-cron-secret");
  if (cronSecret !== null) {
    if (!sameSecret(cronSecret, Deno.env.get("CRON_SECRET"))) {
      return json({ error: "unauthorized" }, 401);
    }
    return runScheduled();
  }

  const user = await requireUser(request);
  if (!user) return json({ error: "unauthorized" }, 401);
  const overQuota = await aiQuotaExceeded(user.id);
  if (overQuota) return overQuota;

  const { data: prefsRow } = await supabaseAdmin
    .from("search_preferences")
    .select("*")
    .eq("user_id", user.id)
    .maybeSingle();
  if (!isConfigured(prefsRow)) {
    return json({ error: "no_preferences" }, 422);
  }
  const lastRun = prefsRow.last_run_at ? new Date(prefsRow.last_run_at) : null;
  if (
    lastRun &&
    Date.now() - lastRun.getTime() < MIN_MINUTES_BETWEEN_RUNS * 60_000
  ) {
    return json({ error: "too_soon", last_run_at: prefsRow.last_run_at }, 429);
  }

  try {
    return json(await runSearch(user.id, prefsRow));
  } catch (error) {
    return aiErrorResponse(error, "search-jobs");
  }
});
