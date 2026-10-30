import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/mappers/profile_row_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Lee y escribe en Supabase; la seguridad por fila limita todo al usuario.
class SupabaseProfileRepository implements ProfileRepository {
  SupabaseProfileRepository(this._client);

  static const String _tag = 'SupabaseProfileRepository';

  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  @override
  Future<Result<ProfileData>> load() => guard(
    tag: _tag,
    run: () async {
      final (
        PostgrestMap? profile,
        PostgrestList experiences,
        PostgrestList projects,
        PostgrestList skills,
        PostgrestList education,
      ) = await (
        _client.from(ProfileTables.profiles).select().maybeSingle(),
        _client.from(ProfileTables.experiences).select(),
        _client
            .from(ProfileTables.projects)
            .select()
            .order('position', ascending: true),
        _client
            .from(ProfileTables.skills)
            .select()
            .order('name', ascending: true),
        _client.from(ProfileTables.education).select(),
      ).wait;
      return ProfileData(
        profile: profile == null ? const Profile() : Profile.fromJson(profile),
        experiences: sortExperiences(experiences.map(experienceFromRow)),
        projects: projects.map(Project.fromJson).toList(),
        skills: skills.map(Skill.fromJson).toList(),
        education: sortEducation(education.map(Education.fromJson)),
      );
    },
  );

  @override
  Future<Result<void>> saveProfile(Profile profile) => _upsert(
    table: ProfileTables.profiles,
    row: profileToRow(profile, userId: _userId),
  );

  @override
  Future<Result<void>> saveExperience(Experience experience) => _upsert(
    table: ProfileTables.experiences,
    row: experienceToRow(experience),
  );

  @override
  Future<Result<void>> deleteExperience(String id) =>
      _delete(table: ProfileTables.experiences, id: id);

  @override
  Future<Result<void>> saveProject(Project project) =>
      _upsert(table: ProfileTables.projects, row: projectToRow(project));

  @override
  Future<Result<void>> deleteProject(String id) =>
      _delete(table: ProfileTables.projects, id: id);

  @override
  Future<Result<void>> saveSkill(Skill skill) =>
      _upsert(table: ProfileTables.skills, row: skillToRow(skill));

  @override
  Future<Result<void>> deleteSkill(String id) =>
      _delete(table: ProfileTables.skills, id: id);

  @override
  Future<Result<void>> saveEducation(Education education) =>
      _upsert(table: ProfileTables.education, row: educationToRow(education));

  @override
  Future<Result<void>> deleteEducation(String id) =>
      _delete(table: ProfileTables.education, id: id);

  Future<Result<void>> _upsert({
    required String table,
    required Map<String, dynamic> row,
  }) => guard(tag: _tag, run: () => _client.from(table).upsert(row));

  Future<Result<void>> _delete({required String table, required String id}) =>
      guard(tag: _tag, run: () => _client.from(table).delete().eq('id', id));
}
