import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/answers/domain/repositories/answers_repository.dart';
import 'package:rumbo/features/answers/infrastructure/di/answers_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_answer_use_case.g.dart';

/// Borra una respuesta del banco.
class DeleteAnswerUseCase {
  const DeleteAnswerUseCase({required this._repository});

  final AnswersRepository _repository;

  Future<Result<void>> call(String id) => _repository.delete(id);
}

@Riverpod(keepAlive: true)
DeleteAnswerUseCase deleteAnswerUseCase(Ref ref) =>
    DeleteAnswerUseCase(repository: ref.watch(answersRepositoryProvider));
