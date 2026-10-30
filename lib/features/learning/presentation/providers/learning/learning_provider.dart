import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/learning/application/use_cases/add_learning_topic_use_case.dart';
import 'package:rumbo/features/learning/application/use_cases/delete_learning_topic_use_case.dart';
import 'package:rumbo/features/learning/application/use_cases/get_learning_topics_use_case.dart';
import 'package:rumbo/features/learning/application/use_cases/set_learning_status_use_case.dart';
import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/domain/services/learning_candidates.dart'
    as domain
    show learningCandidates;
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/entities/resume_keyword.dart';
import 'package:rumbo/features/profile/domain/services/keyword_analysis.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/features/profile/presentation/providers/resume_keywords/resume_keywords_provider.dart';
import 'package:rumbo/features/stats/domain/services/search_stats.dart';
import 'package:rumbo/features/stats/presentation/providers/search_stats/search_stats_provider.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'learning_provider.g.dart';

@Riverpod(keepAlive: true)
class LearningController extends _$LearningController {
  @override
  Future<List<LearningTopic>> build() async {
    ref.watch(sessionChangesProvider);
    return (await ref.watch(getLearningTopicsUseCaseProvider)()).getOrThrow();
  }

  Future<Result<void>> add(LearningCandidate candidate) =>
      _thenReload(ref.read(addLearningTopicUseCaseProvider)(candidate));

  Future<Result<void>> setStatus({
    required String id,
    required LearningStatus status,
  }) => _thenReload(
    ref.read(setLearningStatusUseCaseProvider)(id: id, status: status),
  );

  Future<Result<void>> delete(String id) =>
      _thenReload(ref.read(deleteLearningTopicUseCaseProvider)(id));

  /// Guarda en memoria el plan recién generado (el servidor ya lo guardó).
  void planGenerated({required String id, required LearningPlan plan}) {
    final List<LearningTopic>? topics = state.value;
    if (topics == null) return;
    state = AsyncData<List<LearningTopic>>(<LearningTopic>[
      for (final LearningTopic t in topics)
        t.id == id ? t.copyWith(plan: plan) : t,
    ]);
  }

  Future<Result<void>> _thenReload(Future<Result<void>> action) async {
    final Result<void> result = await action;
    if (!result.isOk) return result;
    final Result<List<LearningTopic>> topics = await ref.read(
      getLearningTopicsUseCaseProvider,
    )();
    if (topics case Ok<List<LearningTopic>>(:final List<LearningTopic> value)) {
      state = AsyncData<List<LearningTopic>>(value);
    }
    return result;
  }
}

/// Sugerencias de qué aprender con lo que la app ya sabe del usuario.
@Riverpod(keepAlive: true)
List<LearningCandidate> learningCandidates(Ref ref) {
  final ProfileData? profile = ref.watch(profileControllerProvider).value;
  if (profile == null) return const <LearningCandidate>[];
  final List<ResumeKeyword> keywords =
      ref.watch(resumeKeywordsProvider).value?.keywords ??
      const <ResumeKeyword>[];
  final List<SkillGap> gaps =
      ref.watch(searchStatsProvider).value?.gaps ?? const <SkillGap>[];
  return domain.learningCandidates(
    profile: profile,
    keywords: <({List<String> aliases, bool important, String keyword})>[
      for (final ResumeKeyword k in keywords)
        (keyword: k.keyword, aliases: k.aliases, important: k.important),
    ],
    gaps: <({int count, String label})>[
      for (final SkillGap g in gaps) (label: g.label, count: g.count),
    ],
    market: marketJobs(
      ref.watch(jobsControllerProvider).value ?? const <SavedJob>[],
    ),
    planned:
        ref.watch(learningControllerProvider).value ?? const <LearningTopic>[],
  );
}
