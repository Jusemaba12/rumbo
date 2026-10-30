import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/keyword_analysis.dart';

void main() {
  final ProfileData data = ProfileData(
    profile: const Profile(
      headline: 'Flutter Developer',
      summary: 'Integración de APIs RESTful y pruebas unitarias.',
    ),
    experiences: <Experience>[
      Experience(
        company: 'GSE',
        role: 'Flutter Developer',
        startDate: DateTime(2024, 9),
        achievements: const <String>[
          'Configuré la integración continua con GitHub',
        ],
        technologies: const <String>['Riverpod'],
      ),
    ],
    skills: const <Skill>[
      Skill(name: 'Firebase'),
      Skill(name: 'Dart'),
    ],
  );
  final ResumeSections sections = ResumeSections(data);

  test('las variantes de la IA y del diccionario cuentan como la palabra', () {
    expect(
      keywordTerms('REST API'),
      containsAll(<dynamic>['RESTful', 'APIs REST']),
    );
    expect(
      keywordTerms('Pipelines', aliases: <String>['CI/CD']),
      containsAll(<dynamic>['Pipelines', 'CI/CD', 'integración continua']),
    );
    expect(sections.presenceOf(keywordTerms('REST API')).found, isTrue);
    expect(sections.presenceOf(keywordTerms('Unit testing')).found, isTrue);
    expect(sections.presenceOf(keywordTerms('GraphQL')).found, isFalse);
  });

  test('distingue dónde aparece: experiencia, perfil o solo habilidades', () {
    final KeywordPresence ci = sections.presenceOf(keywordTerms('CI/CD'));
    expect(ci.inExperience, isTrue);
    expect(ci.onlyInSkills, isFalse);

    final KeywordPresence firebase = sections.presenceOf(
      keywordTerms('Firebase'),
    );
    expect(firebase.inSkills, isTrue);
    expect(firebase.onlyInSkills, isTrue);

    final KeywordPresence rest = sections.presenceOf(keywordTerms('REST API'));
    expect(rest.inSummary, isTrue);
    expect(rest.inExperience, isFalse);
  });

  test('cuenta en cuántas ofertas aparece y deja fuera las descartadas', () {
    SavedJob job(String title, List<String> requirements, {bool off = false}) =>
        SavedJob(
          job: Job(
            title: title,
            company: 'Empresa',
            requirements: requirements,
            dismissed: off,
            discovered: off,
          ),
        );
    final List<SavedJob> jobs = marketJobs(<SavedJob>[
      job('Flutter Developer', <String>[
        'Experiencia con RESTful APIs',
        'Bloc',
      ]),
      job('Mobile Engineer', <String>['REST', 'CI/CD']),
      job('Backend', <String>['GraphQL']),
      job('Descartada', <String>['REST'], off: true),
      job('Sin texto', <String>[]),
    ]);
    expect(jobs, hasLength(3));
    expect(offersMentioning(jobs: jobs, terms: keywordTerms('REST API')), 2);
    expect(offersMentioning(jobs: jobs, terms: keywordTerms('Bloc')), 1);
    expect(offersMentioning(jobs: jobs, terms: keywordTerms('Kotlin')), 0);
  });
}
