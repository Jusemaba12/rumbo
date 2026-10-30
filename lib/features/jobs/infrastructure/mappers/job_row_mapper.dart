import 'package:rumbo/features/jobs/domain/entities/job.dart';

/// Fila de `jobs` para insertar una oferta nueva.
Map<String, dynamic> jobToRow(Job job) =>
    <String, dynamic>{...job.toJson(), 'dedupe_hash': job.dedupeKey}
      ..remove('created_at')
      ..removeWhere((String key, dynamic value) => key == 'id' && value == '');

/// Columnas del contacto, con los mismos nombres que [Job.toJson].
Map<String, dynamic> contactToRow(Job job) {
  final Map<String, dynamic> row = job.toJson();
  return <String, dynamic>{
    for (final String key in const <String>[
      'recruiter_name',
      'recruiter_email',
      'recruiter_linkedin',
      'apply_method',
      'apply_subject',
      'asks_salary',
    ])
      key: row[key],
  };
}

/// Columnas que reemplaza «Completar oferta».
Map<String, dynamic> completionToRow(Job job) => <String, dynamic>{
  'description': job.description,
  'requirements': job.requirements,
  'work_mode': job.toJson()['work_mode'],
  'salary_min': job.salaryMin,
  'salary_max': job.salaryMax,
  'salary_currency': job.salaryCurrency,
  ...contactToRow(job),
};

Map<String, dynamic> matchToRow(JobMatch match, {required String jobId}) =>
    <String, dynamic>{...match.toJson(), 'job_id': jobId};

SavedJob savedJobFromRow(Map<String, dynamic> row) {
  // PostgREST devuelve la relación 1 a 1 como objeto; por si acaso, admite
  // lista.
  final Object? embedded = row['job_matches'];
  final Map<String, dynamic>? matchRow = switch (embedded) {
    final Map<String, dynamic> map => map,
    [final Map<String, dynamic> first, ...] => first,
    _ => null,
  };
  return SavedJob(
    job: Job.fromJson(row),
    match: matchRow == null ? null : JobMatch.fromJson(matchRow),
  );
}

/// Convierte la respuesta de `analyze-job` en una oferta sin guardar.
SavedJob jobAnalysisFromJson(Map<String, dynamic> json) {
  final Map<String, dynamic> jobJson = json['job'] as Map<String, dynamic>;
  final Job job = Job.fromJson(jobJson);
  return SavedJob(
    job: job.copyWith(source: job.url == null ? 'manual' : 'link'),
    match: JobMatch.fromJson(json['match'] as Map<String, dynamic>),
  );
}
