import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/profile/domain/entities/achievement_suggestion.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/achievement_rewriter.dart';
import 'package:rumbo/features/profile/domain/services/achievement_suggestions.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

class _FakeRewriter implements AchievementRewriter {
  String? askedFor;

  @override
  Future<Result<List<AchievementSuggestion>>> suggest(
    String experienceId,
  ) async {
    askedFor = experienceId;
    return Ok<List<AchievementSuggestion>>(const <AchievementSuggestion>[
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
    ]);
  }
}

void main() {
  test('aplica las propuestas: sustituye por índice y añade las nuevas', () {
    expect(
      applySuggestions(
        achievements: <String>['a', 'b', 'c'],
        chosen: <({int? index, String text})>[
          (index: 1, text: ' B '),
          (index: null, text: 'd'),
          (index: 9, text: 'e'),
        ],
      ),
      <String>['a', 'B', 'c', 'd', 'e'],
    );
    expect(placeholderPattern.hasMatch('reduje un [X %]'), isTrue);
    expect(placeholderPattern.hasMatch('reduje un 30 %'), isFalse);
  });

  testWidgets('mejora los logros desde la revisión y exige completar huecos', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemoryProfileRepository repository = InMemoryProfileRepository(
      ProfileData(
        profile: const Profile(fullName: 'Juan Manzano'),
        experiences: <Experience>[
          Experience(
            id: 'e1',
            company: 'GSE',
            role: 'Flutter Developer',
            startDate: DateTime(2024, 9),
            achievements: const <String>[
              'Responsable de mantener la app de pagos',
              'Trabajo con Flutter',
            ],
          ),
        ],
      ),
    );
    final _FakeRewriter rewriter = _FakeRewriter();
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
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

    final Finder improve = find.byKey(const Key('improve-fewNumbers-e1'));
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
    final Finder save = find.byKey(const Key('saveImproved'));
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
    final List<String> saved = (await repository.load())
        .getOrThrow()
        .experiences
        .single
        .achievements;
    expect(saved, <String>[
      'Mantuve la app de pagos y reduje los errores un 30 %',
      'Desarrollé pantallas en Flutter con Riverpod',
    ]);
  });
}
