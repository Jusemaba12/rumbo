import 'package:rumbo/shared/domain/failures/failure.dart';

/// El PDF de la HV supera el tamaño máximo.
final class FileTooLargeFailure extends Failure {
  const FileTooLargeFailure();
}

/// No se pudo leer el contenido del PDF de la HV.
final class UnreadableFileFailure extends Failure {
  const UnreadableFileFailure();
}

/// No hay cargos en las preferencias para buscar sus palabras clave.
final class NoRolesFailure extends Failure {
  const NoRolesFailure();
}
