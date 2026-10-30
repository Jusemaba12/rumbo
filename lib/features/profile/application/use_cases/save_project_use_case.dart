import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_project_use_case.g.dart';

/// Crea o reemplaza un proyecto.
class SaveProjectUseCase {
  const SaveProjectUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(Project project) =>
      _repository.saveProject(project);
}

@Riverpod(keepAlive: true)
SaveProjectUseCase saveProjectUseCase(Ref ref) =>
    SaveProjectUseCase(repository: ref.watch(profileRepositoryProvider));
