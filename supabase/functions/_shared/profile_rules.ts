// Sin dependencias: lo importan los prompts y sus pruebas.

/**
 * Cómo leer los idiomas y la expectativa salarial del perfil. Se añade a
 * todos los prompts que calculan la compatibilidad.
 */
export const PROFILE_RULES = `- Idiomas: el perfil los trae en languages con nivel MCER (A1 a C2, o native). «Inglés avanzado», «fluido» o «C1» se cumple con C1, C2 o native; «intermedio alto», «conversacional» o «B2» con B2 o más; «intermedio» con B1 o más. Si el perfil no trae el idioma, cuenta como no demostrado.
- Salario: salary_cop_min/max y salary_usd_min/max son la expectativa bruta mensual del candidato (pueden ser nulos). Si la oferta da salario, compáralo (pasa los anuales a mensuales); si queda por debajo del mínimo del candidato, dilo en la explicación. El salario no cambia la nota: la nota mide el encaje con los requisitos.`;
