import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/repositories/resume_versions_repository.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_resume_version_use_case.g.dart';

/// Guarda la HV adaptada y devuelve el id de la versión.
class SaveResumeVersionUseCase {
  const SaveResumeVersionUseCase({required this._repository});

  final ResumeVersionsRepository _repository;

  Future<Result<String>> call(ApplicationDraft draft) =>
      _repository.save(draft);
}

@Riverpod(keepAlive: true)
SaveResumeVersionUseCase saveResumeVersionUseCase(Ref ref) =>
    SaveResumeVersionUseCase(
      repository: ref.watch(resumeVersionsRepositoryProvider),
    );
