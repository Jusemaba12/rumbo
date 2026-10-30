import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:uuid/uuid.dart';

/// Guarda el perfil solo mientras la app está abierta (modo local).
class InMemoryProfileRepository implements ProfileRepository {
  InMemoryProfileRepository([this._data = const ProfileData()]);

  static const Uuid _uuid = Uuid();

  ProfileData _data;

  @override
  Future<Result<ProfileData>> load() async => Ok<ProfileData>(_data);

  @override
  Future<Result<void>> saveProfile(Profile profile) async {
    _data = _data.copyWith(profile: profile);
    return ok;
  }

  @override
  Future<Result<void>> saveExperience(Experience experience) async {
    final Experience saved = experience.id.isEmpty
        ? experience.copyWith(id: _uuid.v4())
        : experience;
    _data = _data.copyWith(
      experiences: sortExperiences(<Experience>[
        ..._data.experiences.where((Experience e) => e.id != saved.id),
        saved,
      ]),
    );
    return ok;
  }

  @override
  Future<Result<void>> deleteExperience(String id) async {
    _data = _data.copyWith(
      experiences: _data.experiences
          .where((Experience e) => e.id != id)
          .toList(),
    );
    return ok;
  }

  @override
  Future<Result<void>> saveProject(Project project) async {
    final Project saved = project.id.isEmpty
        ? project.copyWith(id: _uuid.v4())
        : project;
    _data = _data.copyWith(
      projects: _replace(items: _data.projects, saved: saved, id: saved.id),
    );
    return ok;
  }

  @override
  Future<Result<void>> deleteProject(String id) async {
    _data = _data.copyWith(
      projects: _data.projects.where((Project p) => p.id != id).toList(),
    );
    return ok;
  }

  @override
  Future<Result<void>> saveSkill(Skill skill) async {
    final Skill saved = skill.id.isEmpty
        ? skill.copyWith(id: _uuid.v4())
        : skill;
    _data = _data.copyWith(
      skills: _replace(items: _data.skills, saved: saved, id: saved.id),
    );
    return ok;
  }

  @override
  Future<Result<void>> deleteSkill(String id) async {
    _data = _data.copyWith(
      skills: _data.skills.where((Skill s) => s.id != id).toList(),
    );
    return ok;
  }

  @override
  Future<Result<void>> saveEducation(Education education) async {
    final Education saved = education.id.isEmpty
        ? education.copyWith(id: _uuid.v4())
        : education;
    _data = _data.copyWith(
      education: sortEducation(<Education>[
        ..._data.education.where((Education e) => e.id != saved.id),
        saved,
      ]),
    );
    return ok;
  }

  @override
  Future<Result<void>> deleteEducation(String id) async {
    _data = _data.copyWith(
      education: _data.education.where((Education e) => e.id != id).toList(),
    );
    return ok;
  }

  /// Sustituye en su sitio el elemento con ese id, o lo añade al final.
  List<T> _replace<T>({
    required List<T> items,
    required T saved,
    required String id,
  }) {
    final int index = items.indexWhere((T item) => _idOf(item) == id);
    if (index == -1) return <T>[...items, saved];
    return <T>[...items]..[index] = saved;
  }

  String _idOf(Object? item) => switch (item) {
    Project(:final String id) => id,
    Skill(:final String id) => id,
    _ => '',
  };
}
