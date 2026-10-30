import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_planner.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Función `learning-plan`.
class SupabaseLearningPlanner implements LearningPlanner {
  SupabaseLearningPlanner(this._functions);

  static const String _tag = 'SupabaseLearningPlanner';

  final FunctionsClient _functions;

  @override
  Future<Result<LearningPlan>> generate(String topicId) => guard(
    tag: _tag,
    run: () async => LearningPlan.fromJson(
      await invokeAiJson(
        functions: _functions,
        name: 'learning-plan',
        body: <String, String>{'topic_id': topicId},
      ),
    ),
  );
}
