import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/profile/data/profile_repository.dart';
import 'package:rumbo/features/profile/data/resume_keywords.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

class _FakeKeywords implements ResumeKeywordsSource {
  var calls = 0;
  bool? lastForce;

  @override
  Future<KeywordsResult?> cached() async => null;

  @override
  Future<KeywordsResult> fetch({bool force = false}) async {
    calls++;
    lastForce = force;
    return KeywordsResult(
      updatedAt: DateTime(2026, 10, 16),
      keywords: const [
        ResumeKeyword(keyword: 'Flutter', important: true),
        ResumeKeyword(keyword: 'CI/CD', important: true, reason: 'Despliegues'),
        ResumeKeyword(keyword: 'Unit testing', important: false),
      ],
    );
  }
}

void main() {
  testWidgets('revisa la HV, busca palabras clave y lleva a corregir', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final keywords = _FakeKeywords();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          profileRepositoryProvider.overrideWithValue(
            InMemoryProfileRepository(
              ProfileData(
                profile: const Profile(
                  fullName: 'Juan Manzano',
                  headline: 'Flutter Developer',
                ),
                experiences: [
                  Experience(
                    id: 'e1',
                    company: 'GSE',
                    role: 'Flutter Developer',
                    startDate: DateTime(2024, 9),
                    achievements: const ['Responsable de la app de pagos'],
                  ),
                ],
              ),
            ),
          ),
          resumeKeywordsSourceProvider.overrideWithValue(keywords),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('HV'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('openReview')));
    await tester.pumpAndSettle();
    expect(find.text('Nota de tu HV base'), findsOneWidget);
    // La nota se desglosa por partes.
    expect(find.byKey(const Key('category-contact')), findsOneWidget);
    await tester.ensureVisible(
      find.text('Falta tu correo: la empresa no podrá contactarte.'),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.textContaining('1 logro empieza como tarea'),
    );
    await tester.pumpAndSettle();

    // Las palabras clave solo se piden al pulsar el botón.
    expect(keywords.calls, 0);
    await tester.ensureVisible(
      find.byKey(const Key('loadKeywords'), skipOffstage: false),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('loadKeywords')));
    await tester.pumpAndSettle();
    expect(keywords.calls, 1);
    expect(find.text('No aparecen · 2'), findsOneWidget);
    expect(find.text('En tu experiencia · 1'), findsOneWidget);
    expect(keywords.lastForce, isFalse);
    expect(find.byKey(const Key('missing-CI/CD')), findsOneWidget);

    // Tocar una que falta abre la hoja de habilidad con el nombre puesto.
    await tester.ensureVisible(
      find.byKey(const Key('missing-CI/CD'), skipOffstage: false),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('missing-CI/CD')));
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) => widget is EditableText && widget.controller.text == 'CI/CD',
      ),
      findsOneWidget,
    );
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    // «Corregir» en el correo abre los datos básicos.
    await tester.scrollUntilVisible(
      find.byKey(const Key('fix-noEmail-')),
      -300,
      scrollable: find
          .descendant(
            of: find.byType(RefreshIndicator),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('fix-noEmail-')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('email')), findsOneWidget);

    // Al guardar el correo y volver, la nota sube y se avisa.
    await tester.enterText(find.byKey(const Key('email')), 'juan@correo.com');
    await tester.ensureVisible(find.text('Guardar', skipOffstage: false));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    // De vuelta en la revisión (desplazada hacia abajo).
    expect(find.byKey(const Key('refreshReview')), findsOneWidget);
    expect(find.textContaining('tu nota subió de'), findsOneWidget);
    expect(
      find.text('Falta tu correo: la empresa no podrá contactarte.'),
      findsNothing,
    );

    // «Volver a revisar» repite la revisión aunque no haya cambios.
    await tester.tap(find.byKey(const Key('refreshReview')));
    await tester.pumpAndSettle();
    expect(find.textContaining('tu nota sigue en'), findsOneWidget);
  });
}
