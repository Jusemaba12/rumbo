import 'package:rumbo/shared/domain/failures/failure.dart';

/// La oferta no trae descripción suficiente para analizarla (por ejemplo,
/// una página que no se pudo leer).
final class NoDescriptionFailure extends Failure {
  const NoDescriptionFailure();
}
