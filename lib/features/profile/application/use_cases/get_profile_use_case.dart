import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_profile_use_case.g.dart';

/// Perfil completo: datos, experiencias, proyectos, habilidades y estudios.
class GetProfileUseCase {
  const GetProfileUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<ProfileData>> call() => _repository.load();
}

@Riverpod(keepAlive: true)
GetProfileUseCase getProfileUseCase(Ref ref) =>
    GetProfileUseCase(repository: ref.watch(profileRepositoryProvider));
