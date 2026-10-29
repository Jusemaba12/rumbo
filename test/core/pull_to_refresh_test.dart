import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/applications/data/applications_repository.dart';
import 'package:rumbo/features/applications/domain/application.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';

void main() {
  testWidgets('deslizar trae lo que cambió fuera de la app', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final jobs = InMemoryJobsRepository();
    final applications = InMemoryApplicationsRepository(jobs);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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
        jobId: (await jobs.list()).single.job.id,
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
