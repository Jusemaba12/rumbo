// Ejecutar: deno test supabase/functions/email-sync/linkedin_test.ts
import { assertEquals } from "jsr:@std/assert@1";
import { extractAlertJobs } from "./linkedin.ts";

// Correos inventados con la forma habitual de las alertas (texto plano).
const english = `Your job alert for flutter developer in Colombia
3 new jobs match your preferences.

Flutter Developer
Acme Labs
Bogotá, Capital District, Colombia (Remote)
View job: https://www.linkedin.com/comm/jobs/view/4012345678/?trackingId=abc%3D&refId=xyz&lipi=urn

---------------------------------------------------------

Senior Mobile Engineer (Flutter)
Globex
Medellín, Antioquia, Colombia (Hybrid)
View job: https://www.linkedin.com/comm/jobs/view/4087654321/?trackingId=def

---------------------------------------------------------

See all jobs: https://www.linkedin.com/comm/jobs/search?keywords=flutter

Unsubscribe: https://www.linkedin.com/comm/psettings/email-unsubscribe?x=1
`;

const spanish = `Tu alerta de empleo para desarrollador flutter
Desarrollador Flutter
Initech · Colombia (En remoto)
Ver empleo: https://co.linkedin.com/jobs/view/desarrollador-flutter-at-initech-4011111111?refId=1
Desarrollador Flutter
Initech · Colombia (En remoto)
Solicitar: https://co.linkedin.com/jobs/view/desarrollador-flutter-at-initech-4011111111?apply=1
`;

Deno.test("saca las ofertas de una alerta en inglés", () => {
  const date = new Date("2026-10-19T12:00:00Z");
  const jobs = extractAlertJobs(english, date);
  assertEquals(jobs.map((j) => j.jobId), ["4012345678", "4087654321"]);
  assertEquals(jobs[0].url, "https://www.linkedin.com/jobs/view/4012345678/");
  assertEquals(jobs[0].receivedAt, date);
  // El texto trae cargo, empresa y ubicación, sin enlaces.
  assertEquals(jobs[0].text.includes("Flutter Developer"), true);
  assertEquals(jobs[0].text.includes("Acme Labs"), true);
  assertEquals(jobs[0].text.includes("http"), false);
  assertEquals(jobs[1].text.includes("Globex"), true);
  assertEquals(jobs[1].text.includes("Acme Labs"), false);
});

Deno.test("junta los enlaces repetidos y lee el número tras el nombre", () => {
  const jobs = extractAlertJobs(spanish);
  assertEquals(jobs.map((j) => j.jobId), ["4011111111"]);
  assertEquals(jobs[0].url, "https://www.linkedin.com/jobs/view/4011111111/");
  assertEquals(jobs[0].text.includes("Initech"), true);
});

Deno.test("ignora correos sin ofertas", () => {
  assertEquals(
    extractAlertJobs("Hola https://www.linkedin.com/feed/ adiós"),
    [],
  );
});
