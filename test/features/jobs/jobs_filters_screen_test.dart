import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/repositories/job_analyzer.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/services/shared_text_source.dart';

class _NoAnalyzer implements JobAnalyzer {
  @override
  Future<Result<SavedJob>> analyze({String? url, String? text}) =>
      throw UnimplementedError();
}

class _FakeShared implements SharedTextSource {
  _FakeShared(this.text);

  String? text;

  @override
  Future<String?> take() async {
    final String? value = text;
    text = null;
    return value;
  }

  @override
  void listen(VoidCallback onShared) {}
}

Future<void> _pump(
  WidgetTester tester,
  InMemoryJobsRepository jobs, {
  String? shared,
}) async {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
        jobsRepositoryProvider.overrideWithValue(jobs),
        jobAnalyzerProvider.overrideWithValue(_NoAnalyzer()),
        sharedTextSourceProvider.overrideWithValue(_FakeShared(shared)),
      ],
      child: const RumboApp(locale: Locale('es')),
    ),
  );
  await tester.pumpAndSettle();
}

Future<InMemoryJobsRepository> _suggestions() async {
  final InMemoryJobsRepository jobs = InMemoryJobsRepository();
  for (final (String title, WorkMode mode, int score)
      in <(String, WorkMode, int)>[
        ('Flutter Remoto', WorkMode.remote, 80),
        ('Flutter Híbrido', WorkMode.hybrid, 70),
        ('Mobile Junior', WorkMode.remote, 40),
      ]) {
    await jobs.save(
      SavedJob(
        job: Job(
          title: title,
          company: 'Empresa $title',
          workMode: mode,
          source: 'getonboard',
          discovered: true,
        ),
        match: JobMatch(score: score),
      ),
    );
  }
  return jobs;
}

void main() {
  testWidgets('filtra las sugerencias y recupera una descartada', (
    WidgetTester tester,
  ) async {
    final InMemoryJobsRepository jobs = await _suggestions();
    await _pump(tester, jobs);
    await tester.tap(find.text('Ofertas').last);
    await tester.pumpAndSettle();
    expect(find.text('Sugeridas (3)'), findsOneWidget);

    await tester.tap(find.byKey(const Key('filterRemote')));
    await tester.pumpAndSettle();
    expect(find.text('Flutter Híbrido'), findsNothing);
    expect(find.text('Flutter Remoto'), findsOneWidget);
    expect(find.text('Mobile Junior'), findsOneWidget);

    await tester.tap(find.byKey(const Key('filterGoodMatch')));
    await tester.pumpAndSettle();
    expect(find.text('Mobile Junior'), findsNothing);
    expect(find.text('Flutter Remoto'), findsOneWidget);

    await tester.tap(find.byKey(const Key('filterClear')));
    await tester.pumpAndSettle();
    expect(find.text('Flutter Híbrido'), findsOneWidget);

    // Descarta deslizando y la recupera desde «Descartadas».
    await tester.drag(find.text('Mobile Junior'), const Offset(-600, 0));
    await tester.pumpAndSettle();
    expect(find.text('Sugeridas (2)'), findsOneWidget);
    await tester.tap(find.text('Descartadas · 1'));
    await tester.pumpAndSettle();
    final String id = (await jobs.list())
        .getOrThrow()
        .firstWhere((SavedJob s) => s.job.title == 'Mobile Junior')
        .job
        .id;
    await tester.tap(find.byKey(Key('restore-$id')));
    await tester.pumpAndSettle();
    expect(find.text('Sugeridas (3)'), findsOneWidget);
    expect(
      find.text('Oferta recuperada: vuelve a estar en Sugeridas.'),
      findsOneWidget,
    );
    expect(find.textContaining('Descartadas'), findsNothing);
  });

  testWidgets('una oferta compartida abre «Añadir oferta» con el enlace', (
    WidgetTester tester,
  ) async {
    await _pump(
      tester,
      InMemoryJobsRepository(),
      shared: 'Flutter Developer https://www.getonbrd.com/jobs/flutter-1',
    );
    expect(find.text('Nueva oferta'), findsOneWidget);
    final TextField url = tester.widget<TextField>(
      find.descendant(
        of: find.byKey(const Key('jobUrl')),
        matching: find.byType(TextField),
      ),
    );
    expect(url.controller!.text, 'https://www.getonbrd.com/jobs/flutter-1');
  });
}
