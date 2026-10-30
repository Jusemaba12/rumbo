import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_job_use_case.g.dart';

/// Guarda una oferta analizada. Falla con `DuplicateFailure` si ya existe.
class SaveJobUseCase {
  const SaveJobUseCase({required this._repository});

  final JobsRepository _repository;

  Future<Result<void>> call(SavedJob saved) => _repository.save(saved);
}

@Riverpod(keepAlive: true)
SaveJobUseCase saveJobUseCase(Ref ref) =>
    SaveJobUseCase(repository: ref.watch(jobsRepositoryProvider));
