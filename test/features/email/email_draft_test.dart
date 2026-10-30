import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/in_memory_applications_repository.dart';
import 'package:rumbo/features/applications/presentation/screens/application_detail_screen.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/email/domain/entities/email_draft.dart';
import 'package:rumbo/features/email/domain/repositories/email_drafter.dart';
import 'package:rumbo/features/email/domain/services/mailto.dart';
import 'package:rumbo/features/email/infrastructure/di/email_providers.dart';
import 'package:rumbo/features/email/infrastructure/services/mail_services.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

class _FakeDrafter implements EmailDrafter {
  final List<EmailDraftKind> kinds = <EmailDraftKind>[];

  @override
  Future<Result<EmailDraft>> draft({
    required String applicationId,
    required EmailDraftKind kind,
    String notes = '',
  }) async {
    kinds.add(kind);
    return Ok<EmailDraft>(
      EmailDraft(
        subject: 'Seguimiento: Flutter Developer',
        body: 'Hola Ana,\n\nQuería saber cómo va el proceso.\n\nJuan',
        to: kinds.length == 1 ? 'ana@fintech.com' : 'otra@fintech.com',
      ),
    );
  }

  @override
  Future<Result<EmailDraft>> draftApplication(
    String jobId, {
    String notes = '',
  }) => throw UnimplementedError();
}

void main() {
  test('cada estado ofrece los correos que tienen sentido', () {
    expect(emailKindsFor(ApplicationStatus.saved), isEmpty);
    expect(emailKindsFor(ApplicationStatus.applied), <EmailDraftKind>[
      EmailDraftKind.followUp,
    ]);
    expect(emailKindsFor(ApplicationStatus.interview), <EmailDraftKind>[
      EmailDraftKind.followUp,
      EmailDraftKind.thankYou,
    ]);
    expect(emailKindsFor(ApplicationStatus.offer), <EmailDraftKind>[
      EmailDraftKind.thankYou,
    ]);
    expect(emailKindsFor(ApplicationStatus.rejected), <EmailDraftKind>[
      EmailDraftKind.rejectionReply,
    ]);
  });

  test('el enlace mailto codifica asunto y cuerpo sin «+»', () {
    final Uri uri = mailtoUri(
      to: 'ana@acme.com',
      subject: 'Hola equipo',
      body: 'Línea 1\nLínea 2',
    );
    expect(
      uri.toString(),
      startsWith('mailto:ana@acme.com?subject=Hola%20equipo'),
    );
    expect(
      uri.toString(),
      contains('body=L%C3%ADnea%201%0ALínea'.replaceAll('Línea', 'L%C3%ADnea')),
    );
  });

  testWidgets('redacta un seguimiento, se copia y se abre en el correo', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    await jobs.save(
      const SavedJob(
        job: Job(title: 'Flutter Developer', company: 'Fintech'),
      ),
    );
    final String jobId = (await jobs.list()).getOrThrow().single.job.id;
    final InMemoryApplicationsRepository applications =
        InMemoryApplicationsRepository(jobs);
    await applications.save(
      Application(
        jobId: jobId,
        status: ApplicationStatus.applied,
        appliedAt: DateTime(2026, 10, 10),
      ),
    );
    final _FakeDrafter drafter = _FakeDrafter();
    String? copied;
    Uri? opened;

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          applicationsRepositoryProvider.overrideWithValue(applications),
          emailDrafterProvider.overrideWithValue(drafter),
          clipboardWriterProvider.overrideWithValue((String text) async {
            copied = text;
          }),
          mailLauncherProvider.overrideWithValue((Uri uri) async {
            opened = uri;
            return true;
          }),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Procesos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Flutter Developer'));
    await tester.pumpAndSettle();

    final Finder follow = find.byKey(const Key('email-followUp'));
    await tester.scrollUntilVisible(
      follow,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const Key('email-thankYou')), findsNothing);
    await tester.tap(follow);
    await tester.pumpAndSettle();

    expect(drafter.kinds, <EmailDraftKind>[EmailDraftKind.followUp]);
    expect(find.text('ana@fintech.com'), findsOneWidget);
    expect(find.text('Seguimiento: Flutter Developer'), findsOneWidget);

    // El destinatario que se escribe a mano no se pierde al regenerar.
    await tester.enterText(
      find.byKey(const Key('emailTo')),
      'rrhh@fintech.com',
    );
    await tester.tap(find.byKey(const Key('regenerateEmail')));
    await tester.pumpAndSettle();
    expect(drafter.kinds, hasLength(2));
    expect(find.text('rrhh@fintech.com'), findsOneWidget);

    await tester.tap(find.byKey(const Key('copyEmail')));
    await tester.pumpAndSettle();
    expect(copied, startsWith('Seguimiento: Flutter Developer\n\nHola Ana'));
    expect(find.text('Correo copiado. Pégalo en tu correo.'), findsOneWidget);

    // Que se vaya el aviso flotante antes de pulsar el otro botón.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openEmail')));
    await tester.pumpAndSettle();
    expect(opened?.scheme, 'mailto');
    expect(opened?.path, 'rrhh@fintech.com');
  });
}
