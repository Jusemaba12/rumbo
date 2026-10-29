import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';
import '../domain/application_draft.dart';

part 'resume_tailor.g.dart';

enum TailorFailure { emptyProfile, rateLimited, dailyLimit, busy, other }

class TailorException implements Exception {
  const TailorException(this.reason);

  final TailorFailure reason;

  @override
  String toString() => 'TailorException($reason)';
}

/// Adapta la HV a una oferta guardada y escribe la carta, sin guardar nada.
abstract interface class ResumeTailor {
  Future<ApplicationDraft> tailor(String jobId);
}

class SupabaseResumeTailor implements ResumeTailor {
  SupabaseResumeTailor(this._functions);

  final FunctionsClient _functions;

  @override
  Future<ApplicationDraft> tailor(String jobId) async {
    try {
      final response = await invokeAi(
        _functions,
        'tailor-resume',
        body: {'job_id': jobId},
      );
      return applicationDraftFromJson(
        jobId,
        (response.data as Map).cast<String, dynamic>(),
      );
    } on FunctionException catch (error) {
      debugPrint('tailor-resume ${error.status}: ${error.details}');
      final code = error.details is Map
          ? (error.details as Map)['error']
          : null;
      if (isDailyLimit(error)) {
        throw const TailorException(TailorFailure.dailyLimit);
      }
      throw TailorException(switch ((error.status, code)) {
        (422, 'empty_profile') => TailorFailure.emptyProfile,
        (429, _) => TailorFailure.rateLimited,
        (503, _) => TailorFailure.busy,
        _ => TailorFailure.other,
      });
    }
  }
}

/// Convierte la respuesta de `tailor-resume`.
ApplicationDraft applicationDraftFromJson(
  String jobId,
  Map<String, dynamic> json,
) {
  final validation = json['validation'] as Map<String, dynamic>? ?? const {};
  return ApplicationDraft(
    jobId: jobId,
    language: json['language'] == 'en' ? ResumeLanguage.en : ResumeLanguage.es,
    resume: TailoredResume.fromJson(json['resume'] as Map<String, dynamic>),
    coverLetter: json['cover_letter'] as String? ?? '',
    changes: [
      for (final change in json['changes'] as List? ?? const [])
        ResumeChange.fromJson(change as Map<String, dynamic>),
    ],
    keywords: [...(json['keywords'] as List? ?? const []).cast<String>()],
    rejected: [...(validation['rejected'] as List? ?? const []).cast<String>()],
  );
}

/// Nulo en modo local: adaptar necesita el servidor.
@Riverpod(keepAlive: true)
ResumeTailor? resumeTailor(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseResumeTailor(Supabase.instance.client.functions);
}
