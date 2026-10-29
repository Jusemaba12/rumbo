-- Entrevistas y pruebas técnicas de cada proceso.

create type interview_kind as enum ('screening', 'technical', 'hr', 'final', 'other');
create type interview_outcome as enum ('pending', 'passed', 'failed');

create table interviews (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  application_id uuid not null references applications on delete cascade,
  kind interview_kind not null default 'screening',
  scheduled_at timestamptz not null,
  duration_minutes int not null default 60 check (duration_minutes between 5 and 600),
  location text not null default '',
  notes text not null default '',
  outcome interview_outcome not null default 'pending',
  created_at timestamptz not null default now()
);

create index on interviews (user_id, scheduled_at);
create index on interviews (application_id);

alter table interviews enable row level security;
create policy owner_all on interviews for all to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));
