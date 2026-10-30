import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_repository.dart';
import 'package:rumbo/features/learning/domain/services/learning_candidates.dart';
import 'package:rumbo/features/learning/infrastructure/di/learning_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_learning_topics_use_case.g.dart';

/// Temas del plan, en orden (ver [sortTopics]).
class GetLearningTopicsUseCase {
  const GetLearningTopicsUseCase({required this._repository});

  final LearningRepository _repository;

  Future<Result<List<LearningTopic>>> call() async =>
      (await _repository.list()).map(sortTopics);
}

@Riverpod(keepAlive: true)
GetLearningTopicsUseCase getLearningTopicsUseCase(Ref ref) =>
    GetLearningTopicsUseCase(repository: ref.watch(learningRepositoryProvider));
