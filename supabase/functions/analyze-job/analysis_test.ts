// Ejecutar: deno test supabase/functions/analyze-job/analysis_test.ts
import { assertEquals } from "jsr:@std/assert@1";
import { type JobAnalysis, verifyContact } from "./analysis.ts";

const base: JobAnalysis["job"] = {
  title: "Flutter Developer",
  company: "Praxis",
  location: "Remoto",
  work_mode: "remote",
  requirements: [],
  salary_min: null,
  salary_max: null,
  salary_currency: null,
  recruiter_name: null,
  recruiter_email: null,
  recruiter_linkedin: null,
  apply_method: "email",
  apply_subject: null,
  asks_salary: false,
};

const text = `Buscamos Flutter Developer. Envía tu CV a talento@praxis.com con el
asunto «Flutter Dev - Praxis 2026» e indica tu aspiración salarial en USD.
Contacto: Matilde Durango https://www.linkedin.com/in/matilde-durango/`;

Deno.test("conserva el contacto que está en la oferta", () => {
  const job = verifyContact({
    ...base,
    recruiter_name: "Matilde Durango",
    recruiter_email: "talento@praxis.com",
    recruiter_linkedin: "https://www.linkedin.com/in/matilde-durango/",
    apply_subject: "Flutter Dev - Praxis 2026",
    asks_salary: true,
  }, text);
  assertEquals(job.recruiter_name, "Matilde Durango");
  assertEquals(job.recruiter_email, "talento@praxis.com");
  assertEquals(
    job.recruiter_linkedin,
    "https://www.linkedin.com/in/matilde-durango/",
  );
  assertEquals(job.apply_subject, "Flutter Dev - Praxis 2026");
  assertEquals(job.asks_salary, true);
});

Deno.test("descarta lo que la IA se inventó", () => {
  const job = verifyContact({
    ...base,
    recruiter_name: "Laura Gómez",
    recruiter_email: "rrhh@praxis.com",
    recruiter_linkedin: "https://www.linkedin.com/in/laura/",
    apply_subject: "Postulación Flutter",
  }, text);
  assertEquals(job.recruiter_name, null);
  assertEquals(job.recruiter_email, null);
  assertEquals(job.recruiter_linkedin, null);
  assertEquals(job.apply_subject, null);
});

Deno.test("un enlace que no es de LinkedIn no cuenta como perfil", () => {
  const job = verifyContact(
    { ...base, recruiter_linkedin: "https://praxis.com/empleos" },
    "Postula en https://praxis.com/empleos",
  );
  assertEquals(job.recruiter_linkedin, null);
});
