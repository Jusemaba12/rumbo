import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/time/clock.dart';
import '../../auth/data/auth_repository.dart';
import '../../jobs/presentation/jobs_controller.dart';
import '../data/applications_repository.dart';
import '../domain/application.dart';
import '../domain/application_status.dart';
import '../domain/follow_up.dart';

part 'applications_controller.g.dart';

@Riverpod(keepAlive: true)
class ApplicationsController extends _$ApplicationsController {
  ApplicationsRepository get _repository =>
      ref.read(applicationsRepositoryProvider);

  DateTime _now() => ref.read(clockProvider)();

  @override
  Future<List<ApplicationWithJob>> build() async {
    ref.watch(sessionChangesProvider);
    // Borrar una oferta borra su proceso: se vuelve a cargar.
    await ref.watch(jobsControllerProvider.future);
    final items = await ref.watch(applicationsRepositoryProvider).list();
    final now = _now();
    return items
      ..sort((a, b) => compareForBoard(a.application, b.application, now));
  }

  Application? forJob(String jobId) => state.value
      ?.firstWhereOrNull((item) => item.application.jobId == jobId)
      ?.application;

  /// Crea el proceso de una oferta, o lo actualiza si ya existe.
  ///
  /// Con [resumeVersionId] (HV preparada) pasa a «Preparando».
  Future<Application> startForJob(
    String jobId, {
    String? resumeVersionId,
    String? coverLetter,
  }) async {
    final existing = forJob(jobId);
    var application =
        existing ?? Application(jobId: jobId, status: ApplicationStatus.saved);
    if (resumeVersionId != null) {
      application = application.copyWith(
        resumeVersionId: resumeVersionId,
        coverLetter: coverLetter,
      );
      if (application.status.canMoveTo(ApplicationStatus.preparing)) {
        application = applyStatusChange(
          application,
          ApplicationStatus.preparing,
          _now(),
        );
      }
    }
    final saved = await _repository.save(application);
    await _reload();
    return saved;
  }

  Future<void> changeStatus(Application application, ApplicationStatus to) =>
      _saveAndReload(applyStatusChange(application, to, _now()));

  Future<void> saveNotes(Application application, String notes) =>
      _saveAndReload(application.copyWith(notes: notes));

  /// Marca el seguimiento como hecho y programa el siguiente.
  Future<void> followUpDone(Application application) => _saveAndReload(
    application.copyWith(nextFollowUpAt: _now().add(followUpAfter)),
  );

  Future<void> setFollowUp(Application application, DateTime? date) =>
      _saveAndReload(application.copyWith(nextFollowUpAt: date));

  Future<void> delete(String id) async {
    await _repository.delete(id);
    await _reload();
  }

  Future<void> _saveAndReload(Application application) async {
    await _repository.save(application);
    ref.invalidate(applicationEventsProvider(application.id));
    await _reload();
  }

  Future<void> _reload() async {
    final items = await _repository.list();
    final now = _now();
    state = AsyncData(
      items..sort((a, b) => compareForBoard(a.application, b.application, now)),
    );
  }
}

@Riverpod(keepAlive: true)
Future<List<ApplicationEvent>> applicationEvents(
  Ref ref,
  String applicationId,
) => ref.watch(applicationsRepositoryProvider).events(applicationId);
