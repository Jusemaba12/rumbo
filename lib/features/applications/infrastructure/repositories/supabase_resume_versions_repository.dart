import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/repositories/resume_versions_repository.dart';
import 'package:rumbo/features/applications/infrastructure/mappers/application_draft_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseResumeVersionsRepository implements ResumeVersionsRepository {
  SupabaseResumeVersionsRepository(this._client);

  static const String _tag = 'SupabaseResumeVersionsRepository';

  final SupabaseClient _client;

  @override
  Future<Result<String>> save(ApplicationDraft draft) => guard(
    tag: _tag,
    run: () async {
      final PostgrestMap row = await _client
          .from('resume_versions')
          .insert(resumeVersionToRow(draft))
          .select('id')
          .single();
      return row['id'] as String;
    },
  );

  @override
  Future<Result<ApplicationDraft?>> latestForJob(String jobId) => guard(
    tag: _tag,
    run: () async {
      final PostgrestMap? row = await _client
          .from('resume_versions')
          .select('job_id, content, changes')
          .eq('job_id', jobId)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();
      return row == null ? null : resumeVersionFromRow(row);
    },
  );
}
