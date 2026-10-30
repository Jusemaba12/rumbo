import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_skill_use_case.g.dart';

/// Crea o reemplaza una habilidad.
class SaveSkillUseCase {
  const SaveSkillUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(Skill skill) => _repository.saveSkill(skill);
}

@Riverpod(keepAlive: true)
SaveSkillUseCase saveSkillUseCase(Ref ref) =>
    SaveSkillUseCase(repository: ref.watch(profileRepositoryProvider));
