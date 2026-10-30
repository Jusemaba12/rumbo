import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/mappers/job_row_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseJobsRepository implements JobsRepository {
  SupabaseJobsRepository(this._client);

  static const String _tag = 'SupabaseJobsRepository';

  final SupabaseClient _client;

  @override
  Future<Result<List<SavedJob>>> list() => guard(
    tag: _tag,
    run: () async {
      final List<Map<String, dynamic>> rows = await _client
          .from('jobs')
          .select('*, job_matches(*)')
          .order('created_at', ascending: false);
      return rows.map(savedJobFromRow).toList();
    },
  );

  @override
  Future<Result<void>> save(SavedJob saved) => guard(
    tag: _tag,
    run: () async {
      final Map<String, dynamic> inserted = await _client
          .from('jobs')
          .insert(jobToRow(saved.job))
          .select('id')
          .single();
      final JobMatch? match = saved.match;
      if (match != null) {
        await _client
            .from('job_matches')
            .insert(matchToRow(match, jobId: inserted['id'] as String));
      }
    },
  );

  @override
  Future<Result<void>> delete(String jobId) => guard(
    tag: _tag,
    run: () => _client.from('jobs').delete().eq('id', jobId),
  );

  @override
  Future<Result<void>> keepSuggestion(String jobId) =>
      _update(jobId: jobId, values: <String, dynamic>{'discovered': false});

  @override
  Future<Result<void>> dismissSuggestion(String jobId) =>
      _update(jobId: jobId, values: <String, dynamic>{'dismissed': true});

  @override
  Future<Result<void>> restoreSuggestion(String jobId) =>
      _update(jobId: jobId, values: <String, dynamic>{'dismissed': false});

  @override
  Future<Result<void>> updateContact(Job job) =>
      _update(jobId: job.id, values: contactToRow(job));

  @override
  Future<Result<void>> complete(SavedJob saved) => guard(
    tag: _tag,
    run: () async {
      final Job job = saved.job;
      await _client.from('jobs').update(completionToRow(job)).eq('id', job.id);
      final JobMatch? match = saved.match;
      if (match != null) {
        await _client
            .from('job_matches')
            .upsert(matchToRow(match, jobId: job.id));
      }
    },
  );

  Future<Result<void>> _update({
    required String jobId,
    required Map<String, dynamic> values,
  }) => guard(
    tag: _tag,
    run: () => _client.from('jobs').update(values).eq('id', jobId),
  );
}
