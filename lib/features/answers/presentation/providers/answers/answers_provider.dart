import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/answers/application/use_cases/delete_answer_use_case.dart';
import 'package:rumbo/features/answers/application/use_cases/get_answers_use_case.dart';
import 'package:rumbo/features/answers/application/use_cases/save_answer_use_case.dart';
import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'answers_provider.g.dart';

@Riverpod(keepAlive: true)
class AnswersController extends _$AnswersController {
  @override
  Future<List<SavedAnswer>> build() async {
    ref.watch(sessionChangesProvider);
    return (await ref.watch(getAnswersUseCaseProvider)()).getOrThrow();
  }

  Future<Result<void>> save(SavedAnswer answer) =>
      _thenReload(ref.read(saveAnswerUseCaseProvider)(answer));

  Future<Result<void>> delete(String id) =>
      _thenReload(ref.read(deleteAnswerUseCaseProvider)(id));

  Future<Result<void>> _thenReload(Future<Result<void>> action) async {
    final Result<void> result = await action;
    if (!result.isOk) return result;
    final Result<List<SavedAnswer>> answers = await ref.read(
      getAnswersUseCaseProvider,
    )();
    if (answers case Ok<List<SavedAnswer>>(:final List<SavedAnswer> value)) {
      state = AsyncData<List<SavedAnswer>>(value);
    }
    return result;
  }
}
