-- Esquema inicial de Rumbo (Fase 1: perfil, HV, ofertas y postulaciones).
-- Todas las tablas llevan user_id y seguridad por fila: cada usuario solo ve lo suyo.

create type application_status as enum (
  'saved', 'preparing', 'applied', 'in_review', 'technical_test',
  'interview', 'offer', 'accepted', 'declined', 'rejected', 'no_response'
);
create type work_mode as enum ('remote', 'hybrid', 'onsite');
create type event_origin as enum ('manual', 'email', 'system');

create table profiles (
  user_id uuid primary key references auth.users on delete cascade,
  full_name text not null default '',
  headline text not null default '',
  summary text not null default '',
  location text not null default '',
  timezone text not null default '',
  languages jsonb not null default '[]',
  links jsonb not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table experiences (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  company text not null,
  role text not null,
  start_date date not null,
  end_date date,
  achievements jsonb not null default '[]',
  technologies text[] not null default '{}',
  position int not null default 0
);

create table projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  name text not null,
  description text not null default '',
  url text,
  achievements jsonb not null default '[]',
  technologies text[] not null default '{}',
  position int not null default 0
);

create table skills (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  name text not null,
  category text not null default '',
  years int,
  unique (user_id, name)
);

create table search_preferences (
  user_id uuid primary key references auth.users on delete cascade,
  roles text[] not null default '{}',
  technologies text[] not null default '{}',
  min_salary numeric(12, 2),
  salary_currency text,
  work_modes work_mode[] not null default '{}',
  countries text[] not null default '{}',
  active_sources text[] not null default '{}'
);

create table jobs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  source text not null,
  url text,
  dedupe_hash text not null,
  title text not null,
  company text not null,
  location text not null default '',
  work_mode work_mode,
  description text not null default '',
  requirements jsonb not null default '[]',
  salary_min numeric(12, 2),
  salary_max numeric(12, 2),
  salary_currency text,
  published_at timestamptz,
  created_at timestamptz not null default now(),
  unique (user_id, dedupe_hash)
);

create table job_matches (
  job_id uuid primary key references jobs on delete cascade,
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  score int not null check (score between 0 and 100),
  met jsonb not null default '[]',
  missing jsonb not null default '[]',
  explanation text not null default '',
  model text not null,
  prompt_version text not null,
  created_at timestamptz not null default now()
);

-- job_id nulo = hoja de vida base.
create table resume_versions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  job_id uuid references jobs on delete set null,
  content jsonb not null,
  changes jsonb not null default '[]',
  ats_score int check (ats_score between 0 and 100),
  pdf_path text,
  created_at timestamptz not null default now()
);

create table applications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  job_id uuid not null unique references jobs on delete cascade,
  resume_version_id uuid references resume_versions on delete set null,
  status application_status not null default 'saved',
  cover_letter text,
  notes text not null default '',
  applied_at timestamptz,
  next_follow_up_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table application_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  application_id uuid not null references applications on delete cascade,
  from_status application_status,
  to_status application_status not null,
  origin event_origin not null default 'manual',
  note text,
  created_at timestamptz not null default now()
);

-- Registro de gasto de IA; solo lo escriben las funciones del servidor.
create table ai_calls (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users on delete cascade,
  function_name text not null,
  model text not null,
  input_tokens int not null,
  output_tokens int not null,
  duration_ms int not null,
  created_at timestamptz not null default now()
);

create index on experiences (user_id);
create index on projects (user_id);
create index on jobs (user_id, created_at desc);
create index on resume_versions (user_id, job_id);
create index on applications (user_id, status);
create index on application_events (application_id, created_at);
create index on ai_calls (user_id, created_at);

-- Seguridad por fila.
do $$
declare t text;
begin
  foreach t in array array[
    'profiles', 'experiences', 'projects', 'skills', 'search_preferences',
    'jobs', 'job_matches', 'resume_versions', 'applications', 'application_events'
  ] loop
    execute format('alter table %I enable row level security', t);
    execute format(
      'create policy owner_all on %I for all to authenticated
         using (user_id = (select auth.uid()))
         with check (user_id = (select auth.uid()))', t);
  end loop;
end $$;

alter table ai_calls enable row level security;
create policy owner_read on ai_calls for select to authenticated
  using (user_id = (select auth.uid()));

-- Mantiene updated_at.
create function set_updated_at() returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end $$;

create trigger profiles_updated_at before update on profiles
  for each row execute function set_updated_at();
create trigger applications_updated_at before update on applications
  for each row execute function set_updated_at();

-- Cada cambio de estado queda en el historial.
create function log_application_status() returns trigger
language plpgsql security invoker as $$
begin
  if tg_op = 'INSERT' then
    insert into application_events (user_id, application_id, to_status)
    values (new.user_id, new.id, new.status);
  elsif new.status is distinct from old.status then
    insert into application_events (user_id, application_id, from_status, to_status)
    values (new.user_id, new.id, old.status, new.status);
  end if;
  return new;
end $$;

create trigger applications_status_log after insert or update on applications
  for each row execute function log_application_status();
