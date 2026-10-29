import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/learning/data/learning_repository.dart';
import 'package:rumbo/features/learning/domain/learning.dart';
import 'package:rumbo/features/profile/data/profile_repository.dart';
import 'package:rumbo/features/profile/data/resume_keywords.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

class _FakeKeywords implements ResumeKeywordsSource {
  @override
  Future<KeywordsResult?> cached() async => KeywordsResult(
    updatedAt: DateTime(2026, 10, 18),
    keywords: const [
      ResumeKeyword(keyword: 'Dart', important: true),
      ResumeKeyword(keyword: 'Riverpod', important: true),
    ],
  );

  @override
  Future<KeywordsResult> fetch({bool force = false}) async => (await cached())!;
}

class _FakePlanner implements LearningPlanner {
  final topics = <String>[];

  @override
  Future<LearningPlan> generate(String topicId) async {
    topics.add(topicId);
    return LearningPlan.fromJson({
      'why': 'Lo piden casi todas tus ofertas de Flutter.',
      'steps': [
        {'title': 'Providers básicos', 'detail': 'Provider y Notifier.'},
      ],
      'resources': [
        {
          'title': 'Documentación de Riverpod',
          'url': 'https://riverpod.dev',
          'kind': 'docs',
        },
      ],
      'project': 'Migra una pantalla de tu app a Riverpod.',
      'hours': 12,
    });
  }
}

const _profile = ProfileData(
  profile: Profile(fullName: 'Juan', headline: 'Desarrollador Flutter'),
  skills: [Skill(name: 'Dart')],
);

SavedJob _job(String title, List<String> requirements) => SavedJob(
  job: Job(title: title, company: 'Acme', requirements: requirements),
);

void main() {
  test('sugiere lo que falta en la HV, ordenado por demanda', () {
    final candidates = learningCandidates(
      profile: _profile,
      keywords: const [
        (keyword: 'Dart', aliases: [], important: true),
        (keyword: 'Riverpod', aliases: [], important: true),
        (keyword: 'Firebase', aliases: [], important: false),
      ],
      gaps: const [
        (label: 'Firebase', count: 1),
        (label: 'GraphQL', count: 2),
        (label: 'Experiencia liderando equipos multidisciplinarios', count: 5),
      ],
      market: [
        _job('A', ['Riverpod', 'Firebase']),
        _job('B', ['Riverpod', 'Firebase']),
        _job('C', ['Riverpod']),
      ],
      planned: const [],
    );
    expect(
      [for (final c in candidates) c.topic],
      ['Riverpod', 'Firebase', 'GraphQL'],
    );
    expect(candidates.first.demand, 3);
    expect(candidates.first.important, isTrue);
  });

  test('no repite lo que ya está en el plan', () {
    final candidates = learningCandidates(
      profile: _profile,
      keywords: const [(keyword: 'Riverpod', aliases: [], important: true)],
      gaps: const [],
      market: const [],
      planned: const [LearningTopic(id: '1', topic: 'riverpod')],
    );
    expect(candidates, isEmpty);
  });

  test('el plan muestra primero lo que se está aprendiendo', () {
    final sorted = sortTopics(const [
      LearningTopic(id: 'a', topic: 'A', status: LearningStatus.mastered),
      LearningTopic(id: 'b', topic: 'B', demand: 1),
      LearningTopic(id: 'c', topic: 'C', demand: 4),
      LearningTopic(id: 'd', topic: 'D', status: LearningStatus.learning),
    ]);
    expect([for (final t in sorted) t.id], ['d', 'c', 'b', 'a']);
  });

  testWidgets('añade una sugerencia, crea su plan y la marca dominada', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final jobs = InMemoryJobsRepository();
    await jobs.save(_job('Flutter Developer', ['Riverpod', 'Dart']));
    final learning = InMemoryLearningRepository();
    final planner = _FakePlanner();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          profileRepositoryProvider.overrideWithValue(
            InMemoryProfileRepository(_profile),
          ),
          jobsRepositoryProvider.overrideWithValue(jobs),
          resumeKeywordsSourceProvider.overrideWithValue(_FakeKeywords()),
          learningRepositoryProvider.overrideWithValue(learning),
          learningPlannerProvider.overrideWithValue(planner),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('HV'));
    await tester.pumpAndSettle();
    final open = find.byKey(const Key('openLearning'));
    await tester.scrollUntilVisible(
      open,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(open);
    await tester.pumpAndSettle();

    // Dart ya está en Habilidades: solo se sugiere Riverpod.
    expect(find.byKey(const Key('candidate-Dart')), findsNothing);
    await tester.tap(find.byKey(const Key('add-Riverpod')));
    await tester.pumpAndSettle();
    expect(learning.items.single.topic, 'Riverpod');
    expect(learning.items.single.demand, 1);
    expect(find.byKey(const Key('candidate-Riverpod')), findsNothing);

    await tester.tap(find.byKey(const Key('topic-Riverpod')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('generatePlan')));
    await tester.pumpAndSettle();
    expect(planner.topics, [learning.items.single.id]);
    expect(find.text('Providers básicos'), findsOneWidget);
    expect(find.text('Documentación de Riverpod'), findsOneWidget);

    await tester.tap(find.text('Dominado'));
    await tester.pumpAndSettle();
    expect(learning.items.single.status, LearningStatus.mastered);
    expect(find.byKey(const Key('addTopicSkill')), findsOneWidget);
  });
}
