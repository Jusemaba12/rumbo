-- Fase 5, paso 4: preparar Rumbo para compartirlo.

-- Aviso de privacidad aceptado (una vez por cuenta).
alter table profiles add column if not exists privacy_accepted_at timestamptz;

-- Límite diario de IA: cuenta las llamadas de las últimas 24 horas.
create index if not exists ai_calls_user_created_idx
  on ai_calls (user_id, created_at desc);

-- Versiones publicadas de la app (APK de Android) para avisar de
-- actualizaciones. Solo se escribe desde el panel o con la clave de servicio.
create table if not exists app_releases (
  id uuid primary key default gen_random_uuid(),
  platform text not null default 'android' check (platform in ('android', 'ios')),
  version_name text not null,
  version_code int not null,
  download_url text not null,
  notes text not null default '',
  created_at timestamptz not null default now(),
  unique (platform, version_code)
);

alter table app_releases enable row level security;

drop policy if exists "app_releases readable" on app_releases;
create policy "app_releases readable" on app_releases
  for select to anon, authenticated using (true);

-- Carpeta pública para descargar el APK.
insert into storage.buckets (id, name, public)
values ('releases', 'releases', true)
on conflict (id) do nothing;
