import 'package:rumbo/features/profile/domain/entities/achievement_suggestion.dart';
import 'package:rumbo/shared/domain/result.dart';

abstract interface class AchievementRewriter {
  /// Propuestas para los logros de una experiencia guardada.
  Future<Result<List<AchievementSuggestion>>> suggest(String experienceId);
}
