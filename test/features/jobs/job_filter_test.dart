import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/entities/job_filter.dart';
import 'package:rumbo/features/jobs/domain/services/shared_job.dart';

void main() {
  final DateTime now = DateTime(2026, 10, 16, 9);

  SavedJob job(
    String title, {
    WorkMode? mode,
    int? score,
    int daysAgo = 1,
    String source = 'getonboard',
    bool dismissed = false,
  }) => SavedJob(
    job: Job(
      id: title,
      title: title,
      company: 'Empresa',
      workMode: mode,
      source: source,
      createdAt: now.subtract(Duration(days: daysAgo)),
      discovered: true,
      dismissed: dismissed,
    ),
    match: score == null ? null : JobMatch(score: score),
  );

  final List<SavedJob> jobs = <SavedJob>[
    job('A', mode: WorkMode.remote, score: 80, daysAgo: 2),
    job('B', mode: WorkMode.hybrid, score: 70, daysAgo: 1),
    job('C', mode: WorkMode.remote, score: 40, daysAgo: 20, source: 'remotive'),
    job('D', mode: WorkMode.remote, daysAgo: 3),
  ];
  List<String> titles(List<SavedJob> list) =>
      list.map((SavedJob s) => s.job.title).toList();

  test('sin filtros no quita nada', () {
    expect(const JobFilter().isActive, isFalse);
    expect(titles(const JobFilter().apply(jobs: jobs, now: now)), <String>[
      'A',
      'B',
      'C',
      'D',
    ]);
  });

  test('cada filtro y su combinación', () {
    expect(
      titles(const JobFilter(remoteOnly: true).apply(jobs: jobs, now: now)),
      <String>['A', 'C', 'D'],
    );
    // Sin nota no pasa el filtro de nota mínima.
    expect(
      titles(const JobFilter(goodMatchOnly: true).apply(jobs: jobs, now: now)),
      <String>['A', 'B'],
    );
    expect(
      titles(const JobFilter(recentOnly: true).apply(jobs: jobs, now: now)),
      <String>['A', 'B', 'D'],
    );
    expect(
      titles(const JobFilter(source: 'remotive').apply(jobs: jobs, now: now)),
      <String>['C'],
    );
    expect(
      titles(
        const JobFilter(
          remoteOnly: true,
          goodMatchOnly: true,
          recentOnly: true,
        ).apply(jobs: jobs, now: now),
      ),
      <String>['A'],
    );
  });

  test('copyWith puede quitar el portal', () {
    const JobFilter filter = JobFilter(source: 'lever');
    expect(filter.copyWith(source: null).source, isNull);
    expect(filter.copyWith(remoteOnly: true).source, 'lever');
  });

  test('las descartadas de más de 30 días ya no se ofrecen', () {
    final List<SavedJob> dismissed = <SavedJob>[
      job('Nueva', dismissed: true, daysAgo: 5),
      job('Vieja', dismissed: true, daysAgo: 45),
      job('Activa'),
    ];
    expect(titles(recentlyDismissed(jobs: dismissed, now: now)), <String>[
      'Nueva',
    ]);
  });

  group('texto compartido', () {
    test('título y enlace: solo el enlace', () {
      final ({String? text, String? url}) shared = splitSharedJob(
        'Flutter Developer en Acme https://boards.greenhouse.io/acme/jobs/1',
      );
      expect(shared.url, 'https://boards.greenhouse.io/acme/jobs/1');
      expect(shared.text, isNull);
    });

    test('descripción larga con enlace: ambos', () {
      final String description = 'Buscamos Flutter Developer. ' * 10;
      final ({String? text, String? url}) shared = splitSharedJob(
        '$description https://www.getonbrd.com/jobs/1',
      );
      expect(shared.url, 'https://www.getonbrd.com/jobs/1');
      // La descripción se conserva entera, enlaces incluidos.
      expect(shared.text, '$description https://www.getonbrd.com/jobs/1');
    });

    test('el perfil de LinkedIn del reclutador no es el enlace', () {
      final String description = 'Buscamos Flutter Developer. ' * 10;
      final ({String? text, String? url}) shared = splitSharedJob(
        '$description\nReclutadora: Laura https://www.linkedin.com/in/laura/',
      );
      expect(shared.url, isNull);
      expect(shared.text, contains('https://www.linkedin.com/in/laura/'));
      expect(shared.text, contains('Reclutadora: Laura'));
    });

    test('sin enlace: todo es descripción', () {
      final ({String? text, String? url}) shared = splitSharedJob(
        '  Buscamos alguien con Flutter  ',
      );
      expect(shared.url, isNull);
      expect(shared.text, 'Buscamos alguien con Flutter');
    });

    test('vacío', () {
      final ({String? text, String? url}) shared = splitSharedJob('   ');
      expect(shared.url, isNull);
      expect(shared.text, isNull);
    });
  });
}
