import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_repository.dart';
import 'package:rumbo/features/learning/infrastructure/mappers/learning_topic_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseLearningRepository implements LearningRepository {
  SupabaseLearningRepository(this._client);

  static const String _tag = 'SupabaseLearningRepository';

  final SupabaseClient _client;

  @override
  Future<Result<List<LearningTopic>>> list() => guard(
    tag: _tag,
    run: () async {
      final PostgrestList rows = await _client.from('learning_topics').select();
      return rows.map(learningTopicFromRow).toList();
    },
  );

  @override
  Future<Result<void>> add(String topic, {int demand = 0}) => guard(
    tag: _tag,
    run: () => _client.from('learning_topics').insert(<String, Object>{
      'topic': topic.trim(),
      'demand': demand,
    }),
  );

  @override
  Future<Result<void>> setStatus({
    required String id,
    required LearningStatus status,
  }) => guard(
    tag: _tag,
    run: () => _client
        .from('learning_topics')
        .update(<String, dynamic>{
          'status': status.name,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', id),
  );

  @override
  Future<Result<void>> delete(String id) => guard(
    tag: _tag,
    run: () => _client.from('learning_topics').delete().eq('id', id),
  );
}
