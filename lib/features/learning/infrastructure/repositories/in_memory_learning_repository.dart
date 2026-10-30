import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_repository.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:uuid/uuid.dart';

/// Modo local y tests.
class InMemoryLearningRepository implements LearningRepository {
  static const Uuid _uuid = Uuid();
  final List<LearningTopic> items = <LearningTopic>[];

  @override
  Future<Result<List<LearningTopic>>> list() async =>
      Ok<List<LearningTopic>>(<LearningTopic>[...items]);

  @override
  Future<Result<void>> add(String topic, {int demand = 0}) async {
    items.add(
      LearningTopic(id: _uuid.v4(), topic: topic.trim(), demand: demand),
    );
    return ok;
  }

  @override
  Future<Result<void>> setStatus({
    required String id,
    required LearningStatus status,
  }) async {
    final int index = items.indexWhere((LearningTopic t) => t.id == id);
    if (index != -1) items[index] = items[index].copyWith(status: status);
    return ok;
  }

  @override
  Future<Result<void>> delete(String id) async {
    items.removeWhere((LearningTopic t) => t.id == id);
    return ok;
  }
}
