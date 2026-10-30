import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/domain/services/profile_import.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'apply_profile_import_use_case.g.dart';

/// Guarda lo que el usuario confirmó de una HV importada. Se detiene en el
/// primer fallo.
class ApplyProfileImportUseCase {
  const ApplyProfileImportUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(ProfileImport plan) async {
    final List<Future<Result<void>> Function()> steps =
        <Future<Result<void>> Function()>[
          if (plan.filledFields.isNotEmpty)
            () => _repository.saveProfile(plan.profile),
          for (final Experience experience in plan.experiences)
            () => _repository.saveExperience(experience),
          for (final Project project in plan.projects)
            () => _repository.saveProject(project),
          for (final Skill skill in plan.skills)
            () => _repository.saveSkill(skill),
          for (final Education education in plan.education)
            () => _repository.saveEducation(education),
        ];
    for (final Future<Result<void>> Function() step in steps) {
      final Result<void> result = await step();
      if (!result.isOk) return result;
    }
    return ok;
  }
}

@Riverpod(keepAlive: true)
ApplyProfileImportUseCase applyProfileImportUseCase(Ref ref) =>
    ApplyProfileImportUseCase(repository: ref.watch(profileRepositoryProvider));
