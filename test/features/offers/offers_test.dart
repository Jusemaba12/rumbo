import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/applications/data/applications_repository.dart';
import 'package:rumbo/features/applications/domain/application.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/offers/data/negotiation.dart';
import 'package:rumbo/features/offers/data/offers_repository.dart';
import 'package:rumbo/features/offers/domain/job_offer.dart';

void main() {
  test('el salario anual se compara en mensual', () {
    const yearly = JobOffer(
      applicationId: 'a',
      salary: 60000,
      period: SalaryPeriod.year,
    );
    expect(yearly.monthlySalary, 5000);
    expect(const JobOffer(applicationId: 'b').monthlySalary, isNull);
  });

  test('convierte filas de ofertas', () {
    final offer = JobOffer(
      applicationId: 'a1',
      salary: 4500,
      currency: 'usd',
      workMode: WorkMode.remote,
      deadline: DateTime(2026, 11, 2),
    );
    final row = offerToRow(offer);
    expect(row['currency'], 'USD');
    expect(row['deadline'], '2026-11-02');
    expect(row['work_mode'], 'remote');
    final back = offerFromRow({...row, 'salary': 4500});
    expect(back.salary, 4500);
    expect(back.deadline, DateTime(2026, 11, 2));
  });

  test('convierte el borrador de negociación', () {
    final draft = NegotiationDraft.fromJson({
      'email': 'Hola equipo…',
      'talking_points': ['Publiqué 3 apps', 4],
      'risks': [],
    });
    expect(draft.talkingPoints, ['Publiqué 3 apps']);
    expect(draft.risks, isEmpty);
  });

  testWidgets('registra condiciones y compara dos ofertas', (tester) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final jobs = InMemoryJobsRepository();
    for (final company in ['Forest', 'Beta']) {
      await jobs.save(
        SavedJob(
          job: Job(title: 'Flutter Developer', company: company),
          match: const JobMatch(score: 70),
        ),
      );
    }
    final applications = InMemoryApplicationsRepository(jobs);
    final ids = <String, String>{};
    for (final saved in await jobs.list()) {
      final app = await applications.save(
        Application(jobId: saved.job.id, status: ApplicationStatus.offer),
      );
      ids[saved.job.company] = app.id;
    }
    final offers = InMemoryOffersRepository();
    await offers.save(
      JobOffer(
        applicationId: ids['Beta']!,
        salary: 48000,
        period: SalaryPeriod.year,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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
