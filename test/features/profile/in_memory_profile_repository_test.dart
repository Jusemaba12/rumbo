import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';

void main() {
  late InMemoryProfileRepository repository;

  setUp(() => repository = InMemoryProfileRepository());

  Experience experience(String role, int startYear, {int? endYear}) =>
      Experience(
        company: 'Acme',
        role: role,
        startDate: DateTime(startYear),
        endDate: endYear == null ? null : DateTime(endYear),
      );

  test('asigna un id al crear y reemplaza al editar', () async {
    await repository.saveSkill(const Skill(name: 'Flutter'));
    await repository.saveSkill(const Skill(name: 'Dart'));
    final List<Skill> created = (await repository.load()).getOrThrow().skills;
    expect(created.map((Skill s) => s.id).toSet(), hasLength(2));
    expect(created.every((Skill s) => s.id.isNotEmpty), isTrue);

    await repository.saveSkill(created.first.copyWith(years: 4));
    final List<Skill> edited = (await repository.load()).getOrThrow().skills;
    expect(edited, hasLength(2));
    expect(edited.first.name, 'Flutter');
    expect(edited.first.years, 4);
  });

  test(
    'ordena la experiencia: actual primero, luego la más reciente',
    () async {
      await repository.saveExperience(
        experience('Junior', 2018, endYear: 2020),
      );
      await repository.saveExperience(experience('Senior', 2022));
      await repository.saveExperience(experience('Mid', 2020, endYear: 2022));

      final Iterable<String> roles = (await repository.load())
          .getOrThrow()
          .experiences
          .map((Experience e) => e.role);
      expect(roles, <String>['Senior', 'Mid', 'Junior']);
    },
  );

  test('elimina solo el elemento indicado', () async {
    await repository.saveProject(const Project(name: 'App Salud'));
    await repository.saveProject(const Project(name: 'App Banco'));
    final List<Project> projects = (await repository.load())
        .getOrThrow()
        .projects;

    await repository.deleteProject(projects.first.id);
    expect(
      (await repository.load()).getOrThrow().projects.single.name,
      'App Banco',
    );
  });

  test('serializa la experiencia con claves snake_case', () {
    final Map<String, dynamic> json = experience('Senior', 2022).toJson();
    expect(json['start_date'], '2022-01-01T00:00:00.000');
    expect(json['end_date'], isNull);
    expect(Experience.fromJson(json), experience('Senior', 2022));
  });
}
