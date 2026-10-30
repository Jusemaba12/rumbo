import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_job_use_case.g.dart';

/// Borra una oferta y, en cascada, su compatibilidad.
class DeleteJobUseCase {
  const DeleteJobUseCase({required this._repository});

  final JobsRepository _repository;

  Future<Result<void>> call(String jobId) => _repository.delete(jobId);
}

@Riverpod(keepAlive: true)
DeleteJobUseCase deleteJobUseCase(Ref ref) =>
    DeleteJobUseCase(repository: ref.watch(jobsRepositoryProvider));
