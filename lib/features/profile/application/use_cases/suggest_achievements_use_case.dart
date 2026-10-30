import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/achievement_suggestion.dart';
import 'package:rumbo/features/profile/domain/repositories/achievement_rewriter.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'suggest_achievements_use_case.g.dart';

/// Propuestas de la IA para los logros de una experiencia. No guarda nada.
class SuggestAchievementsUseCase {
  const SuggestAchievementsUseCase({required this._rewriter});

  final AchievementRewriter? _rewriter;

  /// Falso en modo local, donde no hay IA.
  bool get isAvailable => _rewriter != null;

  Future<Result<List<AchievementSuggestion>>> call(String experienceId) async =>
      await _rewriter?.suggest(experienceId) ??
      const Err<List<AchievementSuggestion>>(BackendUnavailableFailure());
}

@Riverpod(keepAlive: true)
SuggestAchievementsUseCase suggestAchievementsUseCase(Ref ref) =>
    SuggestAchievementsUseCase(
      rewriter: ref.watch(achievementRewriterProvider),
    );
