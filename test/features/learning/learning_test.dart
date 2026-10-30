import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_planner.dart';
import 'package:rumbo/features/learning/domain/services/learning_candidates.dart';
import 'package:rumbo/features/learning/infrastructure/di/learning_providers.dart';
import 'package:rumbo/features/learning/infrastructure/repositories/in_memory_learning_repository.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/entities/resume_keyword.dart';
import 'package:rumbo/features/profile/domain/repositories/resume_keywords_source.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

class _FakeKeywords implements ResumeKeywordsSource {
  final KeywordsResult _keywords = KeywordsResult(
    updatedAt: DateTime(2026, 10, 18),
    keywords: const <ResumeKeyword>[
      ResumeKeyword(keyword: 'Dart', important: true),
      ResumeKeyword(keyword: 'Riverpod', important: true),
    ],
  );

  @override
  Future<Result<KeywordsResult?>> cached() async =>
      Ok<KeywordsResult?>(_keywords);

  @override
  Future<Result<KeywordsResult>> fetch({bool force = false}) async =>
      Ok<KeywordsResult>(_keywords);
}

class _FakePlanner implements LearningPlanner {
  final List<String> topics = <String>[];

  @override
  Future<Result<LearningPlan>> generate(String topicId) async {
    topics.add(topicId);
    return Ok<LearningPlan>(
      LearningPlan.fromJson(<String, dynamic>{
        'why': 'Lo piden casi todas tus ofertas de Flutter.',
        'steps': <Map<String, String>>[
          <String, String>{
            'title': 'Providers básicos',
            'detail': 'Provider y Notifier.',
          },
        ],
        'resources': <Map<String, String>>[
          <String, String>{
            'title': 'Documentación de Riverpod',
            'url': 'https://riverpod.dev',
            'kind': 'docs',
          },
        ],
        'project': 'Migra una pantalla de tu app a Riverpod.',
        'hours': 12,
      }),
    );
  }
}

const ProfileData _profile = ProfileData(
  profile: Profile(fullName: 'Juan', headline: 'Desarrollador Flutter'),
  skills: <Skill>[Skill(name: 'Dart')],
);

SavedJob _job(String title, List<String> requirements) => SavedJob(
  job: Job(title: title, company: 'Acme', requirements: requirements),
);

void main() {
  test('sugiere lo que falta en la HV, ordenado por demanda', () {
    final List<LearningCandidate> candidates = learningCandidates(
      profile: _profile,
      keywords:
          const <({List<String> aliases, bool important, String keyword})>[
            (keyword: 'Dart', aliases: <String>[], important: true),
            (keyword: 'Riverpod', aliases: <String>[], important: true),
            (keyword: 'Firebase', aliases: <String>[], important: false),
          ],
      gaps: const <({int count, String label})>[
        (label: 'Firebase', count: 1),
        (label: 'GraphQL', count: 2),
        (label: 'Experiencia liderando equipos multidisciplinarios', count: 5),
      ],
      market: <SavedJob>[
        _job('A', <String>['Riverpod', 'Firebase']),
        _job('B', <String>['Riverpod', 'Firebase']),
        _job('C', <String>['Riverpod']),
      ],
      planned: const <LearningTopic>[],
    );
    expect(
      <String>[for (final LearningCandidate c in candidates) c.topic],
      <String>['Riverpod', 'Firebase', 'GraphQL'],
    );
    expect(candidates.first.demand, 3);
    expect(candidates.first.important, isTrue);
  });

  test('no repite lo que ya está en el plan', () {
    final List<LearningCandidate> candidates = learningCandidates(
      profile: _profile,
      keywords:
          const <({List<String> aliases, bool important, String keyword})>[
            (keyword: 'Riverpod', aliases: <String>[], important: true),
          ],
      gaps: const <({int count, String label})>[],
      market: const <SavedJob>[],
      planned: const <LearningTopic>[LearningTopic(id: '1', topic: 'riverpod')],
    );
    expect(candidates, isEmpty);
  });

  test('el plan muestra primero lo que se está aprendiendo', () {
    final List<LearningTopic> sorted = sortTopics(const <LearningTopic>[
      LearningTopic(id: 'a', topic: 'A', status: LearningStatus.mastered),
      LearningTopic(id: 'b', topic: 'B', demand: 1),
      LearningTopic(id: 'c', topic: 'C', demand: 4),
      LearningTopic(id: 'd', topic: 'D', status: LearningStatus.learning),
    ]);
    expect(
      <String>[for (final LearningTopic t in sorted) t.id],
      <String>['d', 'c', 'b', 'a'],
    );
  });

  testWidgets('añade una sugerencia, crea su plan y la marca dominada', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    await jobs.save(_job('Flutter Developer', <String>['Riverpod', 'Dart']));
    final InMemoryLearningRepository learning = InMemoryLearningRepository();
    final _FakePlanner planner = _FakePlanner();

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
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
    final Finder open = find.byKey(const Key('openLearning'));
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
    expect(planner.topics, <String>[learning.items.single.id]);
    expect(find.text('Providers básicos'), findsOneWidget);
    expect(find.text('Documentación de Riverpod'), findsOneWidget);

    await tester.tap(find.text('Dominado'));
    await tester.pumpAndSettle();
    expect(learning.items.single.status, LearningStatus.mastered);
    expect(find.byKey(const Key('addTopicSkill')), findsOneWidget);
  });
}
