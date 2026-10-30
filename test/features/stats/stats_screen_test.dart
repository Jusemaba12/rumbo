import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/in_memory_applications_repository.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/shared/application/services/clock.dart';

void main() {
  testWidgets('Inicio abre las estadísticas con embudo y brechas', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    DateTime now = DateTime(2026, 10, 1, 9);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    for (final (String title, List<String> missing) in <(String, List<String>)>[
      ('Flutter Dev', <String>['Kotlin', 'Inglés avanzado']),
      ('Mobile Eng', <String>['Kotlin']),
    ]) {
      await jobs.save(
        SavedJob(
          job: Job(title: title, company: title, source: 'getonboard'),
          match: JobMatch(score: 70, missing: missing),
        ),
      );
    }
    final List<String> ids = <String>[
      for (final SavedJob s in (await jobs.list()).getOrThrow()) s.job.id,
    ];
    final InMemoryApplicationsRepository applications =
        InMemoryApplicationsRepository(jobs, clock: () => now);
    Application a = (await applications.save(
      Application(
        jobId: ids[0],
        status: ApplicationStatus.applied,
        appliedAt: now,
      ),
    )).getOrThrow();
    await applications.save(
      Application(jobId: ids[1], status: ApplicationStatus.preparing),
    );
    now = now.add(const Duration(days: 3));
    a = (await applications.save(
      a.copyWith(status: ApplicationStatus.interview),
    )).getOrThrow();

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
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
