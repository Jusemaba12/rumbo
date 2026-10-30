import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';
import 'package:rumbo/features/answers/domain/repositories/answers_repository.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:uuid/uuid.dart';

class InMemoryAnswersRepository implements AnswersRepository {
  static const Uuid _uuid = Uuid();
  final List<SavedAnswer> _items = <SavedAnswer>[];
  int _tick = 0;

  @override
  Future<Result<List<SavedAnswer>>> list() async => Ok<List<SavedAnswer>>(
    <SavedAnswer>[..._items]..sort(
      (SavedAnswer a, SavedAnswer b) => b.updatedAt!.compareTo(a.updatedAt!),
    ),
  );

  @override
  Future<Result<void>> save(SavedAnswer answer) async {
    final SavedAnswer saved = answer.copyWith(
      id: answer.id.isEmpty ? _uuid.v4() : answer.id,
      // Orden estable en tests aunque se guarde en el mismo instante.
      updatedAt: DateTime(2000).add(Duration(seconds: ++_tick)),
    );
    _items
      ..removeWhere((SavedAnswer a) => a.id == saved.id)
      ..add(saved);
    return ok;
  }

  @override
  Future<Result<void>> delete(String id) async {
    _items.removeWhere((SavedAnswer a) => a.id == id);
    return ok;
  }
}
