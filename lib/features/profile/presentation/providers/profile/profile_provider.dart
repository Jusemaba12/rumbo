import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/profile/application/use_cases/apply_profile_import_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/delete_education_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/delete_experience_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/delete_project_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/delete_skill_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/get_profile_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/save_education_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/save_experience_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/save_profile_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/save_project_use_case.dart';
import 'package:rumbo/features/profile/application/use_cases/save_skill_use_case.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/profile_import.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'profile_provider.g.dart';

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  @override
  Future<ProfileData> build() async {
    // Recarga al entrar o salir para no mostrar datos de otra sesión.
    ref.watch(sessionChangesProvider);
    return (await ref.watch(getProfileUseCaseProvider)()).getOrThrow();
  }

  Future<Result<void>> saveProfile(Profile profile) =>
      _thenReload(ref.read(saveProfileUseCaseProvider)(profile));

  Future<Result<void>> saveExperience(Experience experience) =>
      _thenReload(ref.read(saveExperienceUseCaseProvider)(experience));

  Future<Result<void>> deleteExperience(String id) =>
      _thenReload(ref.read(deleteExperienceUseCaseProvider)(id));

  Future<Result<void>> saveProject(Project project) =>
      _thenReload(ref.read(saveProjectUseCaseProvider)(project));

  Future<Result<void>> deleteProject(String id) =>
      _thenReload(ref.read(deleteProjectUseCaseProvider)(id));

  Future<Result<void>> saveSkill(Skill skill) =>
      _thenReload(ref.read(saveSkillUseCaseProvider)(skill));

  Future<Result<void>> deleteSkill(String id) =>
      _thenReload(ref.read(deleteSkillUseCaseProvider)(id));

  Future<Result<void>> saveEducation(Education education) =>
      _thenReload(ref.read(saveEducationUseCaseProvider)(education));

  Future<Result<void>> deleteEducation(String id) =>
      _thenReload(ref.read(deleteEducationUseCaseProvider)(id));

  Future<Result<void>> applyImport(ProfileImport plan) =>
      _thenReload(ref.read(applyProfileImportUseCaseProvider)(plan));

  /// Si la operación falla, el estado no cambia y quien llamó recibe el fallo.
  Future<Result<void>> _thenReload(Future<Result<void>> action) async {
    final Result<void> result = await action;
    if (!result.isOk) return result;
    final Result<ProfileData> data = await ref.read(
      getProfileUseCaseProvider,
    )();
    if (data case Ok<ProfileData>(:final ProfileData value)) {
      state = AsyncData<ProfileData>(value);
    }
    return result;
  }
}
