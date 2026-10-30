import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/profile_import.dart';
import 'package:rumbo/features/profile/infrastructure/mappers/imported_profile_mapper.dart';

void main() {
  final Experience acme = Experience(
    id: 'exp-1',
    company: 'Acme',
    role: 'Flutter Developer',
    startDate: DateTime(2022),
  );

  group('planProfileImport', () {
    test('rellena solo los campos vacíos y no toca lo escrito', () {
      final ProfileImport plan = planProfileImport(
        current: const ProfileData(
          profile: Profile(
            fullName: 'Juan',
            links: <String, String>{'github': 'https://github.com/yo'},
          ),
        ),
        imported: const ProfileData(
          profile: Profile(
            fullName: 'Juan Manzano',
            headline: 'Desarrollador Flutter',
            links: <String, String>{
              'github': 'https://github.com/otro',
              'linkedin': 'https://linkedin.com/in/yo',
            },
          ),
        ),
      );
      expect(plan.profile.fullName, 'Juan');
      expect(plan.profile.headline, 'Desarrollador Flutter');
      expect(plan.profile.links, <String, String>{
        'github': 'https://github.com/yo',
        'linkedin': 'https://linkedin.com/in/yo',
      });
      expect(plan.filledFields, <ProfileField>{
        ProfileField.headline,
        ProfileField.links,
      });
    });

    test('añade solo experiencia, proyectos y habilidades nuevos', () {
      final ProfileImport plan = planProfileImport(
        current: ProfileData(
          experiences: <Experience>[acme],
          skills: const <Skill>[Skill(id: 's1', name: 'Flutter')],
        ),
        imported: ProfileData(
          experiences: <Experience>[
            acme.copyWith(id: '', company: ' ACME ', role: 'flutter developer'),
            Experience(
              company: 'Beta',
              role: 'Mobile Dev',
              startDate: DateTime(2020),
            ),
          ],
          projects: const <Project>[
            Project(name: 'App Salud'),
            Project(name: 'app salud'),
          ],
          skills: const <Skill>[
            Skill(name: 'flutter'),
            Skill(name: 'Dart'),
            Skill(name: ' '),
          ],
        ),
      );
      expect(plan.experiences.map((Experience e) => e.company), <String>[
        'Beta',
      ]);
      expect(plan.projects.map((Project p) => p.name), <String>['App Salud']);
      expect(plan.skills.map((Skill s) => s.name), <String>['Dart']);
      expect(plan.isEmpty, isFalse);
    });

    test('rellena contacto y añade estudios nuevos', () {
      final ProfileImport plan = planProfileImport(
        current: const ProfileData(
          profile: Profile(email: 'yo@ejemplo.com'),
          education: <Education>[
            Education(id: 'ed1', institution: 'UFPS', degree: 'Ingeniería'),
          ],
        ),
        imported: const ProfileData(
          profile: Profile(email: 'otro@ejemplo.com', phone: '+57 300'),
          education: <Education>[
            Education(institution: 'ufps', degree: 'ingeniería'),
            Education(institution: 'Platzi', degree: 'Flutter'),
          ],
        ),
      );
      expect(plan.profile.email, 'yo@ejemplo.com');
      expect(plan.profile.phone, '+57 300');
      expect(plan.filledFields, <ProfileField>{ProfileField.phone});
      expect(plan.education.map((Education e) => e.institution), <String>[
        'Platzi',
      ]);
    });

    test('si no hay nada nuevo el plan está vacío', () {
      final ProfileData data = ProfileData(
        profile: const Profile(fullName: 'Juan'),
        experiences: <Experience>[acme],
      );
      expect(planProfileImport(current: data, imported: data).isEmpty, isTrue);
    });
  });

  test('convierte la respuesta de import-resume', () {
    final ProfileData data = importedProfileFromJson(<String, dynamic>{
      'profile': <String, Object>{
        'full_name': 'Juan Manzano',
        'headline': 'Desarrollador Flutter',
        'summary': '',
        'location': 'Bogotá',
        'links': <String, String>{
          'linkedin': '',
          'github': 'https://github.com/yo',
          'portfolio': '',
        },
      },
      'experiences': <Map<String, Object?>>[
        <String, Object>{
          'company': 'Beta',
          'role': 'Mobile Dev',
          'start_date': '2020-01-01',
          'end_date': '2021-06-01',
          'achievements': <String>['Publiqué 3 apps'],
          'technologies': <String>['Flutter'],
        },
        <String, Object?>{
          'company': 'Acme',
          'role': 'Flutter Developer',
          'start_date': '2021-07-01',
          'end_date': null,
          'achievements': <dynamic>[],
          'technologies': <dynamic>[],
        },
      ],
      'projects': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'App Salud',
          'description': '',
          'url': null,
          'technologies': <dynamic>[],
        },
      ],
      'skills': <Map<String, Object>>[
        <String, Object>{'name': 'Dart', 'category': 'language', 'years': 4},
      ],
    });
    expect(data.profile.links, <String, String>{
      'github': 'https://github.com/yo',
    });
    expect(data.experiences.first.company, 'Acme');
    expect(data.experiences.last.endDate, DateTime(2021, 6));
    expect(data.projects.single.url, isNull);
    expect(data.skills.single.category, SkillCategory.language);
    expect(data.experiences.every((Experience e) => e.id.isEmpty), isTrue);
  });
}
