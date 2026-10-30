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

void main() {
  testWidgets('deslizar trae lo que cambió fuera de la app', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    final InMemoryApplicationsRepository applications =
        InMemoryApplicationsRepository(jobs);
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          applicationsRepositoryProvider.overrideWithValue(applications),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ofertas').last);
    await tester.pumpAndSettle();
    expect(find.text('Aún no hay ofertas'), findsOneWidget);

    // Otra sesión (la web, la búsqueda diaria) guarda una oferta.
    await jobs.save(
      const SavedJob(
        job: Job(title: 'Flutter Developer', company: 'Fintech'),
      ),
    );
    expect(find.text('Flutter Developer'), findsNothing);

    await tester.fling(
      find.byType(Scrollable).first,
      const Offset(0, 400),
      1000,
    );
    await tester.pumpAndSettle();
    expect(find.text('Flutter Developer'), findsOneWidget);

    // Procesos vacío también se puede deslizar.
    await tester.tap(find.text('Procesos'));
    await tester.pumpAndSettle();
    expect(find.text('Aún no tienes postulaciones'), findsOneWidget);
    await applications.save(
      Application(
        jobId: (await jobs.list()).getOrThrow().single.job.id,
        status: ApplicationStatus.applied,
      ),
    );
    await tester.fling(
      find.byType(Scrollable).first,
      const Offset(0, 400),
      1000,
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Fintech'), findsWidgets);
  });
}
