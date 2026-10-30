import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'update_job_contact_use_case.g.dart';

/// Guarda el contacto del reclutador y la forma de postular.
class UpdateJobContactUseCase {
  const UpdateJobContactUseCase({required this._repository});

  final JobsRepository _repository;

  Future<Result<void>> call(Job job) => _repository.updateContact(job);
}

@Riverpod(keepAlive: true)
UpdateJobContactUseCase updateJobContactUseCase(Ref ref) =>
    UpdateJobContactUseCase(repository: ref.watch(jobsRepositoryProvider));
