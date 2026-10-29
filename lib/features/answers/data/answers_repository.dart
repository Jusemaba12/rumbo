import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/config/env.dart';
import '../domain/saved_answer.dart';

part 'answers_repository.g.dart';

abstract interface class AnswersRepository {
  /// Las editadas más recientemente primero.
  Future<List<SavedAnswer>> list();
  Future<void> save(SavedAnswer answer);
  Future<void> delete(String id);
}

class SupabaseAnswersRepository implements AnswersRepository {
  SupabaseAnswersRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<SavedAnswer>> list() async {
    final rows = await _client
        .from('answer_bank')
        .select()
        .order('updated_at', ascending: false);
    return rows
        .map(
          (row) => SavedAnswer(
            id: row['id'] as String,
            question: row['question'] as String,
            answer: row['answer'] as String? ?? '',
            updatedAt: DateTime.parse(row['updated_at'] as String).toLocal(),
          ),
        )
        .toList();
  }

  @override
  Future<void> save(SavedAnswer answer) {
    final row = {'question': answer.question, 'answer': answer.answer};
    return answer.id.isEmpty
        ? _client.from('answer_bank').insert(row)
        : _client.from('answer_bank').update(row).eq('id', answer.id);
  }

  @override
  Future<void> delete(String id) =>
      _client.from('answer_bank').delete().eq('id', id);
}

class InMemoryAnswersRepository implements AnswersRepository {
  static const _uuid = Uuid();
  final _items = <SavedAnswer>[];
  var _tick = 0;

  @override
  Future<List<SavedAnswer>> list() async =>
      [..._items]..sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

  @override
  Future<void> save(SavedAnswer answer) async {
    final saved = answer.copyWith(
      id: answer.id.isEmpty ? _uuid.v4() : answer.id,
      // Orden estable en tests aunque se guarde en el mismo instante.
      updatedAt: DateTime(2000).add(Duration(seconds: ++_tick)),
    );
    _items
      ..removeWhere((a) => a.id == saved.id)
      ..add(saved);
  }

  @override
  Future<void> delete(String id) async => _items.removeWhere((a) => a.id == id);
}

@Riverpod(keepAlive: true)
AnswersRepository answersRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryAnswersRepository();
  return SupabaseAnswersRepository(Supabase.instance.client);
}
