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
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/features/offers/domain/entities/negotiation_draft.dart';
import 'package:rumbo/features/offers/infrastructure/di/offers_providers.dart';
import 'package:rumbo/features/offers/infrastructure/mappers/job_offer_mapper.dart';
import 'package:rumbo/features/offers/infrastructure/repositories/in_memory_offers_repository.dart';

void main() {
  test('el salario anual se compara en mensual', () {
    const JobOffer yearly = JobOffer(
      applicationId: 'a',
      salary: 60000,
      period: SalaryPeriod.year,
    );
    expect(yearly.monthlySalary, 5000);
    expect(const JobOffer(applicationId: 'b').monthlySalary, isNull);
  });

  test('convierte filas de ofertas', () {
    final JobOffer offer = JobOffer(
      applicationId: 'a1',
      salary: 4500,
      currency: 'usd',
      workMode: WorkMode.remote,
      deadline: DateTime(2026, 11, 2),
    );
    final Map<String, dynamic> row = offerToRow(offer);
    expect(row['currency'], 'USD');
    expect(row['deadline'], '2026-11-02');
    expect(row['work_mode'], 'remote');
    final JobOffer back = offerFromRow(<String, dynamic>{
      ...row,
      'salary': 4500,
    });
    expect(back.salary, 4500);
    expect(back.deadline, DateTime(2026, 11, 2));
  });

  test('convierte el borrador de negociación', () {
    final NegotiationDraft draft = NegotiationDraft.fromJson(<String, dynamic>{
      'email': 'Hola equipo…',
      'talking_points': <Object>['Publiqué 3 apps', 4],
      'risks': <dynamic>[],
    });
    expect(draft.talkingPoints, <String>['Publiqué 3 apps']);
    expect(draft.risks, isEmpty);
  });

  testWidgets('registra condiciones y compara dos ofertas', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    for (final String company in <String>['Forest', 'Beta']) {
      await jobs.save(
        SavedJob(
          job: Job(title: 'Flutter Developer', company: company),
          match: const JobMatch(score: 70),
        ),
      );
    }
    final InMemoryApplicationsRepository applications =
        InMemoryApplicationsRepository(jobs);
    final Map<String, String> ids = <String, String>{};
    for (final SavedJob saved in (await jobs.list()).getOrThrow()) {
      final Application app = (await applications.save(
        Application(jobId: saved.job.id, status: ApplicationStatus.offer),
      )).getOrThrow();
      ids[saved.job.company] = app.id;
    }
    final InMemoryOffersRepository offers = InMemoryOffersRepository();
    await offers.save(
      JobOffer(
        applicationId: ids['Beta']!,
        salary: 48000,
        period: SalaryPeriod.year,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          applicationsRepositoryProvider.overrideWithValue(applications),
          offersRepositoryProvider.overrideWithValue(offers),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Procesos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Forest'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('editOffer')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('offerSalary')), '5000');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('USD 5.000 · Mensual'), findsOneWidget);

    await tester.tap(find.text('Comparar ofertas'));
    await tester.pumpAndSettle();
    expect(find.text('USD 5.000 al mes'), findsOneWidget);
    expect(find.text('USD 4.000 al mes'), findsOneWidget);
    expect(find.text('Mejor salario en USD'), findsOneWidget);
    expect(find.text('Compatibilidad 70'), findsNWidgets(2));
  });
}
