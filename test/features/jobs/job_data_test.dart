import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/jobs/data/job_analyzer.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';

void main() {
  const job = Job(
    title: 'Flutter Developer',
    company: ' Acme ',
    location: 'Remoto LATAM',
    workMode: WorkMode.remote,
    salaryMin: 4000,
    salaryMax: 5500,
    salaryCurrency: 'USD',
  );

  test('la clave de duplicados ignora mayúsculas y espacios', () {
    expect(job.dedupeKey, 'acme|flutter developer|remoto latam');
    expect(
      job.copyWith(company: 'ACME', title: 'flutter developer ').dedupeKey,
      job.dedupeKey,
    );
  });

  test('la fila nueva no envía id ni fecha y lleva la clave', () {
    final row = jobToRow(job);
    expect(row.containsKey('id'), isFalse);
    expect(row.containsKey('created_at'), isFalse);
    expect(row['dedupe_hash'], 'acme|flutter developer|remoto latam');
    expect(row['work_mode'], 'remote');
    expect(row['salary_currency'], 'USD');
  });

  test('lee la oferta con su compatibilidad como objeto o como lista', () {
    final row = {
      'id': 'job-1',
      'user_id': 'user-1',
      'source': 'link',
      'url': 'https://boards.greenhouse.io/acme/jobs/1',
      'dedupe_hash': 'x',
      'title': 'Flutter Developer',
      'company': 'Acme',
      'location': '',
      'work_mode': 'onsite',
      'description': 'Texto',
      'requirements': ['Dart'],
      'salary_min': 4000,
      'salary_max': null,
      'salary_currency': null,
      'published_at': null,
      'created_at': '2026-10-14T20:00:00+00:00',
    };
    final match = {
      'job_id': 'job-1',
      'user_id': 'user-1',
      'score': 82,
      'met': ['Dart'],
      'missing': [],
      'explanation': 'Buen encaje.',
      'model': 'gemini-3.8-flash',
      'prompt_version': 'analyze-job/v1',
      'created_at': '2026-10-14T20:00:00+00:00',
    };

    final asObject = savedJobFromRow({...row, 'job_matches': match});
    expect(asObject.job.workMode, WorkMode.onsite);
    expect(asObject.job.salaryMin, 4000);
    expect(asObject.match!.score, 82);
    expect(asObject.match!.promptVersion, 'analyze-job/v1');

    final asList = savedJobFromRow({
      ...row,
      'job_matches': [match],
    });
    expect(asList.match!.score, 82);

    final withoutMatch = savedJobFromRow({...row, 'job_matches': null});
    expect(withoutMatch.match, isNull);
  });

  test('convierte la respuesta de analyze-job', () {
    final result = jobAnalysisFromJson({
      'job': {
        'title': 'Mobile Engineer',
        'company': 'Beta',
        'location': 'Bogotá',
        'work_mode': null,
        'requirements': ['Flutter', 'Kotlin'],
        'salary_min': null,
        'salary_max': null,
        'salary_currency': null,
        'url': null,
        'description': 'Buscamos…',
      },
      'match': {
        'score': 61,
        'met': ['Flutter'],
        'missing': ['Kotlin'],
        'explanation': 'Te falta Kotlin.',
        'model': 'gemini-3.8-flash',
        'prompt_version': 'analyze-job/v1',
      },
    });
    expect(result.job.source, 'manual');
    expect(result.job.workMode, isNull);
    expect(result.match!.missing, ['Kotlin']);
  });

  test('los niveles de compatibilidad', () {
    expect(matchLevel(90), MatchLevel.high);
    expect(matchLevel(75), MatchLevel.high);
    expect(matchLevel(60), MatchLevel.medium);
    expect(matchLevel(49), MatchLevel.low);
  });

  test('el repositorio en memoria rechaza duplicados', () async {
    final repository = InMemoryJobsRepository();
    await repository.save(const SavedJob(job: job));
    expect(
      () => repository.save(SavedJob(job: job.copyWith(company: 'ACME'))),
      throwsA(isA<JobAlreadySavedException>()),
    );
    final saved = await repository.list();
    expect(saved.single.job.id, isNotEmpty);
    await repository.delete(saved.single.job.id);
    expect(await repository.list(), isEmpty);
  });
}
