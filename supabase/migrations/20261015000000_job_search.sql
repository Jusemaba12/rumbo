-- Búsqueda automática de ofertas (fase 2).

-- Ofertas encontradas por la búsqueda y aún no guardadas por el usuario.
alter table jobs
  add column discovered boolean not null default false,
  add column dismissed boolean not null default false,
  add column external_id text;

create index on jobs (user_id, discovered, dismissed);

alter table search_preferences
  add column min_score int not null default 60 check (min_score between 0 and 100),
  add column last_run_at timestamptz;
