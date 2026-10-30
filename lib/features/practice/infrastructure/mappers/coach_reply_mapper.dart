import 'package:rumbo/features/practice/domain/entities/practice.dart';

List<String> _strings(Object? value) => <String>[
  ...(value as List<dynamic>? ?? const <dynamic>[]).whereType<String>(),
];

CoachReply coachReplyFromJson(Map<String, dynamic> json) {
  final Map<String, dynamic>? feedback =
      json['feedback'] as Map<String, dynamic>?;
  final Map<String, dynamic>? summary =
      json['summary'] as Map<String, dynamic>?;
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
