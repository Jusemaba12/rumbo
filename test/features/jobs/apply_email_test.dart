import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/features/applications/infrastructure/mappers/application_draft_mapper.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/in_memory_applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/in_memory_resume_versions_repository.dart';
import 'package:rumbo/features/applications/infrastructure/services/pdf_services.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/email/domain/entities/email_draft.dart';
import 'package:rumbo/features/email/domain/repositories/email_drafter.dart';
import 'package:rumbo/features/email/infrastructure/di/email_providers.dart';
import 'package:rumbo/features/email/infrastructure/services/mail_services.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/mappers/job_row_mapper.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

class _FakeDrafter implements EmailDrafter {
  final List<String> jobs = <String>[];

  @override
  Future<Result<EmailDraft>> draft({
    required String applicationId,
    required EmailDraftKind kind,
    String notes = '',
  }) => throw UnimplementedError();

  @override
  Future<Result<EmailDraft>> draftApplication(
    String jobId, {
    String notes = '',
  }) async {
    jobs.add(jobId);
    return const Ok<EmailDraft>(
      EmailDraft(
        subject: 'Flutter Dev - Praxis 2026',
        body:
            'Buenos días, Matilde:\n\nMe postulo a la vacante. Adjunto mi hoja '
            'de vida. Mi expectativa salarial es de [tu expectativa salarial].'
            '\n\nJuan',
        to: 'talento@praxis.com',
      ),
    );
  }
}

const SavedJob _job = SavedJob(
  job: Job(
    id: 'j1',
    title: 'Flutter Developer',
    company: 'Praxis',
    description: 'Envía tu CV a talento@praxis.com',
    recruiterName: 'Matilde Durango',
    recruiterEmail: 'talento@praxis.com',
    recruiterLinkedin: 'https://www.linkedin.com/in/matilde-durango/',
    applyMethod: ApplyMethod.email,
    applySubject: 'Flutter Dev - Praxis 2026',
    asksSalary: true,
  ),
);

