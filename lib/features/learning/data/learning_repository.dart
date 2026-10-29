import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';
import '../domain/learning.dart';

part 'learning_repository.g.dart';

abstract interface class LearningRepository {
  Future<List<LearningTopic>> list();
  Future<void> add(String topic, {int demand = 0});
  Future<void> setStatus(String id, LearningStatus status);
  Future<void> delete(String id);
}

LearningTopic learningTopicFromRow(Map<String, dynamic> row) => LearningTopic(
  id: row['id'] as String,
  topic: row['topic'] as String,
  status:
      LearningStatus.values.asNameMap()[row['status']] ??
      LearningStatus.pending,
  demand: row['demand'] as int? ?? 0,
  plan: row['plan'] is Map
      ? LearningPlan.fromJson((row['plan'] as Map).cast<String, dynamic>())
      : null,
);

class SupabaseLearningRepository implements LearningRepository {
  SupabaseLearningRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<LearningTopic>> list() async {
    final rows = await _client.from('learning_topics').select();
    return rows.map(learningTopicFromRow).toList();
  }

  @override
  Future<void> add(String topic, {int demand = 0}) => _client
      .from('learning_topics')
      .insert({'topic': topic.trim(), 'demand': demand});

  @override
  Future<void> setStatus(String id, LearningStatus status) => _client
      .from('learning_topics')
      .update({
        'status': status.name,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      })
      .eq('id', id);

  @override
  Future<void> delete(String id) =>
      _client.from('learning_topics').delete().eq('id', id);
}

/// Modo local y tests.
class InMemoryLearningRepository implements LearningRepository {
  static const _uuid = Uuid();
  final items = <LearningTopic>[];

  @override
  Future<List<LearningTopic>> list() async => [...items];

  @override
  Future<void> add(String topic, {int demand = 0}) async => items.add(
    LearningTopic(id: _uuid.v4(), topic: topic.trim(), demand: demand),
  );

  @override
  Future<void> setStatus(String id, LearningStatus status) async {
    final index = items.indexWhere((t) => t.id == id);
    if (index != -1) items[index] = items[index].copyWith(status: status);
  }

  @override
  Future<void> delete(String id) async => items.removeWhere((t) => t.id == id);
}

@Riverpod(keepAlive: true)
LearningRepository learningRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryLearningRepository();
  return SupabaseLearningRepository(Supabase.instance.client);
}

enum LearningPlanFailure { dailyLimit, rateLimited, busy, other }

class LearningPlanException implements Exception {
  const LearningPlanException(this.reason);

  final LearningPlanFailure reason;
}

/// Genera con IA el plan de un tema y lo guarda en el servidor.
abstract interface class LearningPlanner {
  Future<LearningPlan> generate(String topicId);
}

class SupabaseLearningPlanner implements LearningPlanner {
  SupabaseLearningPlanner(this._functions);

  final FunctionsClient _functions;

  @override
  Future<LearningPlan> generate(String topicId) async {
    try {
      final response = await invokeAi(
        _functions,
        'learning-plan',
        body: {'topic_id': topicId},
      );
      return LearningPlan.fromJson(
        (response.data as Map).cast<String, dynamic>(),
      );
    } on FunctionException catch (error) {
      debugPrint('learning-plan ${error.status}: ${error.details}');
      if (isDailyLimit(error)) {
        throw const LearningPlanException(LearningPlanFailure.dailyLimit);
      }
      throw LearningPlanException(switch (error.status) {
        429 => LearningPlanFailure.rateLimited,
        503 => LearningPlanFailure.busy,
        _ => LearningPlanFailure.other,
      });
    }
  }
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
LearningPlanner? learningPlanner(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseLearningPlanner(Supabase.instance.client.functions);
}
