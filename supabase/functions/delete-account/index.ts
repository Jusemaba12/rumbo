// Elimina la cuenta de quien llama y, en cascada, todos sus datos (todas las
// tablas referencian auth.users con on delete cascade).
import {
  json,
  preflight,
  requireUser,
  supabaseAdmin,
} from "../_shared/http.ts";

Deno.serve(async (request) => {
  if (request.method === "OPTIONS") return preflight();
  if (request.method !== "POST") {
    return json({ error: "method_not_allowed" }, 405);
  }
  const user = await requireUser(request);
  if (!user) return json({ error: "unauthorized" }, 401);

  const { error } = await supabaseAdmin.auth.admin.deleteUser(user.id);
  if (error) {
    console.error("delete-account failed", error.message);
    return json({ error: "internal" }, 500);
  }
  return json({ deleted: true });
});
