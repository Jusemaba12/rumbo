import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/applications/data/applications_repository.dart';
import 'package:rumbo/features/applications/data/resume_versions_repository.dart';
import 'package:rumbo/features/applications/domain/application_draft.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/applications/presentation/prepare_application_screen.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/email/data/email_drafter.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/jobs/presentation/apply_email_screen.dart';
import 'package:rumbo/features/profile/data/profile_repository.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

class _FakeDrafter implements EmailDrafter {
  final jobs = <String>[];

  @override
  Future<EmailDraft> draft(
    String applicationId,
    EmailDraftKind kind, {
    String notes = '',
  }) => throw UnimplementedError();

  @override
  Future<EmailDraft> draftApplication(String jobId, {String notes = ''}) async {
    jobs.add(jobId);
    return const EmailDraft(
      subject: 'Flutter Dev - Praxis 2026',
      body:
          'Buenos días, Matilde:\n\nMe postulo a la vacante. Adjunto mi hoja '
          'de vida. Mi expectativa salarial es de [tu expectativa salarial].'
          '\n\nJuan',
      to: 'talento@praxis.com',
    );
  }
}

const _job = SavedJob(
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
    expect(contactToRow(_job.job), {
      'recruiter_name': 'Matilde Durango',
      'recruiter_email': 'talento@praxis.com',
      'recruiter_linkedin': 'https://www.linkedin.com/in/matilde-durango/',
      'apply_method': 'email',
      'apply_subject': 'Flutter Dev - Praxis 2026',
      'asks_salary': true,
    });
  });

  test('completar una oferta no pisa el contacto escrito a mano', () {
    final completed = completeJob(
      _job.job,
      const Job(
        title: 'x',
        company: 'y',
        description: 'nueva',
        recruiterEmail: 'otro@praxis.com',
        recruiterName: 'Otra',
      ),
    );
    expect(completed.recruiterEmail, 'talento@praxis.com');
    expect(completed.recruiterName, 'Matilde Durango');
    final empty = completeJob(
      const Job(title: 'x', company: 'y'),
      const Job(
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
    const draft = ApplicationDraft(
      jobId: 'j1',
      language: ResumeLanguage.en,
      resume: TailoredResume(headline: 'Flutter Developer', skills: ['Dart']),
      coverLetter: 'Carta',
    );
    final back = resumeVersionFromRow(resumeVersionToRow(draft));
    expect(back.jobId, 'j1');
    expect(back.language, ResumeLanguage.en);
    expect(back.resume.skills, ['Dart']);
    expect(back.coverLetter, 'Carta');
  });

  testWidgets(
    'postula por correo con la HV adaptada y marca el proceso como postulado',
    (tester) async {
      tester.view.physicalSize = const Size(1080, 2600);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      final jobs = InMemoryJobsRepository([_job]);
      final applications = InMemoryApplicationsRepository(jobs);
      final versions = InMemoryResumeVersionsRepository();
      final drafter = _FakeDrafter();
      final sent = <Map<String, Object>>[];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
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
            resumeFontsProvider.overrideWith((ref) async => null),
            mailWithAttachmentProvider.overrideWithValue(({
              required Uint8List pdf,
              required String fileName,
              required String to,
              required String subject,
              required String body,
            }) async {
              sent.add({
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
      expect(drafter.jobs, ['j1']);
      expect(find.text('talento@praxis.com'), findsWidgets);
      expect(find.text('Flutter Dev - Praxis 2026'), findsOneWidget);

      // Hay un hueco por completar: no deja abrir el correo.
      expect(find.byKey(const Key('applyPlaceholders')), findsOneWidget);
      final open = find.byKey(const Key('openApplyEmail'));
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

      final mark = find.byKey(const Key('markApplied'));
      await tester.ensureVisible(mark);
      await tester.tap(mark);
      await tester.pumpAndSettle();
      final application = (await applications.list()).single.application;
      expect(application.status, ApplicationStatus.applied);
    },
  );

  testWidgets('edita el contacto del reclutador', (tester) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final jobs = InMemoryJobsRepository([
      const SavedJob(
        job: Job(id: 'j2', title: 'Mobile Developer', company: 'Alphas'),
      ),
    ]);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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

    final job = (await jobs.list()).single.job;
    expect(job.recruiterName, 'Georgina Brizio');
    expect(job.recruiterEmail, 'georgina@alphas.co');
    // Con correo y sin método indicado, ya se puede postular por correo.
    expect(job.appliesByEmail, isTrue);
    expect(find.text('Georgina Brizio'), findsOneWidget);
  });
}
