import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/job_analyzer.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';

class _FakeAnalyzer implements JobAnalyzer {
  String? lastText;

  @override
  Future<SavedJob> analyze({String? url, String? text}) async {
    lastText = text;
    return SavedJob(
      job: Job(
        title: 'Flutter Engineer (otro nombre)',
        company: 'Acme',
        location: 'Remoto',
        workMode: WorkMode.remote,
        description: text!,
        requirements: const ['Flutter', 'Riverpod', 'CI/CD'],
        salaryMin: 4000,
        salaryCurrency: 'USD',
      ),
      match: const JobMatch(
        score: 78,
        met: ['Flutter: 3 años'],
        missing: ['CI/CD'],
        explanation: 'Encaja bien.',
      ),
    );
  }
}

/// Sugerencia de una alerta de LinkedIn: solo trae el título.
const _fromLinkedIn = SavedJob(
  job: Job(
    id: 'j1',
    source: 'linkedin',
    url: 'https://www.linkedin.com/jobs/view/4012345678/',
    title: 'Flutter Developer',
    company: 'Acme Labs',
    location: 'Bogotá, Colombia',
    description: 'Flutter Developer\nAcme Labs\nBogotá, Colombia (Remote)',
    discovered: true,
  ),
  match: JobMatch(score: 55, explanation: 'Solo por el título.'),
);

final _fullDescription =
    'Buscamos Flutter Developer con experiencia en Riverpod y CI/CD. ' * 5;

void main() {
  test('completar conserva lo que identifica la oferta', () {
    expect(_fromLinkedIn.job.needsDescription, isTrue);
    final analyzed = Job(
      title: 'Otro cargo',
      company: 'Otra empresa',
      location: 'Otra ciudad',
      workMode: WorkMode.remote,
      description: _fullDescription,
      requirements: const ['Flutter'],
      salaryMax: 6000,
    );
    final completed = completeJob(_fromLinkedIn.job, analyzed);
    expect(completed.id, 'j1');
    expect(completed.source, 'linkedin');
    expect(completed.url, _fromLinkedIn.job.url);
    expect(completed.title, 'Flutter Developer');
    expect(completed.company, 'Acme Labs');
    expect(completed.location, 'Bogotá, Colombia');
    expect(completed.discovered, isTrue);
    expect(completed.description, _fullDescription);
    expect(completed.requirements, ['Flutter']);
    expect(completed.workMode, WorkMode.remote);
    expect(completed.salaryMax, 6000);
    expect(completed.needsDescription, isFalse);
  });

  testWidgets('completa una sugerencia de LinkedIn pegando la descripción', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final repository = InMemoryJobsRepository([_fromLinkedIn]);
    final analyzer = _FakeAnalyzer();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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
    await tester.tap(find.text('Flutter Developer').first);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('jobNeedsDescription')), findsOneWidget);
    await tester.tap(find.byKey(const Key('completeJobBanner')));
    await tester.pumpAndSettle();

    // Muy corta: no se gasta IA.
    await tester.enterText(find.byKey(const Key('completeText')), 'Flutter');
    await tester.tap(find.byKey(const Key('completeJob')));
    await tester.pump();
    expect(
      find.text('Pega al menos 200 caracteres de la descripción.'),
      findsOneWidget,
    );
    expect(analyzer.lastText, isNull);

    await tester.enterText(
      find.byKey(const Key('completeText')),
      _fullDescription,
    );
    await tester.tap(find.byKey(const Key('completeJob')));
    await tester.pumpAndSettle();
    expect(analyzer.lastText, _fullDescription.trim());
    expect(find.text('Oferta completada. Compatibilidad: 78.'), findsOneWidget);

    // De vuelta en el detalle: sin aviso y con la nueva nota.
    expect(find.byKey(const Key('jobNeedsDescription')), findsNothing);
    expect(find.text('78'), findsWidgets);
    final saved = (await repository.list()).single;
    expect(saved.job.id, 'j1');
    expect(saved.job.title, 'Flutter Developer');
    expect(saved.job.company, 'Acme Labs');
    expect(saved.job.isSuggestion, isTrue);
    expect(saved.job.requirements, ['Flutter', 'Riverpod', 'CI/CD']);
    expect(saved.job.salaryMin, 4000);
    expect(saved.match!.score, 78);
  });
}
