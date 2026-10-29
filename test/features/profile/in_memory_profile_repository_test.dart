import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/data/profile_repository.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

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
    final created = (await repository.load()).skills;
    expect(created.map((s) => s.id).toSet(), hasLength(2));
    expect(created.every((s) => s.id.isNotEmpty), isTrue);

    await repository.saveSkill(created.first.copyWith(years: 4));
    final edited = (await repository.load()).skills;
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

      final roles = (await repository.load()).experiences.map((e) => e.role);
      expect(roles, ['Senior', 'Mid', 'Junior']);
    },
  );

  test('elimina solo el elemento indicado', () async {
    await repository.saveProject(const Project(name: 'App Salud'));
    await repository.saveProject(const Project(name: 'App Banco'));
    final projects = (await repository.load()).projects;

    await repository.deleteProject(projects.first.id);
    expect((await repository.load()).projects.single.name, 'App Banco');
  });

  test('serializa la experiencia con claves snake_case', () {
    final json = experience('Senior', 2022).toJson();
    expect(json['start_date'], '2022-01-01T00:00:00.000');
    expect(json['end_date'], isNull);
    expect(Experience.fromJson(json), experience('Senior', 2022));
  });
}
