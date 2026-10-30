import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/features/practice/domain/entities/practice.dart';
import 'package:rumbo/features/practice/domain/repositories/interview_coach.dart';
import 'package:rumbo/features/practice/infrastructure/di/practice_providers.dart';
import 'package:rumbo/features/practice/infrastructure/mappers/coach_reply_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';

class _FakeCoach implements InterviewCoach {
  final List<List<PracticeTurn>> calls = <List<PracticeTurn>>[];
  PracticeMode? mode;
  int? total;

  @override
  Future<Result<CoachReply>> next({
    required String jobId,
    required PracticeMode mode,
    required PracticeLanguage language,
    required int totalQuestions,
    required List<PracticeTurn> turns,
  }) async {
    calls.add(<PracticeTurn>[...turns]);
    this.mode = mode;
    total = totalQuestions;
    final int answered = turns.length;
    return Ok<CoachReply>(
      CoachReply(
        feedback: answered == 0
            ? null
            : AnswerFeedback(
                score: 4,
                strengths: <String>['Mencionas Riverpod'],
                improve: <String>['Añade una cifra'],
                betterAnswer: 'Respuesta mejorada $answered',
              ),
        nextQuestion: answered < totalQuestions
            ? 'Pregunta ${answered + 1}'
            : null,
        summary: answered < totalQuestions
            ? null
            : const PracticeSummary(score: 4, overall: 'Buen nivel técnico.'),
      ),
    );
  }
}

void main() {
  test('convierte la respuesta del entrevistador', () {
    final CoachReply reply = coachReplyFromJson(<String, dynamic>{
      'feedback': <String, Object>{
        'score': 3,
        'strengths': <String>['Claro'],
        'improve': <Object>['Usa STAR', 7],
        'better_answer': 'En GSE…',
      },
      'next_question': '¿Cómo pruebas tus widgets?',
      'summary': null,
    });
    expect(reply.feedback!.improve, <String>['Usa STAR']);
    expect(reply.nextQuestion, '¿Cómo pruebas tus widgets?');
    expect(reply.summary, isNull);
  });

  testWidgets('practica una entrevista de 3 preguntas de punta a punta', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 3000);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    await jobs.save(
      const SavedJob(
        job: Job(title: 'Flutter Developer', company: 'Forest'),
      ),
    );
    final _FakeCoach coach = _FakeCoach();

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          interviewCoachProvider.overrideWithValue(coach),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ofertas').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Flutter Developer'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('practiceInterview')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Técnicas'));
    await tester.tap(find.text('3 preguntas'));
    await tester.tap(find.byKey(const Key('startPractice')));
    await tester.pumpAndSettle();
    expect(coach.mode, PracticeMode.technical);
    expect(coach.total, 3);
    expect(find.text('Pregunta 1'), findsOneWidget);
    expect(find.text('Pregunta 1 de 3'), findsOneWidget);

    // Sin respuesta, el botón de enviar está desactivado.
    expect(
      tester.widget<IconButton>(find.byKey(const Key('sendAnswer'))).onPressed,
      isNull,
    );

    for (int i = 1; i <= 3; i++) {
      await tester.enterText(
        find.byKey(const Key('practiceAnswer')),
        'Mi respuesta $i',
      );
      // Un fotograma para que el botón se active con el texto escrito.
      await tester.pump();
      await tester.tap(find.byKey(const Key('sendAnswer')));
      await tester.pumpAndSettle();
    }

    expect(coach.calls.last.map((PracticeTurn t) => t.answer), <String>[
      'Mi respuesta 1',
      'Mi respuesta 2',
      'Mi respuesta 3',
    ]);
    expect(find.text('Mencionas Riverpod'), findsNWidgets(3));
    expect(find.text('Resultado de la práctica'), findsOneWidget);
    expect(find.text('Buen nivel técnico.'), findsOneWidget);
    expect(find.byKey(const Key('practiceAnswer')), findsNothing);

    await tester.tap(find.byKey(const Key('practiceAgain')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('startPractice')), findsOneWidget);
  });
}
