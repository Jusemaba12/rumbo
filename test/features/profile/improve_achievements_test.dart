import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/profile/data/achievement_rewriter.dart';
import 'package:rumbo/features/profile/data/profile_repository.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

class _FakeRewriter implements AchievementRewriter {
  String? askedFor;

  @override
  Future<List<AchievementSuggestion>> suggest(String experienceId) async {
    askedFor = experienceId;
    return const [
      AchievementSuggestion(
        index: 0,
        original: 'Responsable de mantener la app de pagos',
        rewritten: 'Mantuve la app de pagos y reduje los errores un [X %]',
        reason: 'Empieza con verbo y pide el impacto',
      ),
      AchievementSuggestion(
        index: 1,
        original: 'Trabajo con Flutter',
        rewritten: 'Desarrollé pantallas en Flutter con Riverpod',
        reason: 'Verbo de acción',
      ),
    ];
  }
}

void main() {
  test('aplica las propuestas: sustituye por índice y añade las nuevas', () {
    expect(
      applySuggestions(
        ['a', 'b', 'c'],
        [
          (index: 1, text: ' B '),
          (index: null, text: 'd'),
          (index: 9, text: 'e'),
        ],
      ),
      ['a', 'B', 'c', 'd', 'e'],
    );
    expect(placeholderPattern.hasMatch('reduje un [X %]'), isTrue);
    expect(placeholderPattern.hasMatch('reduje un 30 %'), isFalse);
  });

  testWidgets('mejora los logros desde la revisión y exige completar huecos', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final repository = InMemoryProfileRepository(
      ProfileData(
        profile: const Profile(fullName: 'Juan Manzano'),
        experiences: [
          Experience(
            id: 'e1',
            company: 'GSE',
            role: 'Flutter Developer',
            startDate: DateTime(2024, 9),
            achievements: const [
              'Responsable de mantener la app de pagos',
              'Trabajo con Flutter',
            ],
          ),
        ],
      ),
    );
    final rewriter = _FakeRewriter();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          profileRepositoryProvider.overrideWithValue(repository),
          achievementRewriterProvider.overrideWithValue(rewriter),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('HV'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openReview')));
    await tester.pumpAndSettle();

    final improve = find.byKey(const Key('improve-fewNumbers-e1'));
    await tester.scrollUntilVisible(
      improve,
      300,
      scrollable: find
          .descendant(
            of: find.byType(RefreshIndicator),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    await tester.tap(improve);
    await tester.pumpAndSettle();
    expect(rewriter.askedFor, 'e1');
    expect(find.text('Mejorar logros'), findsOneWidget);

    // Con un hueco sin completar no se puede guardar.
    expect(find.byKey(const Key('fillPlaceholders')), findsOneWidget);
    final save = find.byKey(const Key('saveImproved'));
    expect(tester.widget<FilledButton>(save).onPressed, isNull);

    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('suggestion-0')),
        matching: find.byType(TextField),
      ),
      'Mantuve la app de pagos y reduje los errores un 30 %',
    );
    await tester.pump();
    expect(find.byKey(const Key('fillPlaceholders')), findsNothing);
    await tester.tap(save);
    await tester.pumpAndSettle();

    // De vuelta en la revisión, que avisa de que la nota subió.
    expect(find.text('Mejorar logros'), findsNothing);
    expect(find.textContaining('tu nota subió de'), findsOneWidget);
    final saved = (await repository.load()).experiences.single.achievements;
    expect(saved, [
      'Mantuve la app de pagos y reduje los errores un 30 %',
      'Desarrollé pantallas en Flutter con Riverpod',
    ]);
  });
}
