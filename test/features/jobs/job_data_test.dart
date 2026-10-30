import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/mappers/job_row_mapper.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

void main() {
  const Job job = Job(
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
    final Map<String, dynamic> row = jobToRow(job);
    expect(row.containsKey('id'), isFalse);
    expect(row.containsKey('created_at'), isFalse);
    expect(row['dedupe_hash'], 'acme|flutter developer|remoto latam');
    expect(row['work_mode'], 'remote');
    expect(row['salary_currency'], 'USD');
  });

  test('lee la oferta con su compatibilidad como objeto o como lista', () {
    final Map<String, Object?> row = <String, Object?>{
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
      'requirements': <String>['Dart'],
      'salary_min': 4000,
      'salary_max': null,
      'salary_currency': null,
      'published_at': null,
      'created_at': '2026-10-14T20:00:00+00:00',
    };
    final Map<String, Object> match = <String, Object>{
      'job_id': 'job-1',
      'user_id': 'user-1',
      'score': 82,
      'met': <String>['Dart'],
      'missing': <dynamic>[],
      'explanation': 'Buen encaje.',
      'model': 'gemini-3.8-flash',
      'prompt_version': 'analyze-job/v1',
      'created_at': '2026-10-14T20:00:00+00:00',
    };

    final SavedJob asObject = savedJobFromRow(<String, dynamic>{
      ...row,
      'job_matches': match,
    });
    expect(asObject.job.workMode, WorkMode.onsite);
    expect(asObject.job.salaryMin, 4000);
    expect(asObject.match!.score, 82);
    expect(asObject.match!.promptVersion, 'analyze-job/v1');

    final SavedJob asList = savedJobFromRow(<String, dynamic>{
      ...row,
      'job_matches': <Map<String, Object>>[match],
    });
    expect(asList.match!.score, 82);

    final SavedJob withoutMatch = savedJobFromRow(<String, dynamic>{
      ...row,
      'job_matches': null,
    });
    expect(withoutMatch.match, isNull);
  });

  test('convierte la respuesta de analyze-job', () {
    final SavedJob result = jobAnalysisFromJson(<String, dynamic>{
      'job': <String, Object?>{
        'title': 'Mobile Engineer',
        'company': 'Beta',
        'location': 'Bogotá',
        'work_mode': null,
        'requirements': <String>['Flutter', 'Kotlin'],
        'salary_min': null,
        'salary_max': null,
        'salary_currency': null,
        'url': null,
        'description': 'Buscamos…',
      },
      'match': <String, Object>{
        'score': 61,
        'met': <String>['Flutter'],
        'missing': <String>['Kotlin'],
        'explanation': 'Te falta Kotlin.',
        'model': 'gemini-3.8-flash',
        'prompt_version': 'analyze-job/v1',
      },
    });
    expect(result.job.source, 'manual');
    expect(result.job.workMode, isNull);
    expect(result.match!.missing, <String>['Kotlin']);
  });

  test('los niveles de compatibilidad', () {
    expect(matchLevel(90), MatchLevel.high);
    expect(matchLevel(75), MatchLevel.high);
    expect(matchLevel(60), MatchLevel.medium);
    expect(matchLevel(49), MatchLevel.low);
  });

  test('el repositorio en memoria rechaza duplicados', () async {
    final InMemoryJobsRepository repository = InMemoryJobsRepository();
    await repository.save(const SavedJob(job: job));
    expect(
      await repository.save(SavedJob(job: job.copyWith(company: 'ACME'))),
      const Err<void>(DuplicateFailure()),
    );
    final List<SavedJob> saved = (await repository.list()).getOrThrow();
    expect(saved.single.job.id, isNotEmpty);
    await repository.delete(saved.single.job.id);
    expect((await repository.list()).getOrThrow(), isEmpty);
  });
}
