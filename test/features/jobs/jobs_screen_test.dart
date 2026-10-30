import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/failures/job_failures.dart';
import 'package:rumbo/features/jobs/domain/repositories/job_analyzer.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

class _FakeAnalyzer implements JobAnalyzer {
  _FakeAnalyzer(this.result);

  final Future<Result<SavedJob>> Function() result;
  String? lastText;

  @override
  Future<Result<SavedJob>> analyze({String? url, String? text}) {
    lastText = text;
    return result();
  }
}

const SavedJob _analysis = SavedJob(
  job: Job(
    title: 'Senior Flutter Developer',
    company: 'Fintech',
    location: 'LATAM',
    workMode: WorkMode.remote,
    requirements: <String>['Flutter', 'Riverpod', 'Kotlin'],
    salaryMin: 4000,
    salaryMax: 5500,
    salaryCurrency: 'USD',
    description: 'Buscamos una persona…',
  ),
  match: JobMatch(
    score: 82,
    met: <String>['Flutter: 2 años en GSE'],
    missing: <String>['Kotlin'],
    explanation: 'Encajas bien; destaca tu experiencia con Riverpod.',
  ),
);

Future<InMemoryJobsRepository> _openJobs(
  WidgetTester tester,
  JobAnalyzer analyzer,
) async {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  final InMemoryJobsRepository repository = InMemoryJobsRepository();
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
        jobsRepositoryProvider.overrideWithValue(repository),
        jobAnalyzerProvider.overrideWithValue(analyzer),
      ],
      child: const RumboApp(locale: Locale('es')),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Ofertas').last);
  await tester.pumpAndSettle();
  return repository;
}

void main() {
  testWidgets('analiza una oferta pegada, la guarda y la elimina', (
    WidgetTester tester,
  ) async {
    final _FakeAnalyzer analyzer = _FakeAnalyzer(
      () async => const Ok<SavedJob>(_analysis),
    );
    final InMemoryJobsRepository repository = await _openJobs(tester, analyzer);
    expect(find.text('Aún no hay ofertas'), findsOneWidget);

    await tester.tap(find.byKey(const Key('addJob')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Analizar oferta'));
    await tester.pump();
    expect(
      find.text('Pega el enlace o la descripción de la oferta.'),
      findsOneWidget,
    );

    await tester.enterText(
      find.byKey(const Key('jobText')),
      'Buscamos Senior Flutter Developer…',
    );
    await tester.tap(find.text('Analizar oferta'));
    await tester.pumpAndSettle();
    expect(analyzer.lastText, 'Buscamos Senior Flutter Developer…');

    expect(find.text('Senior Flutter Developer'), findsOneWidget);
    expect(find.text('Fintech · LATAM · Remoto'), findsOneWidget);
    expect(find.text('USD 4.000 – 5.500'), findsOneWidget);
    expect(find.text('82'), findsOneWidget);
    expect(find.text('Flutter: 2 años en GSE'), findsOneWidget);
    expect(find.text('Kotlin'), findsOneWidget);

    await tester.tap(find.text('Guardar oferta'));
    await tester.pumpAndSettle();
    expect(find.text('Oferta guardada.'), findsOneWidget);
    expect(find.text('Senior Flutter Developer'), findsOneWidget);
    expect((await repository.list()).getOrThrow().single.match!.score, 82);

    await tester.tap(find.text('Senior Flutter Developer'));
    await tester.pumpAndSettle();
    expect(find.text('Buscamos una persona…'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Eliminar'));
    await tester.pumpAndSettle();
    expect(find.text('Aún no hay ofertas'), findsOneWidget);
    expect((await repository.list()).getOrThrow(), isEmpty);
  });

  testWidgets('pide la descripción si el enlace no se puede leer', (
    WidgetTester tester,
  ) async {
    await _openJobs(
      tester,
      _FakeAnalyzer(() async => const Err<SavedJob>(NoDescriptionFailure())),
    );

    await tester.tap(find.byKey(const Key('addJob')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('jobUrl')),
      'https://www.linkedin.com/jobs/view/123',
    );
    await tester.tap(find.text('Analizar oferta'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('No pudimos leer la oferta desde el enlace'),
      findsOneWidget,
    );
    expect(find.text('Analizar oferta'), findsOneWidget);
  });

  testWidgets('avisa si la oferta ya estaba guardada', (
    WidgetTester tester,
  ) async {
    final InMemoryJobsRepository repository = await _openJobs(
      tester,
      _FakeAnalyzer(() async => const Ok<SavedJob>(_analysis)),
    );
    await repository.save(_analysis);

    await tester.tap(find.byKey(const Key('addJob')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('jobText')), 'Oferta');
    await tester.tap(find.text('Analizar oferta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar oferta'));
    await tester.pumpAndSettle();

    expect(find.text('Ya tienes guardada esta oferta.'), findsOneWidget);
    expect((await repository.list()).getOrThrow(), hasLength(1));
  });
}
