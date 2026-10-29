-- Expectativa salarial del candidato (bruto mensual), en pesos y en dólares.
-- El nivel de idiomas va en profiles.languages (ya existía):
-- [{"language": "en", "level": "B2"}].
alter table profiles
  add column if not exists salary_cop_min bigint check (salary_cop_min >= 0),
  add column if not exists salary_cop_max bigint check (salary_cop_max >= 0),
  add column if not exists salary_usd_min integer check (salary_usd_min >= 0),
  add column if not exists salary_usd_max integer check (salary_usd_max >= 0);
