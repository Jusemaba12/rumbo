import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_experience_use_case.g.dart';

/// Borra una experiencia.
class DeleteExperienceUseCase {
  const DeleteExperienceUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(String id) => _repository.deleteExperience(id);
}

@Riverpod(keepAlive: true)
DeleteExperienceUseCase deleteExperienceUseCase(Ref ref) =>
    DeleteExperienceUseCase(repository: ref.watch(profileRepositoryProvider));
