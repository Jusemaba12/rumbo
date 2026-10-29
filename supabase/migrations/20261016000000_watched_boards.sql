-- Empresas que el usuario vigila en Greenhouse, Lever y Ashby.
-- Cada elemento: {"provider": "greenhouse" | "lever" | "ashby", "token": "gitlab"}.
alter table search_preferences
  add column watched_boards jsonb not null default '[]';
