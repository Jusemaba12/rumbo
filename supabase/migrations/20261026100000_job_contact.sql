-- Contacto del reclutador y forma de postular de cada oferta. Los extrae la
-- IA al analizar la oferta y el usuario los puede corregir.
alter table jobs
  add column if not exists recruiter_name text,
  add column if not exists recruiter_email text,
  -- Perfil de LinkedIn del reclutador o enlace a la publicación.
  add column if not exists recruiter_linkedin text,
  add column if not exists apply_method text
    check (apply_method in ('email', 'direct_message', 'portal')),
  -- Asunto exacto que pide la publicación para postular por correo.
  add column if not exists apply_subject text,
  -- La publicación pide indicar la expectativa salarial.
  add column if not exists asks_salary boolean not null default false;
