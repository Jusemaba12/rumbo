import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/core/time/clock.dart';
import 'package:rumbo/features/applications/data/applications_repository.dart';
import 'package:rumbo/features/applications/domain/application.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';

void main() {
  testWidgets('Inicio abre las estadísticas con embudo y brechas', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    var now = DateTime(2026, 10, 1, 9);
    final jobs = InMemoryJobsRepository();
    for (final (title, missing) in [
      ('Flutter Dev', ['Kotlin', 'Inglés avanzado']),
      ('Mobile Eng', ['Kotlin']),
    ]) {
      await jobs.save(
        SavedJob(
          job: Job(title: title, company: title, source: 'getonboard'),
          match: JobMatch(score: 70, missing: missing),
        ),
      );
    }
    final ids = [for (final s in await jobs.list()) s.job.id];
    final applications = InMemoryApplicationsRepository(jobs, clock: () => now);
    var a = await applications.save(
      Application(
        jobId: ids[0],
        status: ApplicationStatus.applied,
        appliedAt: now,
      ),
    );
    await applications.save(
      Application(jobId: ids[1], status: ApplicationStatus.preparing),
    );
    now = now.add(const Duration(days: 3));
    a = await applications.save(
      a.copyWith(status: ApplicationStatus.interview),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          applicationsRepositoryProvider.overrideWithValue(applications),
          clockProvider.overrideWithValue(() => now),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openStats')));
    await tester.pumpAndSettle();

    expect(find.text('Estadísticas'), findsOneWidget);
    expect(
      find.text('100% de tus postulaciones recibieron respuesta.'),
      findsOneWidget,
    );
    expect(
      find.text('Las empresas tardan 3 días de media en responder.'),
      findsOneWidget,
    );
    expect(find.text('Get on Board'), findsOneWidget);
    expect(find.text('1 postuladas · 1 con respuesta'), findsOneWidget);
    expect(find.text('Kotlin'), findsOneWidget);
    expect(find.text('en 2 ofertas'), findsOneWidget);
  });
}
