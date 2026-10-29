import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/practice/data/interview_coach.dart';
import 'package:rumbo/features/practice/domain/practice.dart';

class _FakeCoach implements InterviewCoach {
  final calls = <List<PracticeTurn>>[];
  PracticeMode? mode;
  int? total;

  @override
  Future<CoachReply> next({
    required String jobId,
    required PracticeMode mode,
    required PracticeLanguage language,
    required int totalQuestions,
    required List<PracticeTurn> turns,
  }) async {
    calls.add([...turns]);
    this.mode = mode;
    total = totalQuestions;
    final answered = turns.length;
    return CoachReply(
      feedback: answered == 0
          ? null
          : AnswerFeedback(
              score: 4,
              strengths: ['Mencionas Riverpod'],
              improve: ['Añade una cifra'],
              betterAnswer: 'Respuesta mejorada $answered',
            ),
      nextQuestion: answered < totalQuestions
          ? 'Pregunta ${answered + 1}'
          : null,
      summary: answered < totalQuestions
          ? null
          : const PracticeSummary(score: 4, overall: 'Buen nivel técnico.'),
    );
  }
}

void main() {
  test('convierte la respuesta del entrevistador', () {
    final reply = coachReplyFromJson({
      'feedback': {
        'score': 3,
        'strengths': ['Claro'],
        'improve': ['Usa STAR', 7],
        'better_answer': 'En GSE…',
      },
      'next_question': '¿Cómo pruebas tus widgets?',
      'summary': null,
    });
    expect(reply.feedback!.improve, ['Usa STAR']);
    expect(reply.nextQuestion, '¿Cómo pruebas tus widgets?');
    expect(reply.summary, isNull);
  });

  testWidgets('practica una entrevista de 3 preguntas de punta a punta', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 3000);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final jobs = InMemoryJobsRepository();
    await jobs.save(
      const SavedJob(
        job: Job(title: 'Flutter Developer', company: 'Forest'),
      ),
    );
    final coach = _FakeCoach();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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

    for (var i = 1; i <= 3; i++) {
      await tester.enterText(
        find.byKey(const Key('practiceAnswer')),
        'Mi respuesta $i',
      );
      // Un fotograma para que el botón se active con el texto escrito.
      await tester.pump();
      await tester.tap(find.byKey(const Key('sendAnswer')));
      await tester.pumpAndSettle();
    }

    expect(coach.calls.last.map((t) => t.answer), [
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
