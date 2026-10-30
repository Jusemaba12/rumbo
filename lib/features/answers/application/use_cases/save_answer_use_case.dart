import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';
import 'package:rumbo/features/answers/domain/repositories/answers_repository.dart';
import 'package:rumbo/features/answers/infrastructure/di/answers_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_answer_use_case.g.dart';

/// Crea o actualiza una respuesta del banco.
class SaveAnswerUseCase {
  const SaveAnswerUseCase({required this._repository});

  final AnswersRepository _repository;

  Future<Result<void>> call(SavedAnswer answer) => _repository.save(answer);
}

@Riverpod(keepAlive: true)
SaveAnswerUseCase saveAnswerUseCase(Ref ref) =>
    SaveAnswerUseCase(repository: ref.watch(answersRepositoryProvider));
