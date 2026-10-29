import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/core/share/shared_text.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/job_analyzer.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';

class _NoAnalyzer implements JobAnalyzer {
  @override
  Future<SavedJob> analyze({String? url, String? text}) =>
      throw UnimplementedError();
}

class _FakeShared implements SharedTextSource {
  _FakeShared(this.text);

  String? text;

  @override
  Future<String?> take() async {
    final value = text;
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
      overrides: [
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
  final jobs = InMemoryJobsRepository();
  for (final (title, mode, score) in [
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
    tester,
  ) async {
    final jobs = await _suggestions();
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
    final id = (await jobs.list())
        .firstWhere((s) => s.job.title == 'Mobile Junior')
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
    tester,
  ) async {
    await _pump(
      tester,
      InMemoryJobsRepository(),
      shared: 'Flutter Developer https://www.getonbrd.com/jobs/flutter-1',
    );
    expect(find.text('Nueva oferta'), findsOneWidget);
    final url = tester.widget<TextField>(
      find.descendant(
        of: find.byKey(const Key('jobUrl')),
        matching: find.byType(TextField),
      ),
    );
    expect(url.controller!.text, 'https://www.getonbrd.com/jobs/flutter-1');
  });
}
