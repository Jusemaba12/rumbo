import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_repository.dart';
import 'package:rumbo/features/learning/infrastructure/di/learning_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'set_learning_status_use_case.g.dart';

/// Cambia el estado de un tema (pendiente, aprendiendo, dominado).
class SetLearningStatusUseCase {
  const SetLearningStatusUseCase({required this._repository});

  final LearningRepository _repository;

  Future<Result<void>> call({
    required String id,
    required LearningStatus status,
  }) => _repository.setStatus(id: id, status: status);
}

@Riverpod(keepAlive: true)
SetLearningStatusUseCase setLearningStatusUseCase(Ref ref) =>
    SetLearningStatusUseCase(repository: ref.watch(learningRepositoryProvider));
