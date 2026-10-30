import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';

Future<InMemoryProfileRepository> _openProfile(
  WidgetTester tester, [
  ProfileData data = const ProfileData(),
]) async {
  // Pantalla alta para que las listas dibujen todas sus secciones.
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  final InMemoryProfileRepository repository = InMemoryProfileRepository(data);
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
        profileRepositoryProvider.overrideWithValue(repository),
      ],
      child: const RumboApp(locale: Locale('es')),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('HV'));
  await tester.pumpAndSettle();
  return repository;
}

void main() {
  testWidgets('el perfil vacío indica qué falta', (WidgetTester tester) async {
    await _openProfile(tester);

    expect(find.text('Perfil completo'), findsOneWidget);
    expect(find.text('0%'), findsOneWidget);
    expect(find.text('Añade tu nombre.'), findsOneWidget);
    expect(find.text('Aún no has añadido experiencia.'), findsOneWidget);
  });

  testWidgets('edita los datos básicos y valida nombre y enlaces', (
    WidgetTester tester,
  ) async {
    final InMemoryProfileRepository repository = await _openProfile(tester);

    await tester.tap(find.byKey(const Key('editBasics')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('github')), 'github/ana');
    await tester.ensureVisible(find.text('Guardar', skipOffstage: false));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect((await repository.load()).getOrThrow().profile, const Profile());

    await tester.ensureVisible(
      find.byKey(const Key('fullName'), skipOffstage: false),
    );
    await tester.pumpAndSettle();
    expect(find.text('Este campo es obligatorio'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('fullName')), 'Ana Pérez');
    await tester.enterText(
      find.byKey(const Key('headline')),
      'Desarrolladora Flutter',
    );
    await tester.ensureVisible(
      find.byKey(const Key('github'), skipOffstage: false),
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('github')),
      'https://github.com/ana',
    );
    await tester.ensureVisible(find.text('Guardar', skipOffstage: false));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    expect(find.text('Ana Pérez'), findsOneWidget);
    expect(find.text('Desarrolladora Flutter'), findsOneWidget);
    expect(find.text('Añade tu primera experiencia laboral.'), findsOneWidget);
    expect(
      (await repository.load()).getOrThrow().profile.links,
      <String, String>{ProfileLinks.github: 'https://github.com/ana'},
    );
  });

  testWidgets('guarda el nivel de inglés y la expectativa salarial', (
    WidgetTester tester,
  ) async {
    final InMemoryProfileRepository repository = await _openProfile(
      tester,
      const ProfileData(profile: Profile(fullName: 'Ana Pérez')),
    );
    await tester.tap(find.byKey(const Key('editBasics')));
    await tester.pumpAndSettle();

    final Finder english = find.byKey(
      const Key('englishLevel'),
      skipOffstage: false,
    );
    await tester.ensureVisible(english);
    await tester.pumpAndSettle();
    await tester.tap(english);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Avanzado (C1)').last);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('salary-COP-min')),
      '8.000.000',
    );
    await tester.enterText(find.byKey(const Key('salary-COP-max')), '6000000');
    await tester.enterText(find.byKey(const Key('salary-USD-min')), '2000');
    await tester.enterText(find.byKey(const Key('salary-USD-max')), '2.500');
    await tester.ensureVisible(find.text('Guardar', skipOffstage: false));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(
      find.text('El máximo no puede ser menor que el mínimo.'),
      findsOneWidget,
    );

    await tester.enterText(
      find.byKey(const Key('salary-COP-min')),
      '6.000.000',
    );
    await tester.enterText(
      find.byKey(const Key('salary-COP-max')),
      '8.000.000',
    );
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    final Profile profile = (await repository.load()).getOrThrow().profile;
    expect(profile.englishLevel, LanguageLevel.c1);
    expect(profile.salaryCopMin, 6000000);
    expect(profile.salaryCopMax, 8000000);
    expect(profile.salaryUsdMin, 2000);
    expect(profile.salaryUsdMax, 2500);
    expect(find.text('Inglés: Avanzado (C1)'), findsOneWidget);
    expect(
      find.text(
        'Expectativa: COP 6.000.000 – 8.000.000 · USD 2.000 – 2.500 al mes',
      ),
      findsOneWidget,
    );
  });

  testWidgets('añade, edita y elimina una habilidad', (
    WidgetTester tester,
  ) async {
    final InMemoryProfileRepository repository = await _openProfile(tester);

    await tester.tap(find.byKey(const Key('addSkill')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('skillName')), 'Flutter');
    await tester.enterText(find.byKey(const Key('skillYears')), '4');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Flutter · 4 años'), findsOneWidget);

    await tester.tap(find.text('Flutter · 4 años'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('skillYears')), '1');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Flutter · 1 año'), findsOneWidget);

    await tester.tap(find.text('Flutter · 1 año'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();
    expect((await repository.load()).getOrThrow().skills, isEmpty);
    expect(find.text('Aún no has añadido habilidades.'), findsOneWidget);
  });

  testWidgets('muestra la experiencia y permite eliminarla con confirmación', (
    WidgetTester tester,
  ) async {
    final InMemoryProfileRepository repository = await _openProfile(
      tester,
      ProfileData(
        experiences: <Experience>[
          Experience(
            id: 'exp-1',
            company: 'Acme',
            role: 'Flutter Developer',
            startDate: DateTime(2022, 3),
          ),
        ],
      ),
    );

    expect(find.text('Flutter Developer'), findsOneWidget);
    expect(find.text('Acme · mar 2022 – Actualidad'), findsOneWidget);

    await tester.tap(find.text('Flutter Developer'));
    await tester.pumpAndSettle();
    expect(find.text('Editar experiencia'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('¿Eliminar «Flutter Developer»?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Eliminar'));
    await tester.pumpAndSettle();

    expect(find.text('Tu perfil'), findsOneWidget);
    expect((await repository.load()).getOrThrow().experiences, isEmpty);
  });
}
