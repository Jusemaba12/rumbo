import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/domain/repositories/interviews_repository.dart';
import 'package:rumbo/features/interviews/infrastructure/mappers/interview_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInterviewsRepository implements InterviewsRepository {
  SupabaseInterviewsRepository(this._client);

  static const String _tag = 'SupabaseInterviewsRepository';

  final SupabaseClient _client;

  @override
  Future<Result<List<Interview>>> list() => guard(
    tag: _tag,
    run: () async {
      final PostgrestList rows = await _client
          .from('interviews')
          .select()
          .order('scheduled_at', ascending: true);
      return rows.map(interviewFromRow).toList();
    },
  );

  @override
  Future<Result<void>> save(Interview interview) => guard(
    tag: _tag,
    run: () => interview.id.isEmpty
        ? _client.from('interviews').insert(interviewToRow(interview))
        : _client
              .from('interviews')
              .update(interviewToRow(interview))
              .eq('id', interview.id),
  );

  @override
  Future<Result<void>> delete(String id) => guard(
    tag: _tag,
    run: () => _client.from('interviews').delete().eq('id', id),
  );
}
