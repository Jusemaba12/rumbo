import 'package:rumbo/features/practice/domain/entities/practice.dart';
import 'package:rumbo/shared/domain/result.dart';

abstract interface class InterviewCoach {
  /// Evalúa la última respuesta de [turns] y hace la siguiente pregunta.
  Future<Result<CoachReply>> next({
    required String jobId,
    required PracticeMode mode,
    required PracticeLanguage language,
    required int totalQuestions,
    required List<PracticeTurn> turns,
  });
}
