import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/jobs/application/use_cases/complete_job_use_case.dart';
import 'package:rumbo/features/jobs/application/use_cases/delete_job_use_case.dart';
import 'package:rumbo/features/jobs/application/use_cases/get_jobs_use_case.dart';
import 'package:rumbo/features/jobs/application/use_cases/manage_suggestion_use_case.dart';
import 'package:rumbo/features/jobs/application/use_cases/save_job_use_case.dart';
import 'package:rumbo/features/jobs/application/use_cases/update_job_contact_use_case.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'jobs_provider.g.dart';

/// Ofertas guardadas y sugeridas. Cada acción devuelve un [Result] y, si sale
/// bien, vuelve a leer la lista.
@Riverpod(keepAlive: true)
class JobsController extends _$JobsController {
  @override
  Future<List<SavedJob>> build() async {
    ref.watch(sessionChangesProvider);
    return (await ref.watch(getJobsUseCaseProvider)()).getOrThrow();
  }

  Future<Result<void>> save(SavedJob saved) =>
      _thenReload(ref.read(saveJobUseCaseProvider)(saved));

  Future<Result<void>> delete(String jobId) =>
      _thenReload(ref.read(deleteJobUseCaseProvider)(jobId));

  Future<Result<void>> keepSuggestion(String jobId) =>
      _suggestion(jobId: jobId, action: SuggestionAction.keep);

  Future<Result<void>> dismissSuggestion(String jobId) =>
      _suggestion(jobId: jobId, action: SuggestionAction.dismiss);

  Future<Result<void>> restoreSuggestion(String jobId) =>
      _suggestion(jobId: jobId, action: SuggestionAction.restore);

  Future<Result<void>> updateContact(Job job) =>
      _thenReload(ref.read(updateJobContactUseCaseProvider)(job));

  /// Analiza la descripción completa que pegó el usuario y actualiza la
  /// oferta y su compatibilidad.
  Future<Result<SavedJob>> complete({
    required String jobId,
    required String description,
  }) async {
    final SavedJob current = (await future).firstWhere(
      (SavedJob item) => item.job.id == jobId,
    );
    return _thenReload(
      ref.read(completeJobUseCaseProvider)(
        current: current,
        description: description,
      ),
    );
  }

  /// Vuelve a leer las ofertas (p. ej. tras una búsqueda automática).
  Future<void> reload() async {
    final Result<List<SavedJob>> jobs = await ref.read(
      getJobsUseCaseProvider,
    )();
    if (jobs case Ok<List<SavedJob>>(:final List<SavedJob> value)) {
      state = AsyncData<List<SavedJob>>(value);
    }
  }

  Future<Result<void>> _suggestion({
    required String jobId,
    required SuggestionAction action,
  }) => _thenReload(
    ref.read(manageSuggestionUseCaseProvider)(jobId: jobId, action: action),
  );

  Future<Result<T>> _thenReload<T>(Future<Result<T>> action) async {
    final Result<T> result = await action;
    if (result.isOk) await reload();
    return result;
  }
}
