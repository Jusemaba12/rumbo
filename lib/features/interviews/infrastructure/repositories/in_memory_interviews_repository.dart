import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/domain/repositories/interviews_repository.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:uuid/uuid.dart';

class InMemoryInterviewsRepository implements InterviewsRepository {
  static const Uuid _uuid = Uuid();
  final List<Interview> _items = <Interview>[];

  @override
  Future<Result<List<Interview>>> list() async => Ok<List<Interview>>(
    <Interview>[..._items]..sort(
      (Interview a, Interview b) => a.scheduledAt.compareTo(b.scheduledAt),
    ),
  );

  @override
  Future<Result<void>> save(Interview interview) async {
    final Interview saved = interview.id.isEmpty
        ? interview.copyWith(id: _uuid.v4())
        : interview;
    _items
      ..removeWhere((Interview i) => i.id == saved.id)
      ..add(saved);
    return ok;
  }

  @override
  Future<Result<void>> delete(String id) async {
    _items.removeWhere((Interview i) => i.id == id);
    return ok;
  }
}
