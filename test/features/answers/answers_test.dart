import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';
import 'package:rumbo/features/answers/infrastructure/di/answers_providers.dart';
import 'package:rumbo/features/answers/infrastructure/repositories/in_memory_answers_repository.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';

void main() {
  testWidgets('crea una respuesta desde una pregunta habitual y la edita', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemoryAnswersRepository answers = InMemoryAnswersRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          answersRepositoryProvider.overrideWithValue(answers),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Banco de respuestas'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Háblame de ti'));
    await tester.pumpAndSettle();
    expect(find.text('Nueva respuesta'), findsWidgets);
    await tester.enterText(
      find.byKey(const Key('answerText')),
      'Soy desarrollador Flutter con 2 años en GSE.',
    );
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    final SavedAnswer saved = (await answers.list()).getOrThrow().single;
    expect(saved.question, 'Háblame de ti');
    // La pregunta ya respondida deja de sugerirse.
    expect(find.widgetWithText(ActionChip, 'Háblame de ti'), findsNothing);
    expect(
      find.text('Soy desarrollador Flutter con 2 años en GSE.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Háblame de ti'));
    await tester.pumpAndSettle();
    expect(find.text('Editar respuesta'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('answerText')), 'Versión 2');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect((await answers.list()).getOrThrow().single.answer, 'Versión 2');
  });
}
