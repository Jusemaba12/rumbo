import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_jobs_use_case.g.dart';

/// Ofertas guardadas y sugeridas, las más recientes primero.
class GetJobsUseCase {
  const GetJobsUseCase({required this._repository});

  final JobsRepository _repository;

  Future<Result<List<SavedJob>>> call() => _repository.list();
}

@Riverpod(keepAlive: true)
GetJobsUseCase getJobsUseCase(Ref ref) =>
    GetJobsUseCase(repository: ref.watch(jobsRepositoryProvider));
