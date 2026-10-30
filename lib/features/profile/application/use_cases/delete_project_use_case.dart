import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_project_use_case.g.dart';

/// Borra un proyecto.
class DeleteProjectUseCase {
  const DeleteProjectUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(String id) => _repository.deleteProject(id);
}

@Riverpod(keepAlive: true)
DeleteProjectUseCase deleteProjectUseCase(Ref ref) =>
    DeleteProjectUseCase(repository: ref.watch(profileRepositoryProvider));
