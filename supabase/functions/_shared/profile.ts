import { supabaseAdmin } from "./http.ts";

/** Perfil resumido para que la IA puntúe ofertas (sin ids internos). */
export async function loadProfile(userId: string) {
  const select = (table: string) =>
    supabaseAdmin.from(table).select("*").eq("user_id", userId);
  const [profile, experiences, skills] = await Promise.all([
    select("profiles"),
    select("experiences"),
    select("skills"),
  ]);
  const strip = (rows: Record<string, unknown>[] | null) =>
    (rows ?? []).map(({ id: _id, user_id: _u, ...rest }) => rest);
  const row = profile.data?.[0];
  return {
    headline: row?.headline ?? "",
    summary: row?.summary ?? "",
    location: row?.location ?? "",
    languages: row?.languages ?? [],
    salary_cop_min: row?.salary_cop_min ?? null,
    salary_cop_max: row?.salary_cop_max ?? null,
    salary_usd_min: row?.salary_usd_min ?? null,
    salary_usd_max: row?.salary_usd_max ?? null,
    experiences: strip(experiences.data),
    skills: (skills.data ?? []).map((s) => s.name),
  };
}
