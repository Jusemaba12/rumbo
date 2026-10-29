# Rumbo

Copiloto personal para buscar empleo, hecho con **Flutter** (iOS, Android y web) y **Supabase**. Reúne en una sola app todo el ciclo de una búsqueda: encontrar ofertas, medir qué tan bien encajan con el perfil, adaptar la hoja de vida a cada una, postular y hacer seguimiento.

La IA prepara y el usuario decide: Rumbo nunca envía una postulación ni un correo por su cuenta, y valida lo que genera la IA para que no invente experiencia, cifras ni datos de contacto.

## Qué hace

- **Ofertas**
  - Analiza una oferta pegada o enlazada y calcula la compatibilidad (0-100) con el perfil: qué requisitos cumple y cuáles faltan.
  - Búsqueda diaria automática en portales con API pública (Get on Board, Remotive, Himalayas, Remote OK, We Work Remotely) y en las páginas de empleo de empresas en Greenhouse, Lever, Ashby, Workable, SmartRecruiters, Recruitee y Teamtailor.
  - Alertas de empleo de LinkedIn leídas desde el Gmail del propio usuario (sin bots en LinkedIn).
  - Extrae el contacto del reclutador, la forma de postular y el asunto que pide la publicación.
- **Hoja de vida**
  - Perfil importado desde un PDF y editable.
  - HV adaptada a cada oferta con carta de presentación; un validador descarta cifras y habilidades que no están en el perfil.
  - Revisión tipo ATS con nota por categorías, palabras clave de los cargos y prueba de lectura del PDF real con pdf.js.
  - Plan de aprendizaje: qué tecnologías piden las ofertas y no aparecen en la HV, con un plan y recursos verificados.
- **Postulación y seguimiento**
  - Postular por correo con la HV adaptada en PDF adjunta y el borrador redactado.
  - Tablero de procesos con estados, historial, seguimientos y entrevistas.
  - Correos de seguimiento, agradecimiento y respuesta a rechazos.
  - Recordatorios locales, estadísticas del embudo, simulador de entrevistas, banco de respuestas y comparador de ofertas con borrador de negociación.

## Tecnología

| Capa | Herramientas |
|---|---|
| App | Flutter 3.47, Dart 3.13, Riverpod 3 con `riverpod_generator`, freezed, go_router con rutas tipadas (`go_router_builder`), l10n oficial (español e inglés) |
| Servidor | Supabase: Postgres con Row Level Security en todas las tablas, Auth con código por correo, Edge Functions en Deno/TypeScript, pg_cron |
| IA | Gemini (con Groq como respaldo cuando se satura) o Claude, siempre desde las Edge Functions: las claves nunca están en la app |
| Otros | `pdf`/`printing` para generar la HV, pdf.js en el servidor para leerla como un ATS, Google Apps Script para Gmail, Cloudflare Pages para la web |

## Arquitectura

```
lib/
  core/        configuración, tema, router (rutas tipadas), IA, reloj
  features/    una carpeta por funcionalidad
    <feature>/
      domain/        modelos y reglas puras (sin Flutter ni Supabase)
      data/          repositorios: interfaz + implementación Supabase y en memoria
      presentation/  pantallas, widgets y controladores de Riverpod
  shared/      widgets comunes
supabase/
  migrations/  esquema SQL versionado
  functions/   Edge Functions (análisis de ofertas, búsqueda, HV adaptada, correos…)
```

- Los repositorios se exponen como interfaz + provider, así que las pruebas usan la versión en memoria sin servidor.
- La lógica que importa (compatibilidad local, revisión ATS, reglas de estados, plan de recordatorios, filtros de búsqueda) vive en `domain` y se prueba sin interfaz.
- Las salidas de la IA se validan en el servidor: solo se aceptan datos de contacto que aparecen en el texto de la oferta, cifras que están en el perfil y enlaces que responden.

## Ejecutar

Sin servidor (datos en memoria, sin IA):

```bash
flutter pub get
flutter run
```

Con Supabase: copia `env/dev.example.json` a `env/dev.json` con la URL y la clave pública de tu proyecto, aplica las migraciones de `supabase/migrations/`, publica las funciones de `supabase/functions/` y define sus secretos (`GEMINI_API_KEY` y, opcionalmente, `GROQ_API_KEY`). Después:

```bash
flutter run --dart-define-from-file=env/dev.json
```

## Pruebas

```bash
dart format lib test && flutter analyze && flutter test
```

166 pruebas de la app (dominio, repositorios y pantallas completas) y pruebas de Deno para los validadores del servidor (`deno test supabase/functions/<función>/*_test.ts`).

## Autor

Juan Manzano, desarrollador Flutter.
