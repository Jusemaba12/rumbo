-- Datos de contacto y estudios, necesarios para generar la HV en PDF.

alter table profiles
  add column email text not null default '',
  add column phone text not null default '';

create table education (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  institution text not null,
  degree text not null default '',
  start_date date,
  end_date date,
  position int not null default 0
);

create index on education (user_id);

alter table education enable row level security;
create policy owner_all on education for all to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));
