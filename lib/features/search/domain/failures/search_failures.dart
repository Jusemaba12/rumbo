import 'package:rumbo/shared/domain/failures/failure.dart';

/// Aún no se configuraron las preferencias de búsqueda.
final class NoPreferencesFailure extends Failure {
  const NoPreferencesFailure();
}

/// Ya se buscó hace poco: máximo una búsqueda cada 10 minutos.
final class TooSoonFailure extends Failure {
  const TooSoonFailure();
}
