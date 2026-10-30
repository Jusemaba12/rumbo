import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Genera con IA el plan de un tema y lo guarda en el servidor.
abstract interface class LearningPlanner {
  Future<Result<LearningPlan>> generate(String topicId);
}
