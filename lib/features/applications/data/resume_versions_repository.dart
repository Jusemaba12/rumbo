import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/env.dart';
import '../domain/application_draft.dart';

part 'resume_versions_repository.g.dart';

/// Versiones de la HV adaptadas a cada oferta.
abstract interface class ResumeVersionsRepository {
  /// Guarda la versión y devuelve su id.
  Future<String> save(ApplicationDraft draft);

  /// Última HV adaptada guardada para la oferta; nula si no hay.
  Future<ApplicationDraft?> latestForJob(String jobId);
}

class SupabaseResumeVersionsRepository implements ResumeVersionsRepository {
  SupabaseResumeVersionsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<String> save(ApplicationDraft draft) async {
    final row = await _client
        .from('resume_versions')
        .insert(resumeVersionToRow(draft))
        .select('id')
        .single();
    return row['id'] as String;
  }

  @override
  Future<ApplicationDraft?> latestForJob(String jobId) async {
    final row = await _client
        .from('resume_versions')
        .select('job_id, content, changes')
        .eq('job_id', jobId)
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();
    return row == null ? null : resumeVersionFromRow(row);
  }
}

class InMemoryResumeVersionsRepository implements ResumeVersionsRepository {
  final saved = <ApplicationDraft>[];

  @override
  Future<String> save(ApplicationDraft draft) async {
    saved.add(draft);
    return 'version-${saved.length}';
  }

  @override
  Future<ApplicationDraft?> latestForJob(String jobId) async =>
      saved.lastWhereOrNull((draft) => draft.jobId == jobId);
}

/// Lo contrario de [resumeVersionToRow].
ApplicationDraft resumeVersionFromRow(Map<String, dynamic> row) {
  final content = (row['content'] as Map).cast<String, dynamic>();
  return ApplicationDraft(
    jobId: row['job_id'] as String,
    language:
        ResumeLanguage.values.asNameMap()[content['language']] ??
        ResumeLanguage.es,
    resume: TailoredResume.fromJson(content),
    coverLetter: content['cover_letter'] as String? ?? '',
    changes: [
      for (final change in row['changes'] as List? ?? const [])
        ResumeChange.fromJson((change as Map).cast<String, dynamic>()),
    ],
  );
}

Map<String, dynamic> resumeVersionToRow(ApplicationDraft draft) => {
  'job_id': draft.jobId,
  'content': {
    ...draft.resume.toJson(),
    'language': draft.language.name,
    'cover_letter': draft.coverLetter,
  },
  'changes': [for (final change in draft.changes) change.toJson()],
};

@Riverpod(keepAlive: true)
ResumeVersionsRepository resumeVersionsRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryResumeVersionsRepository();
  return SupabaseResumeVersionsRepository(Supabase.instance.client);
}
