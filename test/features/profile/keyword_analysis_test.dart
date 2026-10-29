import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/profile/domain/keyword_analysis.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

void main() {
  final data = ProfileData(
    profile: const Profile(
      headline: 'Flutter Developer',
      summary: 'Integración de APIs RESTful y pruebas unitarias.',
    ),
    experiences: [
      Experience(
        company: 'GSE',
        role: 'Flutter Developer',
        startDate: DateTime(2024, 9),
        achievements: const ['Configuré la integración continua con GitHub'],
        technologies: const ['Riverpod'],
      ),
    ],
    skills: const [
      Skill(name: 'Firebase'),
      Skill(name: 'Dart'),
    ],
  );
  final sections = ResumeSections(data);

  test('las variantes de la IA y del diccionario cuentan como la palabra', () {
    expect(keywordTerms('REST API'), containsAll(['RESTful', 'APIs REST']));
    expect(
      keywordTerms('Pipelines', ['CI/CD']),
      containsAll(['Pipelines', 'CI/CD', 'integración continua']),
    );
    expect(sections.presenceOf(keywordTerms('REST API')).found, isTrue);
    expect(sections.presenceOf(keywordTerms('Unit testing')).found, isTrue);
    expect(sections.presenceOf(keywordTerms('GraphQL')).found, isFalse);
  });

  test('distingue dónde aparece: experiencia, perfil o solo habilidades', () {
    final ci = sections.presenceOf(keywordTerms('CI/CD'));
    expect(ci.inExperience, isTrue);
    expect(ci.onlyInSkills, isFalse);

    final firebase = sections.presenceOf(keywordTerms('Firebase'));
    expect(firebase.inSkills, isTrue);
    expect(firebase.onlyInSkills, isTrue);

    final rest = sections.presenceOf(keywordTerms('REST API'));
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
    final jobs = marketJobs([
      job('Flutter Developer', ['Experiencia con RESTful APIs', 'Bloc']),
      job('Mobile Engineer', ['REST', 'CI/CD']),
      job('Backend', ['GraphQL']),
      job('Descartada', ['REST'], off: true),
      job('Sin texto', []),
    ]);
    expect(jobs, hasLength(3));
    expect(offersMentioning(jobs, keywordTerms('REST API')), 2);
    expect(offersMentioning(jobs, keywordTerms('Bloc')), 1);
    expect(offersMentioning(jobs, keywordTerms('Kotlin')), 0);
  });
}
