import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/in_memory_applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/services/pdf_services.dart';
import 'package:rumbo/features/applications/infrastructure/services/resume_pdf.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';

final ProfileData _data = ProfileData(
  profile: const Profile(
    fullName: 'Ana Pérez',
    headline: 'Flutter Developer',
    summary: 'Desarrolladora móvil.',
  ),
  experiences: <Experience>[
    Experience(
      id: 'e1',
      company: 'GSE',
      role: 'Flutter Developer',
      startDate: DateTime(2024, 3),
      achievements: const <String>['Publiqué 3 apps en las tiendas.'],
    ),
  ],
  skills: const <Skill>[
    Skill(name: 'Dart'),
    Skill(name: 'Riverpod'),
  ],
);

void main() {
  test('la HV base lleva el perfil tal cual', () {
    final ApplicationDraft draft = baseResumeDraft(_data);
    expect(draft.resume.headline, 'Flutter Developer');
    expect(draft.resume.summary, 'Desarrolladora móvil.');
    expect(draft.resume.experiences.single.company, 'GSE');
    expect(draft.resume.experiences.single.bullets, <String>[
      'Publiqué 3 apps en las tiendas.',
    ]);
    expect(draft.resume.skills, <String>['Dart', 'Riverpod']);
  });

  testWidgets('descarga la HV base desde la pestaña HV', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final List<(int, String)> shared = <(int, String)>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          profileRepositoryProvider.overrideWithValue(
            InMemoryProfileRepository(_data),
          ),
          resumeFontsProvider.overrideWith((Ref ref) async => null),
          pdfSharerProvider.overrideWithValue((
            List<int> bytes,
            String name,
          ) async {
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
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
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

  testWidgets('las ofertas ya postuladas salen de Guardadas', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository(const <SavedJob>[
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
    final InMemoryApplicationsRepository applications =
        InMemoryApplicationsRepository(jobs);
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

    expect(find.text('Guardadas (2)'), findsOneWidget);
    expect(find.text('Preparando'), findsWidgets);
    expect(find.text('Sin proceso'), findsOneWidget);
    expect(find.text('Postulada'), findsNothing);
  });
}
