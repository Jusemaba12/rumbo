import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/data/resume_importer.dart';
import 'package:rumbo/features/profile/domain/profile.dart';
import 'package:rumbo/features/profile/domain/profile_import.dart';

void main() {
  final acme = Experience(
    id: 'exp-1',
    company: 'Acme',
    role: 'Flutter Developer',
    startDate: DateTime(2022),
  );

  group('planProfileImport', () {
    test('rellena solo los campos vacíos y no toca lo escrito', () {
      final plan = planProfileImport(
        const ProfileData(
          profile: Profile(
            fullName: 'Juan',
            links: {'github': 'https://github.com/yo'},
          ),
        ),
        const ProfileData(
          profile: Profile(
            fullName: 'Juan Manzano',
            headline: 'Desarrollador Flutter',
            links: {
              'github': 'https://github.com/otro',
              'linkedin': 'https://linkedin.com/in/yo',
            },
          ),
        ),
      );
      expect(plan.profile.fullName, 'Juan');
      expect(plan.profile.headline, 'Desarrollador Flutter');
      expect(plan.profile.links, {
        'github': 'https://github.com/yo',
        'linkedin': 'https://linkedin.com/in/yo',
      });
      expect(plan.filledFields, {ProfileField.headline, ProfileField.links});
    });

    test('añade solo experiencia, proyectos y habilidades nuevos', () {
      final plan = planProfileImport(
        ProfileData(
          experiences: [acme],
          skills: const [Skill(id: 's1', name: 'Flutter')],
        ),
        ProfileData(
          experiences: [
            acme.copyWith(id: '', company: ' ACME ', role: 'flutter developer'),
            Experience(
              company: 'Beta',
              role: 'Mobile Dev',
              startDate: DateTime(2020),
            ),
          ],
          projects: const [
            Project(name: 'App Salud'),
            Project(name: 'app salud'),
          ],
          skills: const [
            Skill(name: 'flutter'),
            Skill(name: 'Dart'),
            Skill(name: ' '),
          ],
        ),
      );
      expect(plan.experiences.map((e) => e.company), ['Beta']);
      expect(plan.projects.map((p) => p.name), ['App Salud']);
      expect(plan.skills.map((s) => s.name), ['Dart']);
      expect(plan.isEmpty, isFalse);
    });

    test('rellena contacto y añade estudios nuevos', () {
      final plan = planProfileImport(
        const ProfileData(
          profile: Profile(email: 'yo@ejemplo.com'),
          education: [
            Education(id: 'ed1', institution: 'UFPS', degree: 'Ingeniería'),
          ],
        ),
        const ProfileData(
          profile: Profile(email: 'otro@ejemplo.com', phone: '+57 300'),
          education: [
            Education(institution: 'ufps', degree: 'ingeniería'),
            Education(institution: 'Platzi', degree: 'Flutter'),
          ],
        ),
      );
      expect(plan.profile.email, 'yo@ejemplo.com');
      expect(plan.profile.phone, '+57 300');
      expect(plan.filledFields, {ProfileField.phone});
      expect(plan.education.map((e) => e.institution), ['Platzi']);
    });

    test('si no hay nada nuevo el plan está vacío', () {
      final data = ProfileData(
        profile: const Profile(fullName: 'Juan'),
        experiences: [acme],
      );
      expect(planProfileImport(data, data).isEmpty, isTrue);
    });
  });

  test('convierte la respuesta de import-resume', () {
    final data = importedProfileFromJson({
      'profile': {
        'full_name': 'Juan Manzano',
        'headline': 'Desarrollador Flutter',
        'summary': '',
        'location': 'Bogotá',
        'links': {
          'linkedin': '',
          'github': 'https://github.com/yo',
          'portfolio': '',
        },
      },
      'experiences': [
        {
          'company': 'Beta',
          'role': 'Mobile Dev',
          'start_date': '2020-01-01',
          'end_date': '2021-06-01',
          'achievements': ['Publiqué 3 apps'],
          'technologies': ['Flutter'],
        },
        {
          'company': 'Acme',
          'role': 'Flutter Developer',
          'start_date': '2021-07-01',
          'end_date': null,
          'achievements': [],
          'technologies': [],
        },
      ],
      'projects': [
        {
          'name': 'App Salud',
          'description': '',
          'url': null,
          'technologies': [],
        },
      ],
      'skills': [
        {'name': 'Dart', 'category': 'language', 'years': 4},
      ],
    });
    expect(data.profile.links, {'github': 'https://github.com/yo'});
    expect(data.experiences.first.company, 'Acme');
    expect(data.experiences.last.endDate, DateTime(2021, 6));
    expect(data.projects.single.url, isNull);
    expect(data.skills.single.category, SkillCategory.language);
    expect(data.experiences.every((e) => e.id.isEmpty), isTrue);
  });
}
