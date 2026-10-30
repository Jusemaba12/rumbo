import 'package:rumbo/features/email/domain/entities/email_update.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Conexión con Gmail (clave del script) y propuestas sacadas de los correos.
abstract interface class EmailRepository {
  Future<Result<EmailSyncStatus?>> status();

  /// Crea una clave nueva (invalida la anterior) y la devuelve en claro.
  /// Solo se muestra una vez: en la base de datos se guarda su hash.
  Future<Result<String>> createKey();

  Future<Result<void>> disconnect();

  Future<Result<List<EmailUpdate>>> pendingUpdates();

  /// Marca la propuesta como aplicada o ignorada.
  Future<Result<void>> resolve(String updateId, {required bool applied});
}
