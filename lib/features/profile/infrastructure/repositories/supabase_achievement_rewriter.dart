import 'package:rumbo/features/profile/domain/entities/achievement_suggestion.dart';
import 'package:rumbo/features/profile/domain/repositories/achievement_rewriter.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Función `rewrite-achievements`.
class SupabaseAchievementRewriter implements AchievementRewriter {
  SupabaseAchievementRewriter(this._functions);

  static const String _tag = 'SupabaseAchievementRewriter';

  final FunctionsClient _functions;

  @override
  Future<Result<List<AchievementSuggestion>>> suggest(String experienceId) =>
      guard(
        tag: _tag,
        run: () async {
          final Map<String, dynamic> data = await invokeAiJson(
            functions: _functions,
            name: 'rewrite-achievements',
            body: <String, String>{'experience_id': experienceId},
          );
          return <AchievementSuggestion>[
            for (final dynamic item
                in data['suggestions'] as List<dynamic>? ?? const <dynamic>[])
              AchievementSuggestion.fromJson(
                (item as Map<dynamic, dynamic>).cast<String, dynamic>(),
              ),
          ];
        },
      );
}
