import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/config/env.dart';
import '../../jobs/data/jobs_repository.dart';
import '../../jobs/domain/job.dart';
import '../domain/application.dart';
import '../domain/application_status.dart';

part 'applications_repository.g.dart';

abstract interface class ApplicationsRepository {
  Future<List<ApplicationWithJob>> list();

  /// Crea el proceso si su id está vacío; si no, lo actualiza.
  Future<Application> save(Application application);

  Future<void> delete(String id);

  /// Historial de estados, del más antiguo al más reciente.
  Future<List<ApplicationEvent>> events(String applicationId);

  /// Historial de todos los procesos, agrupado por proceso.
  Future<Map<String, List<ApplicationEvent>>> allEvents();
}

class SupabaseApplicationsRepository implements ApplicationsRepository {
  SupabaseApplicationsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<ApplicationWithJob>> list() async {
    final rows = await _client
        .from('applications')
        .select('*, jobs(*)')
        .order('updated_at', ascending: false);
    return [
      for (final row in rows)
        if (row['jobs'] is Map<String, dynamic>)
          ApplicationWithJob(
            application: applicationFromRow(row),
            job: Job.fromJson(row['jobs'] as Map<String, dynamic>),
          ),
    ];
  }

  @override
  Future<Application> save(Application application) async {
    final row = applicationToRow(application);
    final saved = application.id.isEmpty
        ? await _client.from('applications').insert(row).select().single()
        : await _client
              .from('applications')
              .update(row)
              .eq('id', application.id)
              .select()
              .single();
    return applicationFromRow(saved);
  }

  @override
  Future<void> delete(String id) =>
      _client.from('applications').delete().eq('id', id);

  @override
  Future<List<ApplicationEvent>> events(String applicationId) async {
    final rows = await _client
        .from('application_events')
        .select()
        .eq('application_id', applicationId)
        .order('created_at', ascending: true);
    return rows.map(eventFromRow).toList();
  }

  @override
  Future<Map<String, List<ApplicationEvent>>> allEvents() async {
    final rows = await _client
        .from('application_events')
        .select()
        .order('created_at', ascending: true);
    final grouped = <String, List<ApplicationEvent>>{};
    for (final row in rows) {
      (grouped[row['application_id'] as String] ??= []).add(eventFromRow(row));
    }
    return grouped;
  }
}

/// Procesos en memoria (modo local y tests), con su historial.
class InMemoryApplicationsRepository implements ApplicationsRepository {
  InMemoryApplicationsRepository(this._jobs, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  static const _uuid = Uuid();

  final JobsRepository _jobs;
  final DateTime Function() _clock;
  final _items = <Application>[];
  final _events = <String, List<ApplicationEvent>>{};

  @override
  Future<List<ApplicationWithJob>> list() async {
    final jobs = await _jobs.list();
    return [
      for (final application in _items)
        if (jobs.firstWhereOrNull((s) => s.job.id == application.jobId)
            case final saved?)
          ApplicationWithJob(application: application, job: saved.job),
    ];
  }

  @override
  Future<Application> save(Application application) async {
    final now = _clock();
    final previous = _items.firstWhereOrNull((a) => a.id == application.id);
    final saved = application.copyWith(
      id: application.id.isEmpty ? _uuid.v4() : application.id,
      createdAt: application.createdAt ?? now,
      updatedAt: now,
    );
    _items
      ..removeWhere((a) => a.id == saved.id)
      ..insert(0, saved);
    // Igual que el trigger de la base de datos.
    if (previous?.status != saved.status) {
      (_events[saved.id] ??= []).add(
        ApplicationEvent(
          id: _uuid.v4(),
          fromStatus: previous?.status,
          toStatus: saved.status,
          createdAt: now,
        ),
      );
    }
    return saved;
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((a) => a.id == id);
    _events.remove(id);
  }

  @override
  Future<List<ApplicationEvent>> events(String applicationId) async => [
    ...?_events[applicationId],
  ];

  @override
  Future<Map<String, List<ApplicationEvent>>> allEvents() async => {
    for (final entry in _events.entries) entry.key: [...entry.value],
  };
}

Map<String, dynamic> applicationToRow(Application application) => {
  'job_id': application.jobId,
  'resume_version_id': application.resumeVersionId,
  'status': application.status.dbValue,
  'cover_letter': application.coverLetter,
  'notes': application.notes,
  'applied_at': application.appliedAt?.toUtc().toIso8601String(),
  'next_follow_up_at': application.nextFollowUpAt?.toUtc().toIso8601String(),
};

DateTime? _date(Object? value) =>
    value is String ? DateTime.parse(value).toLocal() : null;

Application applicationFromRow(Map<String, dynamic> row) => Application(
  id: row['id'] as String,
  jobId: row['job_id'] as String,
  resumeVersionId: row['resume_version_id'] as String?,
  status: ApplicationStatus.fromDb(row['status'] as String),
  coverLetter: row['cover_letter'] as String?,
  notes: row['notes'] as String? ?? '',
  appliedAt: _date(row['applied_at']),
  nextFollowUpAt: _date(row['next_follow_up_at']),
  createdAt: _date(row['created_at']),
  updatedAt: _date(row['updated_at']),
);

ApplicationEvent eventFromRow(Map<String, dynamic> row) => ApplicationEvent(
  id: row['id'] as String,
  fromStatus: row['from_status'] == null
      ? null
      : ApplicationStatus.fromDb(row['from_status'] as String),
  toStatus: ApplicationStatus.fromDb(row['to_status'] as String),
  origin: EventOrigin.values.byName(row['origin'] as String? ?? 'manual'),
  note: row['note'] as String?,
  createdAt: _date(row['created_at'])!,
);

@Riverpod(keepAlive: true)
ApplicationsRepository applicationsRepository(Ref ref) {
  if (!Env.hasBackend) {
    return InMemoryApplicationsRepository(ref.watch(jobsRepositoryProvider));
  }
  return SupabaseApplicationsRepository(Supabase.instance.client);
}
