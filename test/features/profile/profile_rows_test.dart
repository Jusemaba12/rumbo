import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/data/profile_rows.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

void main() {
  test('la experiencia nueva no envía id y las fechas van sin hora', () {
    final row = experienceToRow(
      Experience(
        company: 'Acme',
        role: 'Flutter Developer',
        startDate: DateTime(2022, 3),
        endDate: DateTime(2024, 11),
        achievements: const ['Publiqué 3 apps'],
      ),
    );
    expect(row.containsKey('id'), isFalse);
    expect(row['start_date'], '2022-03-01');
    expect(row['end_date'], '2024-11-01');
    expect(row['achievements'], ['Publiqué 3 apps']);
  });

  test('la experiencia existente conserva su id y lee filas de Postgres', () {
    final row = {
      'id': 'exp-1',
      'user_id': 'user-1',
      'company': 'Acme',
      'role': 'Flutter Developer',
      'start_date': '2022-03-01',
      'end_date': null,
      'achievements': ['Publiqué 3 apps'],
      'technologies': ['Flutter'],
      'position': 0,
    };
    final experience = experienceFromRow(row);
    expect(experience.startDate, DateTime(2022, 3));
    expect(experience.isCurrent, isTrue);
    expect(experienceToRow(experience)['id'], 'exp-1');
  });

  test('el perfil se guarda con el usuario y enlaces en snake_case', () {
    final row = profileToRow(
      const Profile(
        fullName: 'Ana',
        links: {ProfileLinks.github: 'https://github.com/ana'},
      ),
      userId: 'user-1',
    );
    expect(row['user_id'], 'user-1');
    expect(row['full_name'], 'Ana');
    expect(row['links'], {'github': 'https://github.com/ana'});
  });

  test('idiomas y expectativa salarial van a sus columnas', () {
    final profile = const Profile(
      fullName: 'Ana',
      salaryCopMin: 6000000,
      salaryUsdMax: 2500,
    ).withEnglish(LanguageLevel.c1);
    final row = profileToRow(profile, userId: 'user-1');
    expect(row['languages'], [
      {'language': 'en', 'level': 'C1'},
    ]);
    expect(row['salary_cop_min'], 6000000);
    expect(row['salary_cop_max'], isNull);
    expect(row['salary_usd_max'], 2500);

    final back = Profile.fromJson({
      ...row,
      // Un nivel desconocido no rompe la lectura.
      'languages': [
        {'language': 'en', 'level': 'C1'},
        {'language': 'fr', 'level': 'X9'},
      ],
    });
    expect(back.englishLevel, LanguageLevel.c1);
    expect(back.languages.last.level, isNull);
    expect(back.withEnglish(null).englishLevel, isNull);
    expect(back.hasSalaryExpectation, isTrue);
    expect(const Profile().hasSalaryExpectation, isFalse);
  });

  test('una categoría desconocida se lee como «otra»', () {
    final skill = Skill.fromJson({
      'id': 's1',
      'user_id': 'user-1',
      'name': 'Scrum',
      'category': '',
      'years': null,
    });
    expect(skill.category, SkillCategory.other);
    expect(skillToRow(skill)['category'], 'other');
  });
}
