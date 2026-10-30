import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';
import 'package:rumbo/features/answers/domain/repositories/answers_repository.dart';
import 'package:rumbo/features/answers/infrastructure/di/answers_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_answers_use_case.g.dart';

/// Respuestas guardadas, las editadas más recientemente primero.
class GetAnswersUseCase {
  const GetAnswersUseCase({required this._repository});

  final AnswersRepository _repository;

  Future<Result<List<SavedAnswer>>> call() => _repository.list();
}

@Riverpod(keepAlive: true)
GetAnswersUseCase getAnswersUseCase(Ref ref) =>
    GetAnswersUseCase(repository: ref.watch(answersRepositoryProvider));
