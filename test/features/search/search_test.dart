import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/core/time/clock.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/profile/data/profile_repository.dart';
import 'package:rumbo/features/profile/domain/profile.dart';
import 'package:rumbo/features/search/data/search_repository.dart';
import 'package:rumbo/features/search/domain/search_preferences.dart';

const _suggestion = SavedJob(
  job: Job(
    title: 'Flutter Developer',
    company: 'Routed Labs',
    location: 'Remote',
    workMode: WorkMode.remote,
    source: 'getonboard',
    discovered: true,
  ),
  match: JobMatch(score: 78, explanation: 'Encajas bien.'),
);

void main() {
  group('SearchPreferences', () {
    test('convierte filas y usa todos los portales si no hay ninguno', () {
      final prefs = preferencesFromRow({
        'user_id': 'u1',
        'roles': ['Flutter Developer'],
        'technologies': ['Flutter', 'Dart'],
        'work_modes': ['remote', 'desconocido'],
        'countries': ['Colombia'],
        'active_sources': <String>[],
        'min_score': 70,
        'last_run_at': '2026-10-15T10:00:00+00:00',
      });
      expect(prefs.workModes, [WorkMode.remote]);
      expect(prefs.sources, searchSources);
      expect(prefs.minScore, 70);
      final row = preferencesToRow(prefs, userId: 'u1');
      expect(row['work_modes'], ['remote']);
      expect(row.containsKey('last_run_at'), isFalse);
    });

    test('busca sola solo si la última búsqueda tiene más de 6 horas', () {
      final now = DateTime(2026, 10, 15, 12);
      const prefs = SearchPreferences(technologies: ['Flutter']);
      expect(prefs.isConfigured, isTrue);
      expect(prefs.isStale(now), isTrue);
      expect(
        prefs.copyWith(lastRunAt: DateTime(2026, 10, 15, 8)).isStale(now),
        isFalse,
      );
      expect(
        prefs.copyWith(lastRunAt: DateTime(2026, 10, 15, 5)).isStale(now),
        isTrue,
      );
      expect(const SearchPreferences().isConfigured, isFalse);
    });
  });

  testWidgets('busca al abrir Ofertas, guarda y descarta sugerencias', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    final jobs = InMemoryJobsRepository();
    final search = InMemorySearchRepository(
      preferences: const SearchPreferences(technologies: ['Flutter']),
      onSearch: () async {
        await jobs.save(_suggestion);
        await jobs.save(
          SavedJob(
            job: _suggestion.job.copyWith(
              title: 'Mobile Engineer',
              company: 'Beta',
            ),
            match: const JobMatch(score: 64),
          ),
        );
        return const SearchSummary(
          found: 40,
          scored: 2,
          suggested: 2,
          failedSources: ['remotive'],
        );
      },
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          searchRepositoryProvider.overrideWithValue(search),
          clockProvider.overrideWithValue(() => DateTime(2026, 10, 15, 12)),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ofertas').last);
    await tester.pumpAndSettle();
    expect(search.searches, 1);
    expect(
      find.text('2 ofertas nuevas sugeridas. No respondieron: Remotive.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Sugeridas (2)'));
    await tester.pumpAndSettle();
    // Ordenadas por compatibilidad.
    final first = tester.getTopLeft(find.text('Flutter Developer')).dy;
    final second = tester.getTopLeft(find.text('Mobile Engineer')).dy;
    expect(first, lessThan(second));
    expect(find.text('Get on Board'), findsNWidgets(2));
    // La ubicación «Remote» no se repite junto a la modalidad.
    expect(find.text('Routed Labs · Remoto'), findsOneWidget);

    // Guardar desde el detalle.
    await tester.tap(find.text('Flutter Developer'));
    await tester.pumpAndSettle();
    expect(find.text('Encontrada en Get on Board'), findsOneWidget);
    await tester.tap(find.byKey(const Key('keepSuggestion')));
    await tester.pumpAndSettle();
    expect(find.text('Seguir esta oferta'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Sugeridas (1)'), findsOneWidget);
    expect(find.text('Guardadas (1)'), findsOneWidget);

    // Descartar deslizando.
    await tester.drag(find.text('Mobile Engineer'), const Offset(-600, 0));
    await tester.pumpAndSettle();
    expect(find.text('Sugeridas (0)'), findsOneWidget);
    final stored = await jobs.list();
    expect(stored.where((s) => s.job.dismissed), hasLength(1));

    // Volver a la pestaña no repite la búsqueda: la última es reciente.
    await tester.tap(find.text('Inicio'));
    await tester.pumpAndSettle();
    // Sin sugerencias pendientes, «Para hoy» no las propone.
    expect(find.text('Sugeridas'), findsOneWidget);
    expect(find.byKey(const Key('todaySuggestions')), findsNothing);
    await tester.tap(find.text('Ofertas').last);
    await tester.pumpAndSettle();
    expect(search.searches, 1);
  });

  testWidgets('sin preferencias invita a configurar la búsqueda', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final search = InMemorySearchRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(InMemoryJobsRepository()),
          searchRepositoryProvider.overrideWithValue(search),
          profileRepositoryProvider.overrideWithValue(
            InMemoryProfileRepository(
              const ProfileData(
                profile: Profile(location: 'Bogotá, Colombia'),
                skills: [
                  Skill(name: 'Dart', category: SkillCategory.language),
                  Skill(name: 'Flutter', category: SkillCategory.framework),
                  Skill(name: 'Git', category: SkillCategory.tool),
                ],
              ),
            ),
          ),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ofertas').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sugeridas (0)'));
    await tester.pumpAndSettle();
    expect(search.searches, 0);

    await tester.tap(find.byKey(const Key('setupSearch')));
    await tester.pumpAndSettle();
    // Propone tecnologías y país a partir del perfil.
    expect(find.text('Dart, Flutter'), findsOneWidget);
    expect(find.text('Colombia'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('searchTechnologies')),
      'Flutter, Dart',
    );
    // Sin foco: si no, el cursor vuelve a desplazar la lista hasta el campo.
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Guardar', skipOffstage: false));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    expect(search.preferences!.technologies, ['Flutter', 'Dart']);
    expect(search.preferences!.countries, ['Colombia']);
    expect(search.preferences!.workModes, [WorkMode.remote]);
    // Guardar lanza la primera búsqueda.
    expect(search.searches, 1);
  });
}
