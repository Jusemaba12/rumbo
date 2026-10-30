import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/repositories/resume_versions_repository.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_latest_resume_version_use_case.g.dart';

/// Última HV adaptada guardada para la oferta; nula si no hay.
class GetLatestResumeVersionUseCase {
  const GetLatestResumeVersionUseCase({required this._repository});

  final ResumeVersionsRepository _repository;

  Future<Result<ApplicationDraft?>> call(String jobId) =>
      _repository.latestForJob(jobId);
}

@Riverpod(keepAlive: true)
GetLatestResumeVersionUseCase getLatestResumeVersionUseCase(Ref ref) =>
    GetLatestResumeVersionUseCase(
      repository: ref.watch(resumeVersionsRepositoryProvider),
    );
