/// Configuración inyectada en tiempo de compilación con
/// `--dart-define-from-file=env/dev.json`.
abstract final class Env {
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  /// Sin URL ni clave la app arranca en modo local, sin servidor.
  static bool get hasBackend =>
      supabaseUrl.isNotEmpty && supabasePublishableKey.isNotEmpty;
}
