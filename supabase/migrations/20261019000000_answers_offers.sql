-- Banco de respuestas y detalles de las ofertas recibidas (fase 4).

create table answer_bank (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  question text not null,
  answer text not null default '',
  updated_at timestamptz not null default now()
);
create index on answer_bank (user_id, updated_at desc);

-- Condiciones de una oferta recibida (una por proceso).
create table job_offers (
  application_id uuid primary key references applications on delete cascade,
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  salary numeric(14, 2),
  currency text not null default 'USD',
  period text not null default 'month' check (period in ('month', 'year')),
  work_mode work_mode,
  start_date date,
  deadline date,
  benefits text not null default '',
  notes text not null default '',
  updated_at timestamptz not null default now()
);

do $$
declare t text;
begin
  foreach t in array array['answer_bank', 'job_offers'] loop
    execute format('alter table %I enable row level security', t);
    execute format(
      'create policy owner_all on %I for all to authenticated
         using (user_id = (select auth.uid()))
         with check (user_id = (select auth.uid()))', t);
    execute format(
      'create trigger %I before update on %I
         for each row execute function set_updated_at()', t || '_updated_at', t);
  end loop;
end $$;

-- Ficha de la empresa generada para cada oferta.
alter table jobs add column company_brief jsonb;
