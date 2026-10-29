import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/data/auth_repository.dart';
import '../data/answers_repository.dart';
import '../domain/saved_answer.dart';

part 'answers_controller.g.dart';

@Riverpod(keepAlive: true)
class AnswersController extends _$AnswersController {
  AnswersRepository get _repository => ref.read(answersRepositoryProvider);

  @override
  Future<List<SavedAnswer>> build() {
    ref.watch(sessionChangesProvider);
    return ref.watch(answersRepositoryProvider).list();
  }

  Future<void> save(SavedAnswer answer) async {
    await _repository.save(answer);
    state = AsyncData(await _repository.list());
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
    state = AsyncData(await _repository.list());
  }
}
