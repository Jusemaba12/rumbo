import 'dart:math';

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
import 'package:rumbo/features/email/domain/entities/email_update.dart';
import 'package:rumbo/features/email/domain/services/gmail_script.dart';
import 'package:rumbo/features/email/domain/services/sync_key.dart';
import 'package:rumbo/features/email/infrastructure/di/email_providers.dart';
import 'package:rumbo/features/email/infrastructure/mappers/email_update_mapper.dart';
import 'package:rumbo/features/email/infrastructure/repositories/in_memory_email_repository.dart';
import 'package:rumbo/features/email/infrastructure/services/mail_services.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/infrastructure/di/interviews_providers.dart';
import 'package:rumbo/features/interviews/infrastructure/repositories/in_memory_interviews_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/shared/application/services/clock.dart';

void main() {
  test('la clave tiene 64 caracteres hex y se guarda como SHA-256', () {
    final String key = generateSyncKey(Random(1));
    expect(key, matches(RegExp(r'^[0-9a-f]{64}$')));
    expect(generateSyncKey(Random(2)), isNot(key));
    expect(
      hashSyncKey('abc'),
      'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad',
    );
  });

  test('el script lleva la URL y la clave y se instala cada hora', () {
    final String script = buildGmailScript(
      functionUrl: 'https://x.supabase.co/functions/v1/email-sync',
      key: 'k123',
    );
    expect(
      script,
      contains(
        "const RUMBO_URL = 'https://x.supabase.co/functions/v1/email-sync';",
      ),
    );
    expect(script, contains("const RUMBO_KEY = 'k123';"));
    expect(script, contains('everyHours(1)'));
    expect(script, contains("-label:' + ETIQUETA"));
    // v2: también envía las alertas de empleo de LinkedIn.
    expect(script, contains("action: 'linkedin_alerts'"));
    expect(script, contains('jobalerts-noreply@linkedin.com'));
  });

  test('convierte las filas de propuestas', () {
    final EmailUpdate update = emailUpdateFromRow(<String, dynamic>{
      'id': 'u1',
      'application_id': 'a1',
      'sender': 'Ana <ana@forest.cl>',
      'subject': 'Entrevista',
      'summary': 'Te invitan el jueves a las 10.',
      'suggested_status': 'technical_test',
      'interview_at': '2026-10-23T15:00:00+00:00',
      'received_at': null,
    });
    expect(update.suggestedStatus, ApplicationStatus.technicalTest);
    expect(update.interviewAt!.toUtc(), DateTime.utc(2026, 10, 23, 15));
    expect(update.receivedAt, isNull);
  });

  Future<(InMemoryApplicationsRepository, InMemoryInterviewsRepository, String)>
  pumpHome(WidgetTester tester, InMemoryEmailRepository email) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final DateTime now = DateTime(2026, 10, 18, 9);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    await jobs.save(
      const SavedJob(
        job: Job(title: 'Flutter Developer', company: 'Forest'),
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
    email.pending
      ..clear()
      ..addAll(<EmailUpdate>[
        EmailUpdate(
          id: 'u1',
          applicationId: process.id,
          subject: 'Siguiente paso',
          summary: 'Te invitan a una entrevista el jueves a las 10.',
          suggestedStatus: ApplicationStatus.interview,
          interviewAt: DateTime(2026, 10, 23, 10),
        ),
        EmailUpdate(
          id: 'u2',
          applicationId: process.id,
          subject: 'Boletín',
          summary: 'Novedades de la empresa.',
          suggestedStatus: ApplicationStatus.inReview,
        ),
      ]);
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          applicationsRepositoryProvider.overrideWithValue(applications),
          interviewsRepositoryProvider.overrideWithValue(interviews),
          emailRepositoryProvider.overrideWithValue(email),
          clockProvider.overrideWithValue(() => now),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    return (applications, interviews, process.id);
  }

  testWidgets(
    'aplicar una propuesta programa la entrevista y cambia el estado',
    (WidgetTester tester) async {
      final InMemoryEmailRepository email = InMemoryEmailRepository();
      final (
        InMemoryApplicationsRepository applications,
        InMemoryInterviewsRepository interviews,
        String processId,
      ) = await pumpHome(
        tester,
        email,
      );

      expect(find.text('Novedades del correo'), findsOneWidget);
      expect(
        find.text('Te invitan a una entrevista el jueves a las 10.'),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key('dismiss-u2')));
      await tester.pumpAndSettle();
      expect(email.resolved['u2'], isFalse);
      expect(find.text('Novedades de la empresa.'), findsNothing);

      await tester.tap(find.byKey(const Key('apply-u1')));
      await tester.pumpAndSettle();
      expect(email.resolved['u1'], isTrue);
      expect(find.text('Novedades del correo'), findsNothing);

      final Interview interview = (await interviews.list()).getOrThrow().single;
      expect(interview.applicationId, processId);
      expect(interview.kind, InterviewKind.screening);
      expect(interview.scheduledAt, DateTime(2026, 10, 23, 10));
      expect(
        (await applications.list()).getOrThrow().single.application.status,
        ApplicationStatus.interview,
      );
      // Sale en próximas entrevistas.
      expect(find.text('Flutter Developer · Forest'), findsWidgets);
    },
  );

  testWidgets('Conectar Gmail copia el script con una clave nueva', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    // Clave del script v1, anterior a las alertas de LinkedIn.
    final InMemoryEmailRepository email = InMemoryEmailRepository()
      ..connection = EmailSyncStatus(
        createdAt: DateTime.utc(2026, 10, 15),
        lastUsedAt: DateTime.utc(2026, 10, 19),
      );
    String? copied;
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          emailRepositoryProvider.overrideWithValue(email),
          clipboardWriterProvider.overrideWithValue(
            (String text) async => copied = text,
          ),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Conectar Gmail'));
    await tester.pumpAndSettle();
    expect(find.text('Alertas de empleo de LinkedIn'), findsOneWidget);
    expect(find.byKey(const Key('updateGmailScript')), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byKey(const Key('disconnectGmail')),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('disconnectGmail')));
    await tester.pumpAndSettle();
    expect(find.text('Aún no has conectado Gmail.'), findsOneWidget);
    expect(find.byKey(const Key('updateGmailScript')), findsNothing);
    // Espera a que se vaya el aviso «Gmail desconectado».
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.byKey(const Key('copyScript')),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('copyScript')));
    await tester.pumpAndSettle();
    final RegExpMatch key = RegExp(r"RUMBO_KEY = '([0-9a-f]{64})'")
        .firstMatch(copied!)!;
    expect(hashSyncKey(key.group(1)!), email.keyHash);
    expect(
      find.text('Script copiado. Pégalo en script.google.com.'),
      findsOneWidget,
    );
    expect(find.textContaining('Esperando a que el script'), findsOneWidget);
    expect(find.text('Generar clave nueva y copiar'), findsOneWidget);
    // La clave nueva lleva el script v2: ya no se pide actualizar.
    expect(find.byKey(const Key('updateGmailScript')), findsNothing);
    // El aviso flotante de «Script copiado» tapa el botón.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.byKey(const Key('disconnectGmail')),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('disconnectGmail')));
    await tester.pumpAndSettle();
    expect(email.connection, isNull);
    expect(find.text('Aún no has conectado Gmail.'), findsOneWidget);
  });
}
