import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/applications/domain/application.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/stats/domain/search_stats.dart';

ApplicationWithJob _app(
  String id,
  ApplicationStatus status, {
  String source = 'link',
  DateTime? appliedAt,
}) => ApplicationWithJob(
  application: Application(
    id: id,
    jobId: 'job-$id',
    status: status,
    appliedAt: appliedAt,
  ),
  job: Job(id: 'job-$id', title: 'Dev $id', company: 'C$id', source: source),
);

ApplicationEvent _event(ApplicationStatus to, DateTime at) =>
    ApplicationEvent(id: '$to$at', toStatus: to, createdAt: at);

SavedJob _job(List<String> missing, {bool dismissed = false}) => SavedJob(
  job: Job(title: 'x', company: 'y', dismissed: dismissed),
  match: JobMatch(score: 50, missing: missing),
);

void main() {
  final day1 = DateTime(2026, 10, 1);

  test('el embudo cuenta etapas alcanzadas aunque luego rechacen', () {
    final stats = computeStats(
      applications: [
        _app('a', ApplicationStatus.saved),
        _app('b', ApplicationStatus.preparing),
        _app('c', ApplicationStatus.applied, appliedAt: day1),
        _app('d', ApplicationStatus.rejected, appliedAt: day1),
        _app(
          'e',
          ApplicationStatus.offer,
          appliedAt: day1,
          source: 'getonboard',
        ),
      ],
      events: {
        'd': [
          _event(ApplicationStatus.applied, day1),
          _event(
            ApplicationStatus.interview,
            day1.add(const Duration(days: 4)),
          ),
          _event(ApplicationStatus.rejected, day1.add(const Duration(days: 9))),
        ],
        'e': [
          _event(ApplicationStatus.applied, day1),
          _event(ApplicationStatus.inReview, day1.add(const Duration(days: 2))),
          _event(ApplicationStatus.offer, day1.add(const Duration(days: 20))),
        ],
      },
      jobs: const [],
    );
    final funnel = stats.funnel;
    expect(funnel.saved, 5);
    expect(funnel.applied, 3);
    expect(funnel.responded, 2);
    expect(funnel.interviews, 2);
    expect(funnel.offers, 1);
    expect(funnel.responseRate, 67);
    // Primera respuesta: 4 y 2 días → media 3.
    expect(stats.averageResponseDays, 3);
    expect(stats.bySource.first.source, 'manual');
    expect(stats.bySource.first.applied, 2);
    expect(
      stats.bySource.firstWhere((s) => s.source == 'getonboard').responded,
      1,
    );
  });

  test('sin postulaciones no hay tasas ni tiempos', () {
    final stats = computeStats(
      applications: [_app('a', ApplicationStatus.saved)],
      events: const {},
      jobs: const [],
    );
    expect(stats.funnel.responseRate, isNull);
    expect(stats.averageResponseDays, isNull);
    expect(stats.bySource, isEmpty);
  });

  test('las brechas agrupan variantes y cuentan una vez por oferta', () {
    final stats = computeStats(
      applications: const [],
      events: const {},
      jobs: [
        _job(['Kotlin', 'Inglés avanzado', 'kotlin.']),
        _job(['Kotlin: apps nativas', 'Swift']),
        _job(['Inglés avanzado (B2)', 'Firebase']),
        _job(['Kotlin'], dismissed: true),
      ],
    );
    expect(stats.analyzedJobs, 3);
    expect(stats.gaps.map((g) => (g.label, g.count)), [
      ('Kotlin', 2),
      ('Inglés avanzado', 2),
    ]);
  });
}
