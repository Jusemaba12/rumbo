import 'package:rumbo/features/practice/domain/entities/practice.dart';
import 'package:rumbo/features/practice/domain/repositories/interview_coach.dart';
import 'package:rumbo/features/practice/infrastructure/mappers/coach_reply_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Función `interview-coach`; sin estado, recibe el historial en cada turno.
class SupabaseInterviewCoach implements InterviewCoach {
  SupabaseInterviewCoach(this._functions);

  static const String _tag = 'SupabaseInterviewCoach';

  final FunctionsClient _functions;

  @override
  Future<Result<CoachReply>> next({
    required String jobId,
    required PracticeMode mode,
    required PracticeLanguage language,
    required int totalQuestions,
    required List<PracticeTurn> turns,
  }) => guard(
    tag: _tag,
    run: () async => coachReplyFromJson(
      await invokeAiJson(
        functions: _functions,
        name: 'interview-coach',
        body: <String, Object>{
          'job_id': jobId,
          'mode': mode.name,
          'language': language.name,
          'total_questions': totalQuestions,
          'turns': <Map<String, String>>[
            for (final PracticeTurn turn in turns)
              <String, String>{
                'question': turn.question,
                'answer': turn.answer,
              },
          ],
        },
      ),
    ),
  );
}
