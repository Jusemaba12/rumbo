import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_profile_use_case.g.dart';

/// Guarda los datos básicos del perfil.
class SaveProfileUseCase {
  const SaveProfileUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(Profile profile) =>
      _repository.saveProfile(profile);
}

@Riverpod(keepAlive: true)
SaveProfileUseCase saveProfileUseCase(Ref ref) =>
    SaveProfileUseCase(repository: ref.watch(profileRepositoryProvider));
