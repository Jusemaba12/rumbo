import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';

part 'achievement_rewriter.g.dart';
part 'achievement_rewriter.freezed.dart';

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

enum RewriteFailure { dailyLimit, rateLimited, busy, other }

class RewriteException implements Exception {
  const RewriteException(this.reason);

  final RewriteFailure reason;
}

abstract interface class AchievementRewriter {
  /// Propuestas para los logros de una experiencia guardada.
  Future<List<AchievementSuggestion>> suggest(String experienceId);
}

class SupabaseAchievementRewriter implements AchievementRewriter {
  SupabaseAchievementRewriter(this._functions);

  final FunctionsClient _functions;

  @override
  Future<List<AchievementSuggestion>> suggest(String experienceId) async {
    try {
      final response = await invokeAi(
        _functions,
        'rewrite-achievements',
        body: {'experience_id': experienceId},
      );
      final data = (response.data as Map).cast<String, dynamic>();
      return [
        for (final item in data['suggestions'] as List? ?? const [])
          AchievementSuggestion.fromJson((item as Map).cast<String, dynamic>()),
      ];
    } on FunctionException catch (error) {
      debugPrint('rewrite-achievements ${error.status}: ${error.details}');
      if (isDailyLimit(error)) {
        throw const RewriteException(RewriteFailure.dailyLimit);
      }
      throw RewriteException(switch (error.status) {
        429 => RewriteFailure.rateLimited,
        503 => RewriteFailure.busy,
        _ => RewriteFailure.other,
      });
    }
  }
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
AchievementRewriter? achievementRewriter(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseAchievementRewriter(Supabase.instance.client.functions);
}

/// Huecos entre corchetes que la persona debe completar («[X %]»).
final placeholderPattern = RegExp(r'\[[^\]]+\]');

/// Aplica a [achievements] los textos elegidos: sustituye por índice y añade
/// los nuevos al final.
List<String> applySuggestions(
  List<String> achievements,
  List<({int? index, String text})> chosen,
) {
  final result = [...achievements];
  for (final item in chosen) {
    final text = item.text.trim();
    if (text.isEmpty) continue;
    final index = item.index;
    if (index != null && index >= 0 && index < result.length) {
      result[index] = text;
    } else {
      result.add(text);
    }
  }
  return result;
}
