-- Plan de aprendizaje: temas que la persona quiere aprender para cubrir lo
-- que piden sus ofertas, con un plan generado por IA.
create table if not exists learning_topics (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  topic text not null,
  status text not null default 'pending'
    check (status in ('pending', 'learning', 'mastered')),
  -- En cuántas ofertas aparecía al añadirlo (para ordenar).
  demand int not null default 0,
  plan jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists learning_topics_user_topic
  on learning_topics (user_id, lower(topic));

alter table learning_topics enable row level security;

drop policy if exists owner_all on learning_topics;
create policy owner_all on learning_topics for all to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));
