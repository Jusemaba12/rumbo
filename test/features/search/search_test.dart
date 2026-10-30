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
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';
import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/domain/entities/search_summary.dart';
import 'package:rumbo/features/search/infrastructure/di/search_providers.dart';
import 'package:rumbo/features/search/infrastructure/mappers/search_preferences_mapper.dart';
import 'package:rumbo/features/search/infrastructure/repositories/in_memory_search_repository.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/domain/result.dart';

const SavedJob _suggestion = SavedJob(
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
      final SearchPreferences prefs = preferencesFromRow(<String, dynamic>{
        'user_id': 'u1',
        'roles': <String>['Flutter Developer'],
        'technologies': <String>['Flutter', 'Dart'],
        'work_modes': <String>['remote', 'desconocido'],
        'countries': <String>['Colombia'],
        'active_sources': <String>[],
        'min_score': 70,
        'last_run_at': '2026-10-15T10:00:00+00:00',
      });
      expect(prefs.workModes, <WorkMode>[WorkMode.remote]);
      expect(prefs.sources, searchSources);
      expect(prefs.minScore, 70);
      final Map<String, dynamic> row = preferencesToRow(prefs, userId: 'u1');
      expect(row['work_modes'], <String>['remote']);
      expect(row.containsKey('last_run_at'), isFalse);
    });

    test('busca sola solo si la última búsqueda tiene más de 6 horas', () {
      final DateTime now = DateTime(2026, 10, 15, 12);
      const SearchPreferences prefs = SearchPreferences(
        technologies: <String>['Flutter'],
      );
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
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    final InMemoryJobsRepository jobs = InMemoryJobsRepository();
    final InMemorySearchRepository search = InMemorySearchRepository(
      preferences: const SearchPreferences(technologies: <String>['Flutter']),
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
        return const Ok<SearchSummary>(
          SearchSummary(
            found: 40,
            scored: 2,
            suggested: 2,
            failedSources: <String>['remotive'],
          ),
        );
      },
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
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
    final double first = tester.getTopLeft(find.text('Flutter Developer')).dy;
    final double second = tester.getTopLeft(find.text('Mobile Engineer')).dy;
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
    final List<SavedJob> stored = (await jobs.list()).getOrThrow();
    expect(stored.where((SavedJob s) => s.job.dismissed), hasLength(1));

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
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final InMemorySearchRepository search = InMemorySearchRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(InMemoryJobsRepository()),
          searchRepositoryProvider.overrideWithValue(search),
          profileRepositoryProvider.overrideWithValue(
            InMemoryProfileRepository(
              const ProfileData(
                profile: Profile(location: 'Bogotá, Colombia'),
                skills: <Skill>[
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

    expect(search.preferences!.technologies, <String>['Flutter', 'Dart']);
    expect(search.preferences!.countries, <String>['Colombia']);
    expect(search.preferences!.workModes, <WorkMode>[WorkMode.remote]);
    // Guardar lanza la primera búsqueda.
    expect(search.searches, 1);
  });
}
