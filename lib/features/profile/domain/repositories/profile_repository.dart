import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/shared/domain/result.dart';

abstract interface class ProfileRepository {
  Future<Result<ProfileData>> load();

  Future<Result<void>> saveProfile(Profile profile);

  /// Crea el elemento si su id está vacío; si no, lo reemplaza.
  Future<Result<void>> saveExperience(Experience experience);

  Future<Result<void>> deleteExperience(String id);

  Future<Result<void>> saveProject(Project project);

  Future<Result<void>> deleteProject(String id);

  Future<Result<void>> saveSkill(Skill skill);

  Future<Result<void>> deleteSkill(String id);

  Future<Result<void>> saveEducation(Education education);

  Future<Result<void>> deleteEducation(String id);
}
