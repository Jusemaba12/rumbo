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
import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/infrastructure/di/interviews_providers.dart';
import 'package:rumbo/features/interviews/infrastructure/mappers/interview_mapper.dart';
import 'package:rumbo/features/interviews/infrastructure/repositories/in_memory_interviews_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/shared/application/services/clock.dart';

void main() {
  group('statusForInterview', () {
    test('una entrevista avanza el proceso postulado', () {
      expect(
        statusForInterview(
          current: ApplicationStatus.applied,
          kind: InterviewKind.screening,
        ),
        ApplicationStatus.interview,
      );
      expect(
        statusForInterview(
          current: ApplicationStatus.inReview,
          kind: InterviewKind.technical,
        ),
        ApplicationStatus.technicalTest,
      );
    });

    test('no hace retroceder ni salta etapas imposibles', () {
      expect(
        statusForInterview(
          current: ApplicationStatus.interview,
          kind: InterviewKind.technical,
        ),
        isNull,
      );
      expect(
        statusForInterview(
          current: ApplicationStatus.saved,
          kind: InterviewKind.screening,
        ),
        isNull,
      );
      expect(
        statusForInterview(
          current: ApplicationStatus.offer,
          kind: InterviewKind.final_,
        ),
        isNull,
      );
    });
  });

  test('convierte filas y respeta «final»', () {
    final Interview interview = Interview(
      id: 'i1',
      applicationId: 'a1',
      kind: InterviewKind.final_,
      scheduledAt: DateTime.utc(2026, 10, 20, 15),
      outcome: InterviewOutcome.passed,
    );
    final Map<String, dynamic> row = interviewToRow(interview);
    expect(row['kind'], 'final');
    expect(row['scheduled_at'], '2026-10-20T15:00:00.000Z');
    final Interview back = interviewFromRow(<String, dynamic>{
      ...row,
      'id': 'i1',
    });
    expect(back.kind, InterviewKind.final_);
    expect(back.outcome, InterviewOutcome.passed);
    expect(back.scheduledAt.toUtc(), DateTime.utc(2026, 10, 20, 15));
  });

  testWidgets('programar una entrevista avanza el estado y sale en Inicio', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    final DateTime now = DateTime(2026, 10, 15, 9);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    await jobs.save(
      const SavedJob(
        job: Job(title: 'Flutter Developer', company: 'Fintech'),
      ),
    );
    final String jobId = (await jobs.list()).getOrThrow().single.job.id;
    final InMemoryApplicationsRepository applications =
        InMemoryApplicationsRepository(jobs, clock: () => now);
    final Application process = (await applications.save(
      Application(
        jobId: jobId,
        status: ApplicationStatus.applied,
        appliedAt: now,
      ),
    )).getOrThrow();
    final InMemoryInterviewsRepository interviews =
        InMemoryInterviewsRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
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
    final Interview saved = (await interviews.list()).getOrThrow().single;
    expect(saved.applicationId, process.id);
    // Por defecto: mañana a las 10:00.
    expect(saved.scheduledAt, DateTime(2026, 10, 16, 10));
    expect(
      (await applications.list()).getOrThrow().single.application.status,
      ApplicationStatus.interview,
    );
    expect(find.text('Primera llamada'), findsOneWidget);

    await tester.tap(find.text('Inicio'));
    await tester.pumpAndSettle();
    expect(find.text('Flutter Developer · Fintech'), findsOneWidget);
    expect(find.byIcon(Icons.videocam_outlined), findsOneWidget);
  });
}
