import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_skill_use_case.g.dart';

/// Borra una habilidad.
class DeleteSkillUseCase {
  const DeleteSkillUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(String id) => _repository.deleteSkill(id);
}

@Riverpod(keepAlive: true)
DeleteSkillUseCase deleteSkillUseCase(Ref ref) =>
    DeleteSkillUseCase(repository: ref.watch(profileRepositoryProvider));
