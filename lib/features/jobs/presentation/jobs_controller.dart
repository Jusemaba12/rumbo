import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/data/auth_repository.dart';
import '../data/job_analyzer.dart';
import '../data/jobs_repository.dart';
import '../domain/job.dart';

part 'jobs_controller.g.dart';

@Riverpod(keepAlive: true)
class JobsController extends _$JobsController {
  JobsRepository get _repository => ref.read(jobsRepositoryProvider);

  @override
  Future<List<SavedJob>> build() {
    ref.watch(sessionChangesProvider);
    return ref.watch(jobsRepositoryProvider).list();
  }

  Future<void> save(SavedJob saved) async {
    await _repository.save(saved);
    state = AsyncData(await _repository.list());
  }

  Future<void> delete(String jobId) async {
    await _repository.delete(jobId);
    state = AsyncData(await _repository.list());
  }

  Future<void> keepSuggestion(String jobId) async {
    await _repository.keepSuggestion(jobId);
    state = AsyncData(await _repository.list());
  }

  Future<void> dismissSuggestion(String jobId) async {
    await _repository.dismissSuggestion(jobId);
    state = AsyncData(await _repository.list());
  }

  Future<void> restoreSuggestion(String jobId) async {
    await _repository.restoreSuggestion(jobId);
    state = AsyncData(await _repository.list());
  }

  /// Analiza la descripción completa que pegó el usuario y actualiza la
  /// oferta y su compatibilidad. Lanza [JobAnalysisException] si falla.
  Future<SavedJob> complete(String jobId, String description) async {
    final analyzer = ref.read(jobAnalyzerProvider);
    final current = (await future).firstWhere((item) => item.job.id == jobId);
    if (analyzer == null) {
      throw const JobAnalysisException(JobAnalysisFailure.other);
    }
    final analyzed = await analyzer.analyze(text: description);
    final completed = SavedJob(
      job: completeJob(current.job, analyzed.job),
      match: analyzed.match ?? current.match,
    );
    await _repository.complete(completed);
    state = AsyncData(await _repository.list());
    return completed;
  }

  Future<void> updateContact(Job job) async {
    await _repository.updateContact(job);
    state = AsyncData(await _repository.list());
  }

  /// Vuelve a leer las ofertas (p. ej. tras una búsqueda automática).
  Future<void> reload() async {
    state = AsyncData(await _repository.list());
  }
}
