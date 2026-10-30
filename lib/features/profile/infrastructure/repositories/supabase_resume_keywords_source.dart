import 'package:rumbo/features/profile/domain/entities/resume_keyword.dart';
import 'package:rumbo/features/profile/domain/failures/profile_failures.dart';
import 'package:rumbo/features/profile/domain/repositories/resume_keywords_source.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Tabla `resume_keywords` y función `resume-keywords`.
class SupabaseResumeKeywordsSource implements ResumeKeywordsSource {
  SupabaseResumeKeywordsSource(this._client);

  static const String _tag = 'SupabaseResumeKeywordsSource';

  final SupabaseClient _client;

  @override
  Future<Result<KeywordsResult?>> cached() => guard(
    tag: _tag,
    run: () async {
      final PostgrestMap? row = await _client
          .from('resume_keywords')
          .select('keywords, created_at')
          .maybeSingle();
      return row == null ? null : _resultFrom(row);
    },
  );

  @override
  Future<Result<KeywordsResult>> fetch({bool force = false}) => guard(
    tag: _tag,
    run: () async {
      try {
        return _resultFrom(
          await invokeAiJson(
            functions: _client.functions,
            name: 'resume-keywords',
            body: <String, bool>{'force': force},
          ),
        );
      } on FunctionException catch (error) {
        if (error.status == 422 && functionErrorCode(error) == 'no_roles') {
          throw const NoRolesFailure();
        }
        rethrow;
      }
    },
  );

  KeywordsResult _resultFrom(Map<String, dynamic> data) => KeywordsResult(
    keywords: <ResumeKeyword>[
      for (final dynamic item
          in data['keywords'] as List<dynamic>? ?? const <dynamic>[])
        ResumeKeyword.fromJson(
          (item as Map<dynamic, dynamic>).cast<String, dynamic>(),
        ),
    ],
    updatedAt: DateTime.tryParse(data['created_at'] as String? ?? ''),
  );
}
