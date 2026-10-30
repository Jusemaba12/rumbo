import 'package:collection/collection.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:uuid/uuid.dart';

/// Procesos en memoria (modo local y tests), con su historial.
class InMemoryApplicationsRepository implements ApplicationsRepository {
  InMemoryApplicationsRepository(this._jobs, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  static const Uuid _uuid = Uuid();

  final JobsRepository _jobs;
  final DateTime Function() _clock;
  final List<Application> _items = <Application>[];
  final Map<String, List<ApplicationEvent>> _events =
      <String, List<ApplicationEvent>>{};

  @override
  Future<Result<List<ApplicationWithJob>>> list() async =>
      (await _jobs.list()).map(
        (List<SavedJob> jobs) => <ApplicationWithJob>[
          for (final Application application in _items)
            if (jobs.firstWhereOrNull(
                  (SavedJob s) => s.job.id == application.jobId,
                )
                case final SavedJob saved?)
              ApplicationWithJob(application: application, job: saved.job),
        ],
      );

  @override
  Future<Result<Application>> save(Application application) async {
    final DateTime now = _clock();
    final Application? previous = _items.firstWhereOrNull(
      (Application a) => a.id == application.id,
    );
    final Application saved = application.copyWith(
      id: application.id.isEmpty ? _uuid.v4() : application.id,
      createdAt: application.createdAt ?? now,
      updatedAt: now,
    );
    _items
      ..removeWhere((Application a) => a.id == saved.id)
      ..insert(0, saved);
    // Igual que el trigger de la base de datos.
    if (previous?.status != saved.status) {
      (_events[saved.id] ??= <ApplicationEvent>[]).add(
        ApplicationEvent(
          id: _uuid.v4(),
          fromStatus: previous?.status,
          toStatus: saved.status,
          createdAt: now,
        ),
      );
    }
    return Ok<Application>(saved);
  }

  @override
  Future<Result<void>> delete(String id) async {
    _items.removeWhere((Application a) => a.id == id);
    _events.remove(id);
    return ok;
  }

  @override
  Future<Result<List<ApplicationEvent>>> events(String applicationId) async =>
      Ok<List<ApplicationEvent>>(<ApplicationEvent>[
        ...?_events[applicationId],
      ]);

  @override
  Future<Result<Map<String, List<ApplicationEvent>>>> allEvents() async =>
      Ok<Map<String, List<ApplicationEvent>>>(<String, List<ApplicationEvent>>{
        for (final MapEntry<String, List<ApplicationEvent>> entry
            in _events.entries)
          entry.key: <ApplicationEvent>[...entry.value],
      });
}
