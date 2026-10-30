import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Temas del plan de aprendizaje.
abstract interface class LearningRepository {
  Future<Result<List<LearningTopic>>> list();

  Future<Result<void>> add(String topic, {int demand = 0});

  Future<Result<void>> setStatus({
    required String id,
    required LearningStatus status,
  });

  Future<Result<void>> delete(String id);
}
