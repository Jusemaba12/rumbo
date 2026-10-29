import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../applications/domain/application_status.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../auth/data/auth_repository.dart';
import '../../interviews/domain/interview.dart';
import '../../interviews/presentation/interviews_controller.dart';
import '../data/email_repository.dart';
import '../domain/email_update.dart';

part 'email_controller.g.dart';

@Riverpod(keepAlive: true)
Future<EmailSyncStatus?> emailSyncStatus(Ref ref) {
  ref.watch(sessionChangesProvider);
  return ref.watch(emailRepositoryProvider).status();
}

@Riverpod(keepAlive: true)
class EmailUpdatesController extends _$EmailUpdatesController {
  EmailRepository get _repository => ref.read(emailRepositoryProvider);

  @override
  Future<List<EmailUpdate>> build() {
    ref.watch(sessionChangesProvider);
    return ref.watch(emailRepositoryProvider).pendingUpdates();
  }

  /// Aplica la propuesta: programa la entrevista (si trae fecha) y cambia el
  /// estado si todavía es posible desde el estado actual.
  Future<void> apply(EmailUpdate update) async {
    final applications = ref.read(applicationsControllerProvider.notifier);
    ApplicationStatus? current() => ref
        .read(applicationsControllerProvider)
        .value
        ?.firstWhereOrNull((i) => i.application.id == update.applicationId)
        ?.application
        .status;

    final interviewAt = update.interviewAt;
    final initial = ref
        .read(applicationsControllerProvider)
        .value
        ?.firstWhereOrNull((i) => i.application.id == update.applicationId)
        ?.application;
    if (initial == null) {
      // El proceso ya no existe: la propuesta no tiene sentido.
      await _resolve(update, applied: false);
      return;
    }
    if (interviewAt != null) {
      await ref
          .read(interviewsControllerProvider.notifier)
          .save(
            Interview(
              applicationId: update.applicationId,
              kind: update.suggestedStatus == ApplicationStatus.technicalTest
                  ? InterviewKind.technical
                  : InterviewKind.screening,
              scheduledAt: interviewAt,
              notes: update.summary,
            ),
            initial,
          );
    }
    final target = update.suggestedStatus;
    final status = current();
    if (target != null && status != null && status.canMoveTo(target)) {
      final application = ref
          .read(applicationsControllerProvider)
          .value!
          .firstWhere((i) => i.application.id == update.applicationId)
          .application;
      await applications.changeStatus(application, target);
    }
    await _resolve(update, applied: true);
  }

  Future<void> dismiss(EmailUpdate update) => _resolve(update, applied: false);

  Future<void> _resolve(EmailUpdate update, {required bool applied}) async {
    await _repository.resolve(update.id, applied: applied);
    state = AsyncData(await _repository.pendingUpdates());
  }
}
