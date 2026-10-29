-- Lectura de Gmail mediante un script de Google Apps Script del usuario.

-- Clave del script: la app guarda solo su hash (SHA-256 en hex).
create table email_sync_keys (
  user_id uuid primary key default auth.uid() references auth.users on delete cascade,
  key_hash text not null unique,
  created_at timestamptz not null default now(),
  last_used_at timestamptz
);

-- Propuestas detectadas en correos; el usuario las aplica o las ignora.
create table email_updates (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users on delete cascade,
  application_id uuid not null references applications on delete cascade,
  gmail_message_id text not null,
  received_at timestamptz,
  sender text not null default '',
  subject text not null default '',
  summary text not null default '',
  suggested_status application_status,
  interview_at timestamptz,
  state text not null default 'pending' check (state in ('pending', 'applied', 'dismissed')),
  created_at timestamptz not null default now(),
  unique (user_id, gmail_message_id)
);

create index on email_updates (user_id, state);

alter table email_sync_keys enable row level security;
create policy owner_all on email_sync_keys for all to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

-- Las propuestas solo las crea el servidor; el usuario las lee y cambia su estado.
alter table email_updates enable row level security;
create policy owner_read on email_updates for select to authenticated
  using (user_id = (select auth.uid()));
create policy owner_update on email_updates for update to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));
