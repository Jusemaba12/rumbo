-- Palabras clave de los cargos objetivo, guardadas para no pedirlas a la IA
-- cada vez. Las escribe la función resume-keywords; la app solo las lee.
create table if not exists resume_keywords (
  user_id uuid primary key references auth.users on delete cascade,
  roles text[] not null default '{}',
  keywords jsonb not null default '[]',
  prompt_version text not null default '',
  created_at timestamptz not null default now()
);

alter table resume_keywords enable row level security;

drop policy if exists "resume_keywords own" on resume_keywords;
create policy "resume_keywords own" on resume_keywords
  for select to authenticated using (user_id = auth.uid());
