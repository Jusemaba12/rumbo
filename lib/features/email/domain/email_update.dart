import 'package:freezed_annotation/freezed_annotation.dart';

import '../../applications/domain/application_status.dart';

part 'email_update.freezed.dart';

/// Propuesta detectada en un correo de una empresa, pendiente de aplicar.
@freezed
abstract class EmailUpdate with _$EmailUpdate {
  const factory EmailUpdate({
    required String id,
    required String applicationId,
    @Default('') String sender,
    @Default('') String subject,
    @Default('') String summary,
    ApplicationStatus? suggestedStatus,
    DateTime? interviewAt,
    DateTime? receivedAt,
  }) = _EmailUpdate;
}

/// Conexión con el script de Gmail; nula si nunca se generó una clave.
@freezed
abstract class EmailSyncStatus with _$EmailSyncStatus {
  const factory EmailSyncStatus({
    required DateTime createdAt,

    /// Última vez que el script habló con Rumbo; nula si aún no se instaló.
    DateTime? lastUsedAt,
  }) = _EmailSyncStatus;
}
