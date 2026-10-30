import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_repository.dart';
import 'package:rumbo/features/learning/infrastructure/di/learning_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'add_learning_topic_use_case.g.dart';

/// Añade un tema al plan con lo que lo piden las ofertas.
class AddLearningTopicUseCase {
  const AddLearningTopicUseCase({required this._repository});

  final LearningRepository _repository;

  Future<Result<void>> call(LearningCandidate candidate) =>
      _repository.add(candidate.topic, demand: candidate.demand);
}

@Riverpod(keepAlive: true)
AddLearningTopicUseCase addLearningTopicUseCase(Ref ref) =>
    AddLearningTopicUseCase(repository: ref.watch(learningRepositoryProvider));
