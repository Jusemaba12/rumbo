import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/data/auth_repository.dart';
import '../../jobs/presentation/jobs_controller.dart';
import '../../profile/data/resume_keywords.dart';
import '../../profile/domain/keyword_analysis.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../stats/presentation/stats_screen.dart' show searchStatsProvider;
import '../data/learning_repository.dart';
import '../domain/learning.dart' hide learningCandidates;
import '../domain/learning.dart' as domain show learningCandidates;

part 'learning_controller.g.dart';

@Riverpod(keepAlive: true)
class LearningController extends _$LearningController {
  LearningRepository get _repository => ref.read(learningRepositoryProvider);

  @override
  Future<List<LearningTopic>> build() async {
    ref.watch(sessionChangesProvider);
    return sortTopics(await ref.watch(learningRepositoryProvider).list());
  }

  Future<void> _reload() async =>
      state = AsyncData(sortTopics(await _repository.list()));

  Future<void> add(LearningCandidate candidate) async {
    await _repository.add(candidate.topic, demand: candidate.demand);
    await _reload();
  }

  Future<void> setStatus(String id, LearningStatus status) async {
    await _repository.setStatus(id, status);
    await _reload();
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
    await _reload();
  }

  /// Guarda en memoria el plan recién generado (el servidor ya lo guardó).
  void planGenerated(String id, LearningPlan plan) {
    final topics = state.value;
    if (topics == null) return;
    state = AsyncData([
      for (final t in topics) t.id == id ? t.copyWith(plan: plan) : t,
    ]);
  }
}

/// Sugerencias de qué aprender con lo que la app ya sabe del usuario.
@Riverpod(keepAlive: true)
List<LearningCandidate> learningCandidates(Ref ref) {
  final profile = ref.watch(profileControllerProvider).value;
  if (profile == null) return const [];
  final keywords =
      ref.watch(resumeKeywordsProvider).value?.keywords ?? const [];
  final gaps = ref.watch(searchStatsProvider).value?.gaps ?? const [];
  return domain.learningCandidates(
    profile: profile,
    keywords: [
      for (final k in keywords)
        (keyword: k.keyword, aliases: k.aliases, important: k.important),
    ],
    gaps: [for (final g in gaps) (label: g.label, count: g.count)],
    market: marketJobs(ref.watch(jobsControllerProvider).value ?? const []),
    planned: ref.watch(learningControllerProvider).value ?? const [],
  );
}
