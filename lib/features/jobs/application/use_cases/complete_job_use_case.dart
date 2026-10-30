import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/jobs/application/use_cases/analyze_job_use_case.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'complete_job_use_case.g.dart';

/// Analiza la descripción completa que pegó el usuario y la sustituye en la
/// oferta guardada, con su nueva compatibilidad (`completeJob` decide qué se
/// conserva).
class CompleteJobUseCase {
  const CompleteJobUseCase({
    required this._analyzeJob,
    required this._repository,
  });

  final AnalyzeJobUseCase _analyzeJob;
  final JobsRepository _repository;

  Future<Result<SavedJob>> call({
    required SavedJob current,
    required String description,
  }) async {
    final Result<SavedJob> analyzed = await _analyzeJob(text: description);
    return analyzed.andThen((SavedJob analyzed) async {
      final SavedJob completed = SavedJob(
        job: completeJob(job: current.job, analyzed: analyzed.job),
        match: analyzed.match ?? current.match,
      );
      final Result<void> saved = await _repository.complete(completed);
      return saved.map((_) => completed);
    });
  }
}

@Riverpod(keepAlive: true)
CompleteJobUseCase completeJobUseCase(Ref ref) => CompleteJobUseCase(
  analyzeJob: ref.watch(analyzeJobUseCaseProvider),
  repository: ref.watch(jobsRepositoryProvider),
);
