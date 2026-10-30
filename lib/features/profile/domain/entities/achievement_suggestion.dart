import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement_suggestion.freezed.dart';

/// Propuesta de la IA para un logro. [index] nulo: logro nuevo.
@Freezed(fromJson: false, toJson: false)
abstract class AchievementSuggestion with _$AchievementSuggestion {
  const factory AchievementSuggestion({
    required int? index,
    required String original,
    required String rewritten,
    @Default('') String reason,
  }) = _AchievementSuggestion;

  factory AchievementSuggestion.fromJson(Map<String, dynamic> json) =>
      AchievementSuggestion(
        index: json['index'] as int?,
        original: json['original'] as String? ?? '',
        rewritten: json['rewritten'] as String,
        reason: json['reason'] as String? ?? '',
      );
}
