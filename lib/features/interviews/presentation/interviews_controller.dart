import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../applications/domain/application.dart';
import '../../applications/domain/application_status.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../auth/data/auth_repository.dart';
import '../data/interviews_repository.dart';
import '../domain/interview.dart';

part 'interviews_controller.g.dart';

@Riverpod(keepAlive: true)
class InterviewsController extends _$InterviewsController {
  InterviewsRepository get _repository =>
      ref.read(interviewsRepositoryProvider);

  @override
  Future<List<Interview>> build() {
    ref.watch(sessionChangesProvider);
    return ref.watch(interviewsRepositoryProvider).list();
  }

  /// Guarda la entrevista y, si es nueva, avanza el estado del proceso.
  /// Devuelve el estado nuevo, o nulo si no cambió.
  Future<ApplicationStatus?> save(
    Interview interview,
    Application application,
  ) async {
    await _repository.save(interview);
    state = AsyncData(await _repository.list());
    if (interview.id.isNotEmpty) return null;
    final next = statusForInterview(application.status, interview.kind);
    if (next != null) {
      await ref
          .read(applicationsControllerProvider.notifier)
          .changeStatus(application, next);
    }
    return next;
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
    state = AsyncData(await _repository.list());
  }
}

/// Entrevistas pendientes con su proceso, de la más próxima a la más lejana.
List<(Interview, ApplicationWithJob)> upcomingInterviews(
  List<Interview> interviews,
  List<ApplicationWithJob> applications,
  DateTime now,
) {
  final byId = {for (final a in applications) a.application.id: a};
  return [
    for (final interview in interviews)
      if (interview.isUpcoming(now))
        if (byId[interview.applicationId] case final process?)
          (interview, process),
  ];
}
