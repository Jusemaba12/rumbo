import 'package:freezed_annotation/freezed_annotation.dart';

part 'practice.freezed.dart';

enum PracticeMode { technical, behavioral, mixed }

enum PracticeLanguage { es, en }

@freezed
abstract class AnswerFeedback with _$AnswerFeedback {
  const factory AnswerFeedback({
    required int score,
    @Default(<String>[]) List<String> strengths,
    @Default(<String>[]) List<String> improve,
    @Default('') String betterAnswer,
  }) = _AnswerFeedback;
}

@freezed
abstract class PracticeSummary with _$PracticeSummary {
  const factory PracticeSummary({
    required int score,
    @Default('') String overall,
    @Default(<String>[]) List<String> strengths,
    @Default(<String>[]) List<String> improve,
  }) = _PracticeSummary;
}

/// Pregunta respondida, con la evaluación cuando llega.
@freezed
abstract class PracticeTurn with _$PracticeTurn {
  const factory PracticeTurn({
    required String question,
    required String answer,
    AnswerFeedback? feedback,
  }) = _PracticeTurn;
}

/// Respuesta del entrevistador a un turno.
@freezed
abstract class CoachReply with _$CoachReply {
  const factory CoachReply({
    AnswerFeedback? feedback,
    String? nextQuestion,
    PracticeSummary? summary,
  }) = _CoachReply;
}
