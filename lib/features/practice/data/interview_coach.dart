import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';
import '../domain/practice.dart';

part 'interview_coach.g.dart';

enum CoachFailure { rateLimited, dailyLimit, busy, other }

class CoachException implements Exception {
  const CoachException(this.reason);

  final CoachFailure reason;

  @override
  String toString() => 'CoachException($reason)';
}

abstract interface class InterviewCoach {
  /// Evalúa la última respuesta de [turns] y hace la siguiente pregunta.
  Future<CoachReply> next({
    required String jobId,
    required PracticeMode mode,
    required PracticeLanguage language,
    required int totalQuestions,
    required List<PracticeTurn> turns,
  });
}

class SupabaseInterviewCoach implements InterviewCoach {
  SupabaseInterviewCoach(this._functions);

  final FunctionsClient _functions;

  @override
  Future<CoachReply> next({
    required String jobId,
    required PracticeMode mode,
    required PracticeLanguage language,
    required int totalQuestions,
    required List<PracticeTurn> turns,
  }) async {
    try {
      final response = await invokeAi(
        _functions,
        'interview-coach',
        body: {
          'job_id': jobId,
          'mode': mode.name,
          'language': language.name,
          'total_questions': totalQuestions,
          'turns': [
            for (final turn in turns)
              {'question': turn.question, 'answer': turn.answer},
          ],
        },
      );
      return coachReplyFromJson((response.data as Map).cast<String, dynamic>());
    } on FunctionException catch (error) {
      debugPrint('interview-coach ${error.status}: ${error.details}');
      if (isDailyLimit(error)) {
        throw const CoachException(CoachFailure.dailyLimit);
      }
      throw CoachException(switch (error.status) {
        429 => CoachFailure.rateLimited,
        503 => CoachFailure.busy,
        _ => CoachFailure.other,
      });
    }
  }
}

List<String> _strings(Object? value) => [
  ...(value as List? ?? const []).whereType<String>(),
];

CoachReply coachReplyFromJson(Map<String, dynamic> json) {
  final feedback = json['feedback'] as Map<String, dynamic>?;
  final summary = json['summary'] as Map<String, dynamic>?;
  return CoachReply(
    feedback: feedback == null
        ? null
        : AnswerFeedback(
            score: feedback['score'] as int? ?? 1,
            strengths: _strings(feedback['strengths']),
            improve: _strings(feedback['improve']),
            betterAnswer: feedback['better_answer'] as String? ?? '',
          ),
    nextQuestion: json['next_question'] as String?,
    summary: summary == null
        ? null
        : PracticeSummary(
            score: summary['score'] as int? ?? 1,
            overall: summary['overall'] as String? ?? '',
            strengths: _strings(summary['strengths']),
            improve: _strings(summary['improve']),
          ),
  );
}

/// Nulo en modo local: practicar necesita el servidor.
@Riverpod(keepAlive: true)
InterviewCoach? interviewCoach(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseInterviewCoach(Supabase.instance.client.functions);
}
