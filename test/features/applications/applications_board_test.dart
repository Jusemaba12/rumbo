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
  test('convierte las filas de Supabase de procesos e historial', () {
    final application = applicationFromRow({
      'id': 'app-1',
      'job_id': 'job-1',
      'resume_version_id': null,
      'status': 'technical_test',
      'cover_letter': null,
      'notes': 'Hablar con Ana',
      'applied_at': '2026-10-01T15:00:00+00:00',
      'next_follow_up_at': null,
      'created_at': '2026-10-01T15:00:00+00:00',
      'updated_at': '2026-10-02T15:00:00+00:00',
    });
    expect(application.status, ApplicationStatus.technicalTest);
    expect(application.appliedAt!.isUtc, isFalse);
    final row = applicationToRow(application);
    expect(row['status'], 'technical_test');
    expect(row['applied_at'], '2026-10-01T15:00:00.000Z');

    final event = eventFromRow({
      'id': 'ev-1',
      'from_status': 'applied',
      'to_status': 'in_review',
      'origin': 'manual',
      'note': null,
      'created_at': '2026-10-03T10:00:00+00:00',
    });
    expect(event.fromStatus, ApplicationStatus.applied);
    expect(event.toStatus, ApplicationStatus.inReview);
  });

  testWidgets('sigue una oferta, avanza su estado y avisa del seguimiento', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    var now = DateTime(2026, 10, 15, 9);
    final jobs = InMemoryJobsRepository();
    await jobs.save(
      const SavedJob(
        job: Job(title: 'Senior Flutter Developer', company: 'Fintech'),
      ),
    );
    final applications = InMemoryApplicationsRepository(jobs, clock: () => now);

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

    // Seguir la oferta desde su detalle.
    await tester.tap(find.text('Ofertas').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Senior Flutter Developer'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('trackJob')));
    await tester.pumpAndSettle();
    expect(find.text('Guardada'), findsOneWidget);

    // Ir al proceso y marcar que ya se postuló.
    await tester.tap(find.text('Ver proceso'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('status-preparing')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('status-applied')));
    await tester.pumpAndSettle();
    expect(find.text('Postulada'), findsWidgets);
    expect(find.text('Seguimiento: 22 oct 2026'), findsOneWidget);
    // El historial queda al final de la pantalla.
    await tester.scrollUntilVisible(
      find.text('Guardada → Preparando'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Guardada → Preparando'), findsOneWidget);
    expect(find.text('Preparando → Postulada'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('notes')), 'Recruiter: Ana');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Notas guardadas.'), findsOneWidget);
    expect(
      (await applications.list()).single.application.notes,
      'Recruiter: Ana',
    );

    // Ocho días después toca hacer seguimiento.
    now = now.add(const Duration(days: 8));
    await tester.tap(find.byKey(const Key('followUpDone')));
    await tester.pumpAndSettle();
    final saved = (await applications.list()).single.application;
    expect(saved.nextFollowUpAt, DateTime(2026, 10, 30, 9));
    expect(saved.status, ApplicationStatus.applied);
  });

  testWidgets('el tablero agrupa por estado y separa los cerrados', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    final now = DateTime(2026, 10, 15, 9);
    final jobs = InMemoryJobsRepository();
    for (final title in ['App A', 'App B', 'App C']) {
      await jobs.save(
        SavedJob(
          job: Job(title: title, company: 'Empresa $title'),
        ),
      );
    }
    final ids = {for (final s in await jobs.list()) s.job.title: s.job.id};
    final applications = InMemoryApplicationsRepository(jobs, clock: () => now);
    final a = await applications.save(
      ApplicationRow.applied(
        ids['App A']!,
        now.subtract(const Duration(days: 9)),
      ),
    );
    expect(a.status, ApplicationStatus.applied);
    await applications.save(
      ApplicationRow.withStatus(ids['App B']!, ApplicationStatus.interview),
    );
    await applications.save(
      ApplicationRow.withStatus(ids['App C']!, ApplicationStatus.rejected),
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

    // Inicio propone el seguimiento vencido en «Para hoy».
    expect(find.text('Para hoy'), findsOneWidget);
    expect(find.text('Seguimiento a Empresa App A'), findsOneWidget);

    await tester.tap(find.text('Procesos'));
    await tester.pumpAndSettle();
    expect(find.text('Activos (2)'), findsOneWidget);
    // El seguimiento vencido va arriba y no se repite en su grupo.
    expect(find.text('Necesita acción · 1'), findsOneWidget);
    expect(find.text('Toca hacer seguimiento'), findsOneWidget);
    expect(find.text('Entrevista · 1'), findsOneWidget);
    expect(find.text('Postulada · 1'), findsNothing);
    expect(find.text('App C'), findsNothing);

    await tester.tap(find.text('Cerrados (1)'));
    await tester.pumpAndSettle();
    expect(find.text('App C'), findsOneWidget);
    expect(find.text('App A'), findsNothing);
  });
}

/// Atajos para crear procesos en los tests.
abstract final class ApplicationRow {
  static Application applied(String jobId, DateTime at) => Application(
    jobId: jobId,
    status: ApplicationStatus.applied,
    appliedAt: at,
    nextFollowUpAt: at.add(const Duration(days: 7)),
  );

  static Application withStatus(String jobId, ApplicationStatus status) =>
      Application(jobId: jobId, status: status);
}
