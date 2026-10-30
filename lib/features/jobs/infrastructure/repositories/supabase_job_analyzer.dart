import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/failures/job_failures.dart';
import 'package:rumbo/features/jobs/domain/repositories/job_analyzer.dart';
import 'package:rumbo/features/jobs/infrastructure/mappers/job_row_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Función `analyze-job`.
class SupabaseJobAnalyzer implements JobAnalyzer {
  SupabaseJobAnalyzer(this._functions);

  static const String _tag = 'SupabaseJobAnalyzer';

  final FunctionsClient _functions;

  @override
  Future<Result<SavedJob>> analyze({String? url, String? text}) => guard(
    tag: _tag,
    run: () async {
      try {
        return jobAnalysisFromJson(
          await invokeAiJson(
            functions: _functions,
            name: 'analyze-job',
            body: <String, String?>{'url': url, 'text': text},
          ),
        );
      } on FunctionException catch (error) {
        if (error.status == 422 &&
            functionErrorCode(error) == 'no_description') {
          throw const NoDescriptionFailure();
        }
        rethrow;
      }
    },
  );
}
