import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/mappers/application_mapper.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseApplicationsRepository implements ApplicationsRepository {
  SupabaseApplicationsRepository(this._client);

  static const String _tag = 'SupabaseApplicationsRepository';

  final SupabaseClient _client;

  @override
  Future<Result<List<ApplicationWithJob>>> list() => guard(
    tag: _tag,
    run: () async {
      final PostgrestList rows = await _client
          .from('applications')
          .select('*, jobs(*)')
          .order('updated_at', ascending: false);
      return <ApplicationWithJob>[
        for (final PostgrestMap row in rows)
          if (row['jobs'] is Map<String, dynamic>)
            ApplicationWithJob(
              application: applicationFromRow(row),
              job: Job.fromJson(row['jobs'] as Map<String, dynamic>),
            ),
      ];
    },
  );

  @override
  Future<Result<Application>> save(Application application) => guard(
    tag: _tag,
    run: () async {
      final Map<String, dynamic> row = applicationToRow(application);
      final PostgrestMap saved = application.id.isEmpty
          ? await _client.from('applications').insert(row).select().single()
          : await _client
                .from('applications')
                .update(row)
                .eq('id', application.id)
                .select()
                .single();
      return applicationFromRow(saved);
    },
  );

  @override
  Future<Result<void>> delete(String id) => guard(
    tag: _tag,
    run: () => _client.from('applications').delete().eq('id', id),
  );

  @override
  Future<Result<List<ApplicationEvent>>> events(String applicationId) => guard(
    tag: _tag,
    run: () async {
      final PostgrestList rows = await _client
          .from('application_events')
          .select()
          .eq('application_id', applicationId)
          .order('created_at', ascending: true);
      return rows.map(eventFromRow).toList();
    },
  );

  @override
  Future<Result<Map<String, List<ApplicationEvent>>>> allEvents() => guard(
    tag: _tag,
    run: () async {
      final PostgrestList rows = await _client
          .from('application_events')
          .select()
          .order('created_at', ascending: true);
      final Map<String, List<ApplicationEvent>> grouped =
          <String, List<ApplicationEvent>>{};
      for (final PostgrestMap row in rows) {
        (grouped[row['application_id'] as String] ??= <ApplicationEvent>[]).add(
          eventFromRow(row),
        );
      }
      return grouped;
    },
  );
}
