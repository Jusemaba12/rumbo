import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/email/application/use_cases/get_email_sync_status_use_case.dart';
import 'package:rumbo/features/email/application/use_cases/get_pending_email_updates_use_case.dart';
import 'package:rumbo/features/email/application/use_cases/resolve_email_update_use_case.dart';
import 'package:rumbo/features/email/domain/entities/email_update.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/presentation/providers/interviews/interviews_provider.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'email_provider.g.dart';

@Riverpod(keepAlive: true)
Future<EmailSyncStatus?> emailSyncStatus(Ref ref) async {
  ref.watch(sessionChangesProvider);
  return (await ref.watch(getEmailSyncStatusUseCaseProvider)()).getOrThrow();
}

@Riverpod(keepAlive: true)
class EmailUpdatesController extends _$EmailUpdatesController {
  @override
  Future<List<EmailUpdate>> build() async {
    ref.watch(sessionChangesProvider);
    return (await ref.watch(
      getPendingEmailUpdatesUseCaseProvider,
    )()).getOrThrow();
  }

  /// Aplica la propuesta: programa la entrevista (si trae fecha) y cambia el
  /// estado si todavía es posible desde el estado actual.
  Future<Result<void>> apply(EmailUpdate update) async {
    Application? process() => ref
        .read(applicationsControllerProvider)
        .value
        ?.firstWhereOrNull(
          (ApplicationWithJob i) => i.application.id == update.applicationId,
        )
        ?.application;

    final Application? initial = process();
    if (initial == null) {
      // El proceso ya no existe: la propuesta no tiene sentido.
      return _resolve(update, applied: false);
    }
    if (update.interviewAt case final DateTime interviewAt?) {
      final Result<void> saved = await ref
          .read(interviewsControllerProvider.notifier)
          .save(
            interview: Interview(
              applicationId: update.applicationId,
              kind: update.suggestedStatus == ApplicationStatus.technicalTest
                  ? InterviewKind.technical
                  : InterviewKind.screening,
              scheduledAt: interviewAt,
              notes: update.summary,
            ),
            application: initial,
          );
      if (saved case Err<void>(:final Failure failure)) {
        return Err<void>(failure);
      }
    }
    final ApplicationStatus? target = update.suggestedStatus;
    final Application? current = process();
    if (target != null && current != null && current.status.canMoveTo(target)) {
      final Result<void> changed = await ref
          .read(applicationsControllerProvider.notifier)
          .changeStatus(application: current, to: target);
      if (changed case Err<void>(:final Failure failure)) {
        return Err<void>(failure);
      }
    }
    return _resolve(update, applied: true);
  }

  Future<Result<void>> dismiss(EmailUpdate update) =>
      _resolve(update, applied: false);

  Future<Result<void>> _resolve(
    EmailUpdate update, {
    required bool applied,
  }) async {
    final Result<void> result = await ref.read(
      resolveEmailUpdateUseCaseProvider,
    )(update.id, applied: applied);
    if (!result.isOk) return result;
    final Result<List<EmailUpdate>> updates = await ref.read(
      getPendingEmailUpdatesUseCaseProvider,
    )();
    if (updates case Ok<List<EmailUpdate>>(:final List<EmailUpdate> value)) {
      state = AsyncData<List<EmailUpdate>>(value);
    }
    return result;
  }
}
