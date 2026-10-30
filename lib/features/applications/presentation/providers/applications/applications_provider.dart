import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/application/use_cases/change_application_status_use_case.dart';
import 'package:rumbo/features/applications/application/use_cases/delete_application_use_case.dart';
import 'package:rumbo/features/applications/application/use_cases/get_application_events_use_case.dart';
import 'package:rumbo/features/applications/application/use_cases/get_applications_use_case.dart';
import 'package:rumbo/features/applications/application/use_cases/save_application_use_case.dart';
import 'package:rumbo/features/applications/application/use_cases/start_application_use_case.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/domain/services/follow_up.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'applications_provider.g.dart';

/// Tablero de procesos. Cada acción devuelve un [Result] y, si sale bien,
/// vuelve a leer la lista.
@Riverpod(keepAlive: true)
class ApplicationsController extends _$ApplicationsController {
  @override
  Future<List<ApplicationWithJob>> build() async {
    ref.watch(sessionChangesProvider);
    // Borrar una oferta borra su proceso: se vuelve a cargar.
    await ref.watch(jobsControllerProvider.future);
    return (await ref.watch(getApplicationsUseCaseProvider)()).getOrThrow();
  }

  Application? forJob(String jobId) => state.value
      ?.firstWhereOrNull(
        (ApplicationWithJob item) => item.application.jobId == jobId,
      )
      ?.application;

  /// Crea el proceso de una oferta, o lo actualiza si ya existe.
  ///
  /// Con [resumeVersionId] (HV preparada) pasa a «Preparando».
  Future<Result<Application>> startForJob(
    String jobId, {
    String? resumeVersionId,
    String? coverLetter,
  }) => _thenReload(
    ref.read(startApplicationUseCaseProvider)(
      jobId: jobId,
      existing: forJob(jobId),
      resumeVersionId: resumeVersionId,
      coverLetter: coverLetter,
    ),
  );

  Future<Result<Application>> changeStatus({
    required Application application,
    required ApplicationStatus to,
  }) => _thenReload(
    ref.read(changeApplicationStatusUseCaseProvider)(
      application: application,
      to: to,
    ),
  );

  Future<Result<Application>> saveNotes({
    required Application application,
    required String notes,
  }) => _save(application.copyWith(notes: notes));

  /// Marca el seguimiento como hecho y programa el siguiente.
  Future<Result<Application>> followUpDone(Application application) => _save(
    application.copyWith(
      nextFollowUpAt: ref.read(clockProvider)().add(followUpAfter),
    ),
  );

  Future<Result<Application>> setFollowUp({
    required Application application,
    required DateTime? date,
  }) => _save(application.copyWith(nextFollowUpAt: date));

  /// Tras enviar la postulación por correo: el proceso pasa a «Postulada».
  /// Si estaba en «Guardada», pasa antes por «Preparando» para que el
  /// historial siga el orden normal.
  Future<Result<Application>> markApplied(String jobId) async {
    Result<Application> result = await startForJob(jobId);
    if (result case Ok<Application>(value: final Application started)
        when started.status == ApplicationStatus.saved) {
      result = await changeStatus(
        application: started,
        to: ApplicationStatus.preparing,
      );
    }
    if (result case Ok<Application>(value: final Application current)
        when current.status.canMoveTo(ApplicationStatus.applied)) {
      result = await changeStatus(
        application: current,
        to: ApplicationStatus.applied,
      );
    }
    return result;
  }

  Future<Result<void>> delete(String id) =>
      _thenReload(ref.read(deleteApplicationUseCaseProvider)(id));

  Future<Result<Application>> _save(Application application) =>
      _thenReload(ref.read(saveApplicationUseCaseProvider)(application));

  Future<Result<T>> _thenReload<T>(Future<Result<T>> action) async {
    final Result<T> result = await action;
    if (!result.isOk) return result;
    if (result case Ok<T>(value: final Application saved)) {
      ref.invalidate(applicationEventsProvider(saved.id));
    }
    final Result<List<ApplicationWithJob>> items = await ref.read(
      getApplicationsUseCaseProvider,
    )();
    if (items case Ok<List<ApplicationWithJob>>(
      :final List<ApplicationWithJob> value,
    )) {
      state = AsyncData<List<ApplicationWithJob>>(value);
    }
    return result;
  }
}

@Riverpod(keepAlive: true)
Future<List<ApplicationEvent>> applicationEvents(
  Ref ref,
  String applicationId,
) async =>
    (await ref.watch(getApplicationEventsUseCaseProvider)(applicationId))
        .getOrThrow();
