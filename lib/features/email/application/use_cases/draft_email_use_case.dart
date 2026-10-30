import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/email/domain/entities/email_draft.dart';
import 'package:rumbo/features/email/domain/repositories/email_drafter.dart';
import 'package:rumbo/features/email/infrastructure/di/email_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'draft_email_use_case.g.dart';

/// Redacta con IA los correos de un proceso o de una postulación. El usuario
/// los revisa y los envía desde su correo: Rumbo no envía nada.
class DraftEmailUseCase {
  const DraftEmailUseCase({required this._drafter});

  final EmailDrafter? _drafter;

  /// Falso en modo local, donde no hay IA.
  bool get isAvailable => _drafter != null;

  Future<Result<EmailDraft>> call({
    required String applicationId,
    required EmailDraftKind kind,
  }) async =>
      await _drafter?.draft(applicationId: applicationId, kind: kind) ??
      const Err<EmailDraft>(BackendUnavailableFailure());

  Future<Result<EmailDraft>> forJob(String jobId) async =>
      await _drafter?.draftApplication(jobId) ??
      const Err<EmailDraft>(BackendUnavailableFailure());
}

@Riverpod(keepAlive: true)
DraftEmailUseCase draftEmailUseCase(Ref ref) =>
    DraftEmailUseCase(drafter: ref.watch(emailDrafterProvider));
