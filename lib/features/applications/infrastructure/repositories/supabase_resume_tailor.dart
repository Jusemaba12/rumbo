import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/failures/application_failures.dart';
import 'package:rumbo/features/applications/domain/repositories/resume_tailor.dart';
import 'package:rumbo/features/applications/infrastructure/mappers/application_draft_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Función `tailor-resume`.
class SupabaseResumeTailor implements ResumeTailor {
  SupabaseResumeTailor(this._functions);

  static const String _tag = 'SupabaseResumeTailor';

  final FunctionsClient _functions;

  @override
  Future<Result<ApplicationDraft>> tailor(String jobId) => guard(
    tag: _tag,
    run: () async {
      try {
        return applicationDraftFromJson(
          jobId: jobId,
          json: await invokeAiJson(
            functions: _functions,
            name: 'tailor-resume',
            body: <String, String>{'job_id': jobId},
          ),
        );
      } on FunctionException catch (error) {
        if (error.status == 422 &&
            functionErrorCode(error) == 'empty_profile') {
          throw const EmptyProfileFailure();
        }
        rethrow;
      }
    },
  );
}
