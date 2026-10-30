import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/domain/repositories/ats_reader.dart';
import 'package:rumbo/features/applications/domain/repositories/resume_tailor.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/in_memory_applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/in_memory_resume_versions_repository.dart';
import 'package:rumbo/features/applications/infrastructure/services/pdf_services.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

class _FakeAtsReader implements AtsReader {
  @override
  Future<Result<AtsReading>> read(Uint8List pdf) async => const Ok<AtsReading>((
    text: 'Juan Manzano\nDesarrollador Flutter para fintech\nEXPERIENCIA',
    pages: 1,
  ));
}

class _FakeTailor implements ResumeTailor {
  @override
  Future<Result<ApplicationDraft>> tailor(String jobId) async =>
      Ok<ApplicationDraft>(
        ApplicationDraft(
          jobId: jobId,
          resume: TailoredResume(
            headline: 'Desarrollador Flutter para fintech',
            summary: 'Dos años creando apps con Flutter y Riverpod.',
            experiences: <TailoredExperience>[
              TailoredExperience(
                experienceId: 'e1',
                company: 'GSE',
                role: 'Flutter Developer',
                startDate: DateTime(2024, 9),
                bullets: const <String>['Reduje el arranque un 40 %'],
              ),
            ],
            skills: const <String>['Dart', 'Riverpod'],
          ),
          coverLetter: 'Hola equipo de Fintech…',
          changes: const <ResumeChange>[
            ResumeChange(
              section: 'Titular',
              before: 'Flutter Developer',
              after: 'Desarrollador Flutter para fintech',
              reason: 'Usa el nombre del puesto',
            ),
          ],
          keywords: const <String>['Riverpod'],
          rejected: const <String>['Lideré un equipo de 8 personas'],
        ),
      );
}

void main() {
  testWidgets('prepara, guarda la versión y exporta el PDF', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    final InMemoryResumeVersionsRepository versions =
        InMemoryResumeVersionsRepository();
    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    final InMemoryApplicationsRepository applications =
        InMemoryApplicationsRepository(jobs);
    await jobs.save(
      const SavedJob(
        job: Job(
          title: 'Senior Flutter Developer',
          company: 'Fintech',
          requirements: <String>['Riverpod', 'CI/CD'],
        ),
      ),
    );
    String? sharedName;
    int sharedBytes = 0;

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          profileRepositoryProvider.overrideWithValue(
            InMemoryProfileRepository(
              const ProfileData(profile: Profile(fullName: 'Juan Manzano')),
            ),
          ),
          resumeTailorProvider.overrideWithValue(_FakeTailor()),
          resumeVersionsRepositoryProvider.overrideWithValue(versions),
          applicationsRepositoryProvider.overrideWithValue(applications),
          // Sin red en los tests: se usan las fuentes por defecto del PDF.
          resumeFontsProvider.overrideWith((Ref ref) async => null),
          atsReaderProvider.overrideWithValue(_FakeAtsReader()),
          pdfSharerProvider.overrideWithValue((
            List<int> bytes,
            String name,
          ) async {
            sharedBytes = bytes.length;
            sharedName = name;
          }),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ofertas').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Senior Flutter Developer'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('prepareApplication')));
    await tester.pumpAndSettle();

    expect(find.text('Juan Manzano'), findsOneWidget);
    expect(find.text('Desarrollador Flutter para fintech'), findsOneWidget);
    expect(find.text('•  Reduje el arranque un 40 %'), findsOneWidget);
    // El perfil no tiene correo ni teléfono: la vista previa lo avisa.
    expect(find.byKey(const Key('missingContact')), findsOneWidget);

    await tester.tap(find.text('Carta'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('coverLetter')),
      'Carta editada',
    );

    // Prueba el PDF como un ATS: el lector falso no encuentra el correo.
    await tester.tap(find.widgetWithText(Tab, 'HV'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('testAts')));
    await tester.pumpAndSettle();
    expect(find.text('Así lee tu PDF un ATS'), findsOneWidget);
    expect(find.byKey(const Key('ats-name')), findsOneWidget);
    expect(find.textContaining('comprobaciones superadas'), findsOneWidget);
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cambios'));
    await tester.pumpAndSettle();
    // Cobertura: Riverpod y Flutter están en la HV adaptada; CI/CD no.
    expect(find.byKey(const Key('coverageCard')), findsOneWidget);
    expect(find.textContaining('Siguen faltando: CI/CD'), findsOneWidget);
    expect(find.text('Usa el nombre del puesto'), findsOneWidget);
    expect(find.text('•  Lideré un equipo de 8 personas'), findsOneWidget);

    await tester.tap(find.text('Guardar versión'));
    await tester.pumpAndSettle();
    expect(versions.saved.single.coverLetter, 'Carta editada');
    // Guardar la versión lleva la oferta al tablero como «Preparando».
    final Application process = (await applications.list())
        .getOrThrow()
        .single
        .application;
    expect(process.status, ApplicationStatus.preparing);
    expect(process.resumeVersionId, 'version-1');
    expect(process.coverLetter, 'Carta editada');
    expect(find.text('Guardada'), findsOneWidget);

    // Generar el PDF hace trabajo asíncrono real fuera del reloj de pruebas.
    await tester.tap(find.text('Exportar PDF'));
    for (int i = 0; i < 50 && sharedName == null; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 100)),
      );
      await tester.pump();
    }
    await tester.pumpAndSettle();
    expect(sharedName, 'HV Juan Manzano - Fintech.pdf');
    expect(sharedBytes, greaterThan(1000));
  });
}
