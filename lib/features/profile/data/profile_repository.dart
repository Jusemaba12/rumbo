import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/config/env.dart';
import '../domain/profile.dart';
import 'profile_rows.dart';

part 'profile_repository.g.dart';

abstract interface class ProfileRepository {
  Future<ProfileData> load();
  Future<void> saveProfile(Profile profile);

  /// Crea el elemento si su id está vacío; si no, lo reemplaza.
  Future<void> saveExperience(Experience experience);
  Future<void> deleteExperience(String id);
  Future<void> saveProject(Project project);
  Future<void> deleteProject(String id);
  Future<void> saveSkill(Skill skill);
  Future<void> deleteSkill(String id);
  Future<void> saveEducation(Education education);
  Future<void> deleteEducation(String id);
}

/// Lee y escribe en Supabase; la seguridad por fila limita todo al usuario.
class SupabaseProfileRepository implements ProfileRepository {
  SupabaseProfileRepository(this._client);

  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  @override
  Future<ProfileData> load() async {
    final (profile, experiences, projects, skills, education) = await (
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
  }

  @override
  Future<void> saveProfile(Profile profile) => _client
      .from(ProfileTables.profiles)
      .upsert(profileToRow(profile, userId: _userId));

  @override
  Future<void> saveExperience(Experience experience) => _client
      .from(ProfileTables.experiences)
      .upsert(experienceToRow(experience));

  @override
  Future<void> deleteExperience(String id) =>
      _client.from(ProfileTables.experiences).delete().eq('id', id);

  @override
  Future<void> saveProject(Project project) =>
      _client.from(ProfileTables.projects).upsert(projectToRow(project));

  @override
  Future<void> deleteProject(String id) =>
      _client.from(ProfileTables.projects).delete().eq('id', id);

  @override
  Future<void> saveSkill(Skill skill) =>
      _client.from(ProfileTables.skills).upsert(skillToRow(skill));

  @override
  Future<void> deleteSkill(String id) =>
      _client.from(ProfileTables.skills).delete().eq('id', id);

  @override
  Future<void> saveEducation(Education education) =>
      _client.from(ProfileTables.education).upsert(educationToRow(education));

  @override
  Future<void> deleteEducation(String id) =>
      _client.from(ProfileTables.education).delete().eq('id', id);
}

/// Guarda el perfil solo mientras la app está abierta (modo local).
class InMemoryProfileRepository implements ProfileRepository {
  InMemoryProfileRepository([this._data = const ProfileData()]);

  static const _uuid = Uuid();

  ProfileData _data;

  @override
  Future<ProfileData> load() async => _data;

  @override
  Future<void> saveProfile(Profile profile) async {
    _data = _data.copyWith(profile: profile);
  }

  @override
  Future<void> saveExperience(Experience experience) async {
    final saved = experience.id.isEmpty
        ? experience.copyWith(id: _uuid.v4())
        : experience;
    _data = _data.copyWith(
      experiences: sortExperiences([
        ..._data.experiences.where((e) => e.id != saved.id),
        saved,
      ]),
    );
  }

  @override
  Future<void> deleteExperience(String id) async {
    _data = _data.copyWith(
      experiences: _data.experiences.where((e) => e.id != id).toList(),
    );
  }

  @override
  Future<void> saveProject(Project project) async {
    final saved = project.id.isEmpty
        ? project.copyWith(id: _uuid.v4())
        : project;
    _data = _data.copyWith(projects: _replace(_data.projects, saved, saved.id));
  }

  @override
  Future<void> deleteProject(String id) async {
    _data = _data.copyWith(
      projects: _data.projects.where((p) => p.id != id).toList(),
    );
  }

  @override
  Future<void> saveSkill(Skill skill) async {
    final saved = skill.id.isEmpty ? skill.copyWith(id: _uuid.v4()) : skill;
    _data = _data.copyWith(skills: _replace(_data.skills, saved, saved.id));
  }

  @override
  Future<void> deleteSkill(String id) async {
    _data = _data.copyWith(
      skills: _data.skills.where((s) => s.id != id).toList(),
    );
  }

  @override
  Future<void> saveEducation(Education education) async {
    final saved = education.id.isEmpty
        ? education.copyWith(id: _uuid.v4())
        : education;
    _data = _data.copyWith(
      education: sortEducation([
        ..._data.education.where((e) => e.id != saved.id),
        saved,
      ]),
    );
  }

  @override
  Future<void> deleteEducation(String id) async {
    _data = _data.copyWith(
      education: _data.education.where((e) => e.id != id).toList(),
    );
  }

  /// Sustituye en su sitio el elemento con ese id, o lo añade al final.
  List<T> _replace<T>(List<T> items, T saved, String id) {
    final index = items.indexWhere((item) => _idOf(item) == id);
    if (index == -1) return [...items, saved];
    return [...items]..[index] = saved;
  }

  String _idOf(Object? item) => switch (item) {
    Project(:final id) => id,
    Skill(:final id) => id,
    _ => '',
  };
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryProfileRepository();
  return SupabaseProfileRepository(Supabase.instance.client);
}
