import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';
import 'package:rumbo/features/answers/domain/repositories/answers_repository.dart';
import 'package:rumbo/features/answers/infrastructure/mappers/saved_answer_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAnswersRepository implements AnswersRepository {
  SupabaseAnswersRepository(this._client);

  static const String _tag = 'SupabaseAnswersRepository';

  final SupabaseClient _client;

  @override
  Future<Result<List<SavedAnswer>>> list() => guard(
    tag: _tag,
    run: () async {
      final PostgrestList rows = await _client
          .from('answer_bank')
          .select()
          .order('updated_at', ascending: false);
      return rows.map(savedAnswerFromRow).toList();
    },
  );

  @override
  Future<Result<void>> save(SavedAnswer answer) => guard(
    tag: _tag,
    run: () {
      final Map<String, String> row = savedAnswerToRow(answer);
      return answer.id.isEmpty
          ? _client.from('answer_bank').insert(row)
          : _client.from('answer_bank').update(row).eq('id', answer.id);
    },
  );

  @override
  Future<Result<void>> delete(String id) => guard(
    tag: _tag,
    run: () => _client.from('answer_bank').delete().eq('id', id),
  );
}
