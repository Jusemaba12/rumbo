import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/learning/domain/repositories/learning_repository.dart';
import 'package:rumbo/features/learning/infrastructure/di/learning_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_learning_topic_use_case.g.dart';

/// Quita un tema del plan.
class DeleteLearningTopicUseCase {
  const DeleteLearningTopicUseCase({required this._repository});

  final LearningRepository _repository;

  Future<Result<void>> call(String id) => _repository.delete(id);
}

@Riverpod(keepAlive: true)
DeleteLearningTopicUseCase deleteLearningTopicUseCase(Ref ref) =>
    DeleteLearningTopicUseCase(
      repository: ref.watch(learningRepositoryProvider),
    );
