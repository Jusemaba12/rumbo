import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/config/env.dart';
import '../domain/interview.dart';

part 'interviews_repository.g.dart';

abstract interface class InterviewsRepository {
  /// Todas las entrevistas, por fecha.
  Future<List<Interview>> list();
  Future<void> save(Interview interview);
  Future<void> delete(String id);
}

class SupabaseInterviewsRepository implements InterviewsRepository {
  SupabaseInterviewsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Interview>> list() async {
    final rows = await _client
        .from('interviews')
        .select()
        .order('scheduled_at', ascending: true);
    return rows.map(interviewFromRow).toList();
  }

  @override
  Future<void> save(Interview interview) => interview.id.isEmpty
      ? _client.from('interviews').insert(interviewToRow(interview))
      : _client
            .from('interviews')
            .update(interviewToRow(interview))
            .eq('id', interview.id);

  @override
  Future<void> delete(String id) =>
      _client.from('interviews').delete().eq('id', id);
}

class InMemoryInterviewsRepository implements InterviewsRepository {
  static const _uuid = Uuid();
  final _items = <Interview>[];

  @override
  Future<List<Interview>> list() async =>
      [..._items]..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

  @override
  Future<void> save(Interview interview) async {
    final saved = interview.id.isEmpty
        ? interview.copyWith(id: _uuid.v4())
        : interview;
    _items
      ..removeWhere((i) => i.id == saved.id)
      ..add(saved);
  }

  @override
  Future<void> delete(String id) async => _items.removeWhere((i) => i.id == id);
}

Map<String, dynamic> interviewToRow(Interview interview) => {
  'application_id': interview.applicationId,
  'kind': interviewKindDb(interview.kind),
  'scheduled_at': interview.scheduledAt.toUtc().toIso8601String(),
  'duration_minutes': interview.durationMinutes,
  'location': interview.location,
  'notes': interview.notes,
  'outcome': interview.outcome.name,
};

Interview interviewFromRow(Map<String, dynamic> row) => Interview(
  id: row['id'] as String,
  applicationId: row['application_id'] as String,
  kind: interviewKindFromDb(row['kind'] as String),
  scheduledAt: DateTime.parse(row['scheduled_at'] as String).toLocal(),
  durationMinutes: row['duration_minutes'] as int? ?? 60,
  location: row['location'] as String? ?? '',
  notes: row['notes'] as String? ?? '',
  outcome:
      InterviewOutcome.values.asNameMap()[row['outcome']] ??
      InterviewOutcome.pending,
);

@Riverpod(keepAlive: true)
InterviewsRepository interviewsRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryInterviewsRepository();
  return SupabaseInterviewsRepository(Supabase.instance.client);
}
