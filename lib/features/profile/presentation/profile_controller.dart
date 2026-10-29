import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/data/auth_repository.dart';
import '../data/profile_repository.dart';
import '../domain/profile.dart';
import '../domain/profile_import.dart';

part 'profile_controller.g.dart';

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  ProfileRepository get _repository => ref.read(profileRepositoryProvider);

  @override
  Future<ProfileData> build() {
    // Recarga al entrar o salir para no mostrar datos de otra sesión.
    ref.watch(sessionChangesProvider);
    return ref.watch(profileRepositoryProvider).load();
  }

  Future<void> saveProfile(Profile profile) =>
      _mutate((repo) => repo.saveProfile(profile));

  Future<void> saveExperience(Experience experience) =>
      _mutate((repo) => repo.saveExperience(experience));

  Future<void> deleteExperience(String id) =>
      _mutate((repo) => repo.deleteExperience(id));

  Future<void> saveProject(Project project) =>
      _mutate((repo) => repo.saveProject(project));

  Future<void> deleteProject(String id) =>
      _mutate((repo) => repo.deleteProject(id));

  Future<void> saveSkill(Skill skill) =>
      _mutate((repo) => repo.saveSkill(skill));

  Future<void> deleteSkill(String id) =>
      _mutate((repo) => repo.deleteSkill(id));

  Future<void> saveEducation(Education education) =>
      _mutate((repo) => repo.saveEducation(education));

  Future<void> deleteEducation(String id) =>
      _mutate((repo) => repo.deleteEducation(id));

  Future<void> applyImport(ProfileImport plan) => _mutate((repo) async {
    if (plan.filledFields.isNotEmpty) await repo.saveProfile(plan.profile);
    for (final experience in plan.experiences) {
      await repo.saveExperience(experience);
    }
    for (final project in plan.projects) {
      await repo.saveProject(project);
    }
    for (final skill in plan.skills) {
      await repo.saveSkill(skill);
    }
    for (final education in plan.education) {
      await repo.saveEducation(education);
    }
  });

  /// Si la operación falla, el error llega a quien llamó y el estado no cambia.
  Future<void> _mutate(
    Future<void> Function(ProfileRepository repo) action,
  ) async {
    await action(_repository);
    state = AsyncData(await _repository.load());
  }
}
