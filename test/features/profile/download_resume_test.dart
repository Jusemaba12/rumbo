import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/applications/data/applications_repository.dart';
import 'package:rumbo/features/applications/data/resume_pdf.dart';
import 'package:rumbo/features/applications/domain/application.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/applications/presentation/prepare_application_screen.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/profile/data/profile_repository.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

final _data = ProfileData(
  profile: const Profile(
    fullName: 'Ana Pérez',
    headline: 'Flutter Developer',
    summary: 'Desarrolladora móvil.',
  ),
  experiences: [
    Experience(
      id: 'e1',
      company: 'GSE',
      role: 'Flutter Developer',
      startDate: DateTime(2024, 3),
      achievements: const ['Publiqué 3 apps en las tiendas.'],
    ),
  ],
  skills: const [
    Skill(name: 'Dart'),
    Skill(name: 'Riverpod'),
  ],
);

void main() {
  test('la HV base lleva el perfil tal cual', () {
    final draft = baseResumeDraft(_data);
    expect(draft.resume.headline, 'Flutter Developer');
    expect(draft.resume.summary, 'Desarrolladora móvil.');
    expect(draft.resume.experiences.single.company, 'GSE');
    expect(draft.resume.experiences.single.bullets, [
      'Publiqué 3 apps en las tiendas.',
    ]);
    expect(draft.resume.skills, ['Dart', 'Riverpod']);
  });

  testWidgets('descarga la HV base desde la pestaña HV', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final shared = <(int, String)>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          profileRepositoryProvider.overrideWithValue(
            InMemoryProfileRepository(_data),
          ),
          resumeFontsProvider.overrideWith((ref) async => null),
          pdfSharerProvider.overrideWithValue((bytes, name) async {
            shared.add((bytes.length, name));
          }),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('HV'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('downloadResume')));
    await tester.pumpAndSettle();
    expect(shared, hasLength(1));
    expect(shared.single.$2, 'HV Ana Pérez.pdf');
    expect(shared.single.$1, greaterThan(1000));
  });

  testWidgets('sin nombre en el perfil no hay botón de descargar', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          profileRepositoryProvider.overrideWithValue(
            InMemoryProfileRepository(),
          ),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('HV'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('downloadResume')), findsNothing);
  });

  testWidgets('las ofertas ya postuladas salen de Guardadas', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final jobs = InMemoryJobsRepository(const [
      SavedJob(
        job: Job(id: 'a', title: 'Postulada', company: 'Acme'),
      ),
      SavedJob(
        job: Job(id: 'b', title: 'Preparando', company: 'Beta'),
      ),
      SavedJob(
        job: Job(id: 'c', title: 'Sin proceso', company: 'Gamma'),
      ),
    ]);
    final applications = InMemoryApplicationsRepository(jobs);
    await applications.save(
      Application(
        jobId: 'a',
        status: ApplicationStatus.applied,
        appliedAt: DateTime(2026, 10, 20),
      ),
    );
    await applications.save(
      const Application(jobId: 'b', status: ApplicationStatus.preparing),
    );
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

    expect(find.text('Guardadas (2)'), findsOneWidget);
    expect(find.text('Preparando'), findsWidgets);
    expect(find.text('Sin proceso'), findsOneWidget);
    expect(find.text('Postulada'), findsNothing);
  });
}
