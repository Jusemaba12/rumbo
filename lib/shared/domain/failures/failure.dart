/// Motivo por el que falló una operación. Las funcionalidades declaran sus
/// propios fallos extendiendo esta clase (por ejemplo, `NoDescriptionFailure`
/// en ofertas); aquí están los comunes a toda la app.
///
/// Implementa [Exception] para que los repositorios puedan lanzarlo dentro de
/// `guard` y para que `Result.getOrThrow` lo convierta en `AsyncError`.
abstract class Failure implements Exception {
  const Failure();

  @override
  bool operator ==(Object other) => other.runtimeType == runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => '$runtimeType';
}

/// Sin conexión o el servidor no respondió.
final class NetworkFailure extends Failure {
  const NetworkFailure();
}

/// La función necesita el servidor y la app está en modo local.
final class BackendUnavailableFailure extends Failure {
  const BackendUnavailableFailure();
}

/// La persona ya usó la IA el máximo de veces de hoy.
final class DailyLimitFailure extends Failure {
  const DailyLimitFailure();
}

/// Se agotó la cuota por minuto de la IA o de la función.
final class RateLimitedFailure extends Failure {
  const RateLimitedFailure();
}

/// La IA está saturada, incluso después de reintentar.
final class AiBusyFailure extends Failure {
  const AiBusyFailure();
}

/// Ya existe un registro igual (restricción única de la base de datos).
final class DuplicateFailure extends Failure {
  const DuplicateFailure();
}

/// Cualquier otro error; [error] se guarda para el registro.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure([this.error]);

  final Object? error;

  @override
  String toString() => 'UnexpectedFailure($error)';
}
