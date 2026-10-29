import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';
import '../domain/job.dart';

part 'job_analyzer.g.dart';

enum JobAnalysisFailure { noDescription, rateLimited, dailyLimit, busy, other }

class JobAnalysisException implements Exception {
  const JobAnalysisException(this.reason);

  final JobAnalysisFailure reason;

  @override
  String toString() => 'JobAnalysisException($reason)';
}

/// Analiza una oferta con IA y la compara con el perfil, sin guardar nada.
abstract interface class JobAnalyzer {
  Future<SavedJob> analyze({String? url, String? text});
}

class SupabaseJobAnalyzer implements JobAnalyzer {
  SupabaseJobAnalyzer(this._functions);

  final FunctionsClient _functions;

  @override
  Future<SavedJob> analyze({String? url, String? text}) async {
    try {
      final response = await invokeAi(
        _functions,
        'analyze-job',
        body: {'url': url, 'text': text},
      );
      return jobAnalysisFromJson(
        (response.data as Map).cast<String, dynamic>(),
      );
    } on FunctionException catch (error) {
      debugPrint('analyze-job ${error.status}: ${error.details}');
      final code = error.details is Map
          ? (error.details as Map)['error']
          : null;
      if (isDailyLimit(error)) {
        throw const JobAnalysisException(JobAnalysisFailure.dailyLimit);
      }
      throw JobAnalysisException(switch ((error.status, code)) {
        (422, 'no_description') => JobAnalysisFailure.noDescription,
        (429, _) => JobAnalysisFailure.rateLimited,
        (503, _) => JobAnalysisFailure.busy,
        _ => JobAnalysisFailure.other,
      });
    }
  }
}

/// Convierte la respuesta de `analyze-job` en una oferta sin guardar.
SavedJob jobAnalysisFromJson(Map<String, dynamic> json) {
  final jobJson = json['job'] as Map<String, dynamic>;
  final job = Job.fromJson(jobJson);
  return SavedJob(
    job: job.copyWith(source: job.url == null ? 'manual' : 'link'),
    match: JobMatch.fromJson(json['match'] as Map<String, dynamic>),
  );
}

/// Nulo en modo local: analizar necesita el servidor.
@Riverpod(keepAlive: true)
JobAnalyzer? jobAnalyzer(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseJobAnalyzer(Supabase.instance.client.functions);
}
