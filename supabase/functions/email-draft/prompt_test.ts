// Ejecutar: deno test supabase/functions/email-draft/prompt_test.ts
import { assertEquals, assertStringIncludes } from "jsr:@std/assert@1";
import { buildEmailPrompt, salaryExpectation } from "./prompt.ts";

const profile = {
  salary_cop_min: 6000000,
  salary_cop_max: 8000000,
  salary_usd_min: 2000,
  salary_usd_max: null,
};

Deno.test("usa dólares si la oferta habla en USD", () => {
  assertEquals(
    salaryExpectation(profile, { description: "Pago en USD, contrato" }),
    "USD 2.000 mensuales",
  );
  assertEquals(
    salaryExpectation(profile, { salary_currency: "USD" }),
    "USD 2.000 mensuales",
  );
});

Deno.test("si no, pesos; y si no hay pesos, dólares", () => {
  assertEquals(
    salaryExpectation(profile, { description: "Cargo en Bogotá" }),
    "COP 6.000.000 - 8.000.000 mensuales",
  );
  assertEquals(
    salaryExpectation({ salary_usd_max: 2500 }, { description: "Bogotá" }),
    "USD 2.500 mensuales",
  );
  assertEquals(salaryExpectation(null, { description: "USD" }), null);
});

Deno.test("la postulación exige el asunto pedido y no inventa cifras", () => {
  const prompt = buildEmailPrompt(
    "application",
    { asunto_exigido: "Flutter Dev - Praxis" },
    "Envía tu CV",
  );
  assertStringIncludes(prompt, "adjunta su hoja de vida");
  assertStringIncludes(prompt, "asunto_exigido");
  assertStringIncludes(prompt, "Nunca inventes cifras");
});
