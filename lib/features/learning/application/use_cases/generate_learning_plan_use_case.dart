import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_planner.dart';
import 'package:rumbo/features/learning/infrastructure/di/learning_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'generate_learning_plan_use_case.g.dart';

/// Genera con IA el plan de un tema; el servidor lo guarda.
class GenerateLearningPlanUseCase {
  const GenerateLearningPlanUseCase({required this._planner});

  final LearningPlanner? _planner;

  /// Falso en modo local, donde no hay IA.
  bool get isAvailable => _planner != null;

  Future<Result<LearningPlan>> call(String topicId) async =>
      await _planner?.generate(topicId) ??
      const Err<LearningPlan>(BackendUnavailableFailure());
}

@Riverpod(keepAlive: true)
GenerateLearningPlanUseCase generateLearningPlanUseCase(Ref ref) =>
    GenerateLearningPlanUseCase(planner: ref.watch(learningPlannerProvider));