void main() {
  test('el contacto decide si se postula por correo', () {
    expect(_job.job.appliesByEmail, isTrue);
    expect(_job.job.hasContact, isTrue);
    expect(
      _job.job.copyWith(applyMethod: ApplyMethod.portal).appliesByEmail,
      isFalse,
    );
    expect(const Job(title: 'x', company: 'y').hasContact, isFalse);
    expect(contactToRow(_job.job), <String, Object>{
      'recruiter_name': 'Matilde Durango',
      'recruiter_email': 'talento@praxis.com',
      'recruiter_linkedin': 'https://www.linkedin.com/in/matilde-durango/',
      'apply_method': 'email',
      'apply_subject': 'Flutter Dev - Praxis 2026',
      'asks_salary': true,
    });
  });

  test('completar una oferta no pisa el contacto escrito a mano', () {
    final Job completed = completeJob(
      job: _job.job,
      analyzed: const Job(
        title: 'x',
        company: 'y',
        description: 'nueva',
        recruiterEmail: 'otro@praxis.com',
        recruiterName: 'Otra',
      ),
    );
    expect(completed.recruiterEmail, 'talento@praxis.com');
    expect(completed.recruiterName, 'Matilde Durango');
    final Job empty = completeJob(
      job: const Job(title: 'x', company: 'y'),
      analyzed: const Job(
        title: 'x',
        company: 'y',
        recruiterEmail: 'otro@praxis.com',
        asksSalary: true,
      ),
    );
    expect(empty.recruiterEmail, 'otro@praxis.com');
    expect(empty.asksSalary, isTrue);
  });

  test('la HV guardada se vuelve a leer igual', () {
    const ApplicationDraft draft = ApplicationDraft(
      jobId: 'j1',
      language: ResumeLanguage.en,
      resume: TailoredResume(
        headline: 'Flutter Developer',
        skills: <String>['Dart'],
      ),
      coverLetter: 'Carta',
    );
    final ApplicationDraft back = resumeVersionFromRow(
      resumeVersionToRow(draft),
    );
    expect(back.jobId, 'j1');
    expect(back.language, ResumeLanguage.en);
    expect(back.resume.skills, <String>['Dart']);
    expect(back.coverLetter, 'Carta');
  });

  testWidgets(
    'postula por correo con la HV adaptada y marca el proceso como postulado',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2600);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      final InMemoryJobsRepository jobs = InMemoryJobsRepository(<SavedJob>[
        _job,
      ]);
      final InMemoryApplicationsRepository applications =
          InMemoryApplicationsRepository(jobs);
      final InMemoryResumeVersionsRepository versions =
          InMemoryResumeVersionsRepository();
      final _FakeDrafter drafter = _FakeDrafter();
      final List<Map<String, Object>> sent = <Map<String, Object>>[];

      await tester.pumpWidget(
        ProviderScope(
          overrides: <Override>[
            authRepositoryProvider.overrideWithValue(
              const LocalAuthRepository(),
            ),
            jobsRepositoryProvider.overrideWithValue(jobs),
            applicationsRepositoryProvider.overrideWithValue(applications),
            resumeVersionsRepositoryProvider.overrideWithValue(versions),
            profileRepositoryProvider.overrideWithValue(
              InMemoryProfileRepository(
                const ProfileData(profile: Profile(fullName: 'Juan Manzano')),
              ),
            ),
            emailDrafterProvider.overrideWithValue(drafter),
            resumeFontsProvider.overrideWith((Ref ref) async => null),
            mailWithAttachmentProvider.overrideWithValue(({
              required Uint8List pdf,
              required String fileName,
              required String to,
              required String subject,
              required String body,
            }) async {
              sent.add(<String, Object>{
                'pdf': pdf.length,
                'file': fileName,
                'to': to,
                'subject': subject,
                'body': body,
              });
            }),
          ],
          child: const RumboApp(locale: Locale('es')),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Ofertas').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Guardadas (1)'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Flutter Developer').first);
      await tester.pumpAndSettle();

      // Contacto extraído de la oferta.
      expect(find.text('Matilde Durango'), findsOneWidget);
      expect(find.text('Asunto: «Flutter Dev - Praxis 2026»'), findsOneWidget);
      expect(find.text('Piden tu expectativa salarial'), findsOneWidget);

      // Sin HV adaptada no se puede postular.
      await tester.tap(find.byKey(const Key('applyByEmail')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('needsResume')), findsOneWidget);
      expect(drafter.jobs, isEmpty);

      // Con la HV guardada, se redacta el correo.
      await versions.save(
        const ApplicationDraft(
          jobId: 'j1',
          resume: TailoredResume(headline: 'Flutter Developer'),
        ),
      );
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('applyByEmail')));
      await tester.pumpAndSettle();
      expect(drafter.jobs, <String>['j1']);
      expect(find.text('talento@praxis.com'), findsWidgets);
      expect(find.text('Flutter Dev - Praxis 2026'), findsOneWidget);

      // Hay un hueco por completar: no deja abrir el correo.
      expect(find.byKey(const Key('applyPlaceholders')), findsOneWidget);
      final Finder open = find.byKey(const Key('openApplyEmail'));
      expect(tester.widget<ButtonStyleButton>(open).onPressed, isNull);

      await tester.enterText(
        find.byKey(const Key('applyBody')),
        'Buenos días, Matilde:\n\nAdjunto mi hoja de vida. Mi expectativa '
        'salarial es de USD 2.000 mensuales.\n\nJuan',
      );
      await tester.pump();
      expect(find.byKey(const Key('applyPlaceholders')), findsNothing);
      await tester.ensureVisible(open);
      await tester.tap(open);
      await tester.pumpAndSettle();
      expect(sent, hasLength(1));
      expect(sent.single['to'], 'talento@praxis.com');
      expect(sent.single['subject'], 'Flutter Dev - Praxis 2026');
      expect(sent.single['file'], 'HV Juan Manzano - Praxis.pdf');
      expect(sent.single['pdf'] as int, greaterThan(1000));

      final Finder mark = find.byKey(const Key('markApplied'));
      await tester.ensureVisible(mark);
      await tester.tap(mark);
      await tester.pumpAndSettle();
      final Application application = (await applications.list())
          .getOrThrow()
          .single
          .application;
      expect(application.status, ApplicationStatus.applied);
    },
  );

  testWidgets('edita el contacto del reclutador', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository(<SavedJob>[
      const SavedJob(
        job: Job(id: 'j2', title: 'Mobile Developer', company: 'Alphas'),
      ),
    ]);
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ofertas').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardadas (1)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mobile Developer').first);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('addContact')));
    await tester.tap(find.byKey(const Key('addContact')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('recruiterName')),
      'Georgina Brizio',
    );
    await tester.enterText(find.byKey(const Key('recruiterEmail')), 'mal');
    await tester.ensureVisible(find.text('Guardar', skipOffstage: false));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Escribe un correo válido'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('recruiterEmail')),
      'georgina@alphas.co',
    );
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Guardar', skipOffstage: false));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    final Job job = (await jobs.list()).getOrThrow().single.job;
    expect(job.recruiterName, 'Georgina Brizio');
    expect(job.recruiterEmail, 'georgina@alphas.co');
    // Con correo y sin método indicado, ya se puede postular por correo.
    expect(job.appliesByEmail, isTrue);
    expect(find.text('Georgina Brizio'), findsOneWidget);
  });
}
