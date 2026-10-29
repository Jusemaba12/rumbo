import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/config/env.dart';
import '../domain/job.dart';

part 'jobs_repository.g.dart';

/// Ya hay una oferta guardada con la misma empresa, cargo y ubicación.
class JobAlreadySavedException implements Exception {
  const JobAlreadySavedException();
}

abstract interface class JobsRepository {
  /// Ofertas guardadas, las más recientes primero.
  Future<List<SavedJob>> list();

  /// Guarda una oferta nueva con su compatibilidad.
  Future<void> save(SavedJob saved);

  Future<void> delete(String jobId);

  /// Pasa una sugerencia a ofertas guardadas.
  Future<void> keepSuggestion(String jobId);

  /// Oculta una sugerencia sin borrarla, para que no vuelva a aparecer.
  Future<void> dismissSuggestion(String jobId);

  /// Devuelve a sugerencias una oferta descartada.
  Future<void> restoreSuggestion(String jobId);

  /// Guarda el contacto del reclutador y la forma de postular.
  Future<void> updateContact(Job job);

  /// Sustituye la descripción y lo que sale de ella (requisitos, salario,
  /// modalidad) y la compatibilidad de una oferta ya guardada.
  Future<void> complete(SavedJob saved);
}

class SupabaseJobsRepository implements JobsRepository {
  SupabaseJobsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<SavedJob>> list() async {
    final rows = await _client
        .from('jobs')
        .select('*, job_matches(*)')
        .order('created_at', ascending: false);
    return rows.map(savedJobFromRow).toList();
  }

  @override
  Future<void> save(SavedJob saved) async {
    final Map<String, dynamic> inserted;
    try {
      inserted = await _client
          .from('jobs')
          .insert(jobToRow(saved.job))
          .select('id')
          .single();
    } on PostgrestException catch (error) {
      if (error.code == '23505') throw const JobAlreadySavedException();
      rethrow;
    }
    final match = saved.match;
    if (match != null) {
      await _client
          .from('job_matches')
          .insert(matchToRow(match, jobId: inserted['id'] as String));
    }
  }

  @override
  Future<void> delete(String jobId) =>
      _client.from('jobs').delete().eq('id', jobId);

  @override
  Future<void> keepSuggestion(String jobId) =>
      _client.from('jobs').update({'discovered': false}).eq('id', jobId);

  @override
  Future<void> dismissSuggestion(String jobId) =>
      _client.from('jobs').update({'dismissed': true}).eq('id', jobId);

  @override
  Future<void> restoreSuggestion(String jobId) =>
      _client.from('jobs').update({'dismissed': false}).eq('id', jobId);

  @override
  Future<void> updateContact(Job job) =>
      _client.from('jobs').update(contactToRow(job)).eq('id', job.id);

  @override
  Future<void> complete(SavedJob saved) async {
    final job = saved.job;
    await _client
        .from('jobs')
        .update({
          'description': job.description,
          'requirements': job.requirements,
          'work_mode': job.toJson()['work_mode'],
          'salary_min': job.salaryMin,
          'salary_max': job.salaryMax,
          'salary_currency': job.salaryCurrency,
          ...contactToRow(job),
        })
        .eq('id', job.id);
    final match = saved.match;
    if (match != null) {
      await _client
          .from('job_matches')
          .upsert(matchToRow(match, jobId: job.id));
    }
  }
}

/// Guarda las ofertas solo mientras la app está abierta (modo local y tests).
class InMemoryJobsRepository implements JobsRepository {
  InMemoryJobsRepository([List<SavedJob> initial = const []])
    : _items = [...initial];

  static const _uuid = Uuid();

  final List<SavedJob> _items;

  @override
  Future<List<SavedJob>> list() async => [..._items]
    ..sort(
      (a, b) => (b.job.createdAt ?? DateTime(0)).compareTo(
        a.job.createdAt ?? DateTime(0),
      ),
    );

  @override
  Future<void> save(SavedJob saved) async {
    if (_items.any((item) => item.job.dedupeKey == saved.job.dedupeKey)) {
      throw const JobAlreadySavedException();
    }
    _items.add(
      saved.copyWith(
        job: saved.job.copyWith(id: _uuid.v4(), createdAt: DateTime.now()),
      ),
    );
  }

  @override
  Future<void> delete(String jobId) async =>
      _items.removeWhere((item) => item.job.id == jobId);

  @override
  Future<void> keepSuggestion(String jobId) async =>
      _update(jobId, (job) => job.copyWith(discovered: false));

  @override
  Future<void> dismissSuggestion(String jobId) async =>
      _update(jobId, (job) => job.copyWith(dismissed: true));

  @override
  Future<void> restoreSuggestion(String jobId) async =>
      _update(jobId, (job) => job.copyWith(dismissed: false));

  @override
  Future<void> updateContact(Job job) async => _update(
    job.id,
    (current) => current.copyWith(
      recruiterName: job.recruiterName,
      recruiterEmail: job.recruiterEmail,
      recruiterLinkedin: job.recruiterLinkedin,
      applyMethod: job.applyMethod,
      applySubject: job.applySubject,
      asksSalary: job.asksSalary,
    ),
  );

  @override
  Future<void> complete(SavedJob saved) async {
    final index = _items.indexWhere((item) => item.job.id == saved.job.id);
    if (index != -1) _items[index] = saved;
  }

  void _update(String jobId, Job Function(Job job) change) {
    final index = _items.indexWhere((item) => item.job.id == jobId);
    if (index == -1) return;
    _items[index] = _items[index].copyWith(job: change(_items[index].job));
  }
}

Map<String, dynamic> jobToRow(Job job) =>
    {...job.toJson(), 'dedupe_hash': job.dedupeKey}
      ..remove('created_at')
      ..removeWhere((key, value) => key == 'id' && value == '');

/// Columnas del contacto, con los mismos nombres que [Job.toJson].
Map<String, dynamic> contactToRow(Job job) {
  final row = job.toJson();
  return {
    for (final key in const [
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

Map<String, dynamic> matchToRow(JobMatch match, {required String jobId}) => {
  ...match.toJson(),
  'job_id': jobId,
};

SavedJob savedJobFromRow(Map<String, dynamic> row) {
  // PostgREST devuelve la relación 1 a 1 como objeto; por si acaso, admite lista.
  final embedded = row['job_matches'];
  final matchRow = switch (embedded) {
    final Map<String, dynamic> map => map,
    [final Map<String, dynamic> first, ...] => first,
    _ => null,
  };
  return SavedJob(
    job: Job.fromJson(row),
    match: matchRow == null ? null : JobMatch.fromJson(matchRow),
  );
}

@Riverpod(keepAlive: true)
JobsRepository jobsRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryJobsRepository();
  return SupabaseJobsRepository(Supabase.instance.client);
}
