import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_experience_use_case.g.dart';

/// Crea o reemplaza una experiencia.
class SaveExperienceUseCase {
  const SaveExperienceUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(Experience experience) =>
      _repository.saveExperience(experience);
}

@Riverpod(keepAlive: true)
SaveExperienceUseCase saveExperienceUseCase(Ref ref) =>
    SaveExperienceUseCase(repository: ref.watch(profileRepositoryProvider));
