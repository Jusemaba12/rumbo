import 'package:rumbo/features/email/domain/entities/email_draft.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Redacta correos con IA (función `email-draft`). No envía nada.
abstract interface class EmailDrafter {
  Future<Result<EmailDraft>> draft({
    required String applicationId,
    required EmailDraftKind kind,
    String notes = '',
  });

  /// Correo para postular a una oferta: asunto que pide la publicación,
  /// presentación y expectativa salarial si la piden.
  Future<Result<EmailDraft>> draftApplication(
    String jobId, {
    String notes = '',
  });
}
