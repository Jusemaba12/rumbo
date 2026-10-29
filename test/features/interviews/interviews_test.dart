import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/core/time/clock.dart';
import 'package:rumbo/features/applications/data/applications_repository.dart';
import 'package:rumbo/features/applications/domain/application.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/interviews/data/interviews_repository.dart';
import 'package:rumbo/features/interviews/domain/interview.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';

void main() {
  group('statusForInterview', () {
    test('una entrevista avanza el proceso postulado', () {
      expect(
        statusForInterview(ApplicationStatus.applied, InterviewKind.screening),
        ApplicationStatus.interview,
      );
      expect(
        statusForInterview(ApplicationStatus.inReview, InterviewKind.technical),
        ApplicationStatus.technicalTest,
      );
    });

    test('no hace retroceder ni salta etapas imposibles', () {
      expect(
        statusForInterview(
          ApplicationStatus.interview,
          InterviewKind.technical,
        ),
        isNull,
      );
      expect(
        statusForInterview(ApplicationStatus.saved, InterviewKind.screening),
        isNull,
      );
      expect(
        statusForInterview(ApplicationStatus.offer, InterviewKind.final_),
        isNull,
      );
    });
  });

  test('convierte filas y respeta «final»', () {
    final interview = Interview(
      id: 'i1',
      applicationId: 'a1',
      kind: InterviewKind.final_,
      scheduledAt: DateTime.utc(2026, 10, 20, 15),
      outcome: InterviewOutcome.passed,
    );
    final row = interviewToRow(interview);
    expect(row['kind'], 'final');
    expect(row['scheduled_at'], '2026-10-20T15:00:00.000Z');
    final back = interviewFromRow({...row, 'id': 'i1'});
    expect(back.kind, InterviewKind.final_);
    expect(back.outcome, InterviewOutcome.passed);
    expect(back.scheduledAt.toUtc(), DateTime.utc(2026, 10, 20, 15));
  });

  testWidgets('programar una entrevista avanza el estado y sale en Inicio', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    final now = DateTime(2026, 10, 15, 9);
    final jobs = InMemoryJobsRepository();
    await jobs.save(
      const SavedJob(
        job: Job(title: 'Flutter Developer', company: 'Fintech'),
      ),
    );
    final jobId = (await jobs.list()).single.job.id;
    final applications = InMemoryApplicationsRepository(jobs, clock: () => now);
    final process = await applications.save(
      Application(
        jobId: jobId,
        status: ApplicationStatus.applied,
        appliedAt: now,
      ),
    );
    final interviews = InMemoryInterviewsRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          applicationsRepositoryProvider.overrideWithValue(applications),
          interviewsRepositoryProvider.overrideWithValue(interviews),
          clockProvider.overrideWithValue(() => now),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('No tienes entrevistas próximas.'), findsOneWidget);

    await tester.tap(find.text('Procesos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Flutter Developer'));
    await tester.pumpAndSettle();
    expect(find.text('Sin entrevistas programadas.'), findsOneWidget);

    await tester.tap(find.byKey(const Key('addInterview')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('interviewLocation')),
      'https://meet.google.com/abc-defg-hij',
    );
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    expect(
      find.text('Entrevista guardada. El proceso pasó a «Entrevista».'),
      findsOneWidget,
    );
    final saved = (await interviews.list()).single;
    expect(saved.applicationId, process.id);
    // Por defecto: mañana a las 10:00.
    expect(saved.scheduledAt, DateTime(2026, 10, 16, 10));
    expect(
      (await applications.list()).single.application.status,
      ApplicationStatus.interview,
    );
    expect(find.text('Primera llamada'), findsOneWidget);

    await tester.tap(find.text('Inicio'));
    await tester.pumpAndSettle();
    expect(find.text('Flutter Developer · Fintech'), findsOneWidget);
    expect(find.byIcon(Icons.videocam_outlined), findsOneWidget);
  });
}
