import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/practice/domain/entities/practice.dart';
import 'package:rumbo/features/practice/domain/repositories/interview_coach.dart';
import 'package:rumbo/features/practice/infrastructure/di/practice_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'next_practice_turn_use_case.g.dart';

/// Evalúa la última respuesta del simulador y hace la siguiente pregunta.
class NextPracticeTurnUseCase {
  const NextPracticeTurnUseCase({required this._coach});

  final InterviewCoach? _coach;

  /// Falso en modo local, donde no hay IA.
  bool get isAvailable => _coach != null;

  Future<Result<CoachReply>> call({
    required String jobId,
    required PracticeMode mode,
    required PracticeLanguage language,
    required int totalQuestions,
    required List<PracticeTurn> turns,
  }) async {
    final InterviewCoach? coach = _coach;
    if (coach == null) {
      return const Err<CoachReply>(BackendUnavailableFailure());
    }
    return coach.next(
      jobId: jobId,
      mode: mode,
      language: language,
      totalQuestions: totalQuestions,
      turns: turns,
    );
  }
}

@Riverpod(keepAlive: true)
NextPracticeTurnUseCase nextPracticeTurnUseCase(Ref ref) =>
    NextPracticeTurnUseCase(coach: ref.watch(interviewCoachProvider));
