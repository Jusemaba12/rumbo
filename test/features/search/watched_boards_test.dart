import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/search/data/search_repository.dart';
import 'package:rumbo/features/search/domain/search_preferences.dart';

void main() {
  group('parseBoardUrl', () {
    test('reconoce Greenhouse, Lever y Ashby', () {
      expect(
        parseBoardUrl('https://boards.greenhouse.io/gitlab'),
        const WatchedBoard(provider: BoardProvider.greenhouse, token: 'gitlab'),
      );
      expect(
        parseBoardUrl('job-boards.greenhouse.io/Twilio/jobs/123'),
        const WatchedBoard(provider: BoardProvider.greenhouse, token: 'twilio'),
      );
      expect(
        parseBoardUrl(
          'https://boards.greenhouse.io/embed/job_board?for=acme-labs',
        ),
        const WatchedBoard(
          provider: BoardProvider.greenhouse,
          token: 'acme-labs',
        ),
      );
      expect(
        parseBoardUrl('https://jobs.lever.co/spotify/abc-123'),
        const WatchedBoard(provider: BoardProvider.lever, token: 'spotify'),
      );
      expect(
        parseBoardUrl(' jobs.ashbyhq.com/truelogic '),
        const WatchedBoard(provider: BoardProvider.ashby, token: 'truelogic'),
      );
    });

    test('reconoce Workable, SmartRecruiters, Recruitee y Teamtailor', () {
      expect(
        parseBoardUrl('https://apply.workable.com/huggingface/'),
        const WatchedBoard(
          provider: BoardProvider.workable,
          token: 'huggingface',
        ),
      );
      expect(
        parseBoardUrl('apply.workable.com/huggingface/j/81B46579FE'),
        const WatchedBoard(
          provider: BoardProvider.workable,
          token: 'huggingface',
        ),
      );
      expect(
        parseBoardUrl('https://acme.workable.com'),
        const WatchedBoard(provider: BoardProvider.workable, token: 'acme'),
      );
      expect(
        parseBoardUrl('https://jobs.smartrecruiters.com/BoschGroup/7440001'),
        const WatchedBoard(
          provider: BoardProvider.smartrecruiters,
          token: 'boschgroup',
        ),
      );
      expect(
        parseBoardUrl('careers.smartrecruiters.com/Visa'),
        const WatchedBoard(
          provider: BoardProvider.smartrecruiters,
          token: 'visa',
        ),
      );
      expect(
        parseBoardUrl('https://hostaway.recruitee.com/o/head-of-analytics'),
        const WatchedBoard(
          provider: BoardProvider.recruitee,
          token: 'hostaway',
        ),
      );
      expect(
        parseBoardUrl('https://career.teamtailor.com/jobs/8118064-uk-sales'),
        const WatchedBoard(provider: BoardProvider.teamtailor, token: 'career'),
      );
    });

    test('rechaza ofertas sueltas y páginas del propio servicio', () {
      expect(parseBoardUrl('https://apply.workable.com/j/81B46579FE'), isNull);
      expect(parseBoardUrl('https://www.workable.com'), isNull);
      expect(parseBoardUrl('https://app.recruitee.com/login'), isNull);
      expect(parseBoardUrl('https://www.teamtailor.com/en/'), isNull);
      expect(parseBoardUrl('https://www.acme.teamtailor.com'), isNull);
      expect(parseBoardUrl('https://www.smartrecruiters.com/acme'), isNull);
    });

    test('rechaza enlaces que no son de esos portales', () {
      expect(parseBoardUrl(''), isNull);
      expect(parseBoardUrl('https://www.linkedin.com/company/acme'), isNull);
      expect(parseBoardUrl('https://jobs.lever.co/'), isNull);
      expect(parseBoardUrl('jobs.ashbyhq.com/acme<script>'), isNull);
    });
  });

  test('guarda y lee las empresas vigiladas', () {
    const prefs = SearchPreferences(
      technologies: ['Flutter'],
      watchedBoards: [
        WatchedBoard(provider: BoardProvider.ashby, token: 'truelogic'),
      ],
    );
    final row = preferencesToRow(prefs, userId: 'u1');
    expect(row['watched_boards'], [
      {'provider': 'ashby', 'token': 'truelogic'},
    ]);
    final back = preferencesFromRow({
      ...row,
      'watched_boards': [
        ...row['watched_boards'] as List,
        {'provider': 'workday', 'token': 'x'},
        'basura',
      ],
    });
    expect(back.watchedBoards, prefs.watchedBoards);
  });

  test('nombres visibles de empresas y fuentes', () {
    expect(boardCompanyName('acme-labs'), 'Acme Labs');
    expect(sourceName('ashby'), 'Ashby');
    expect(sourceName('smartrecruiters'), 'SmartRecruiters');
    expect(sourceName('teamtailor:career'), 'Teamtailor (career)');
    expect(sourceName('greenhouse:acme'), 'Greenhouse (acme)');
  });

  testWidgets('añade y quita empresas vigiladas en las preferencias', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 3200);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final search = InMemorySearchRepository(
      preferences: const SearchPreferences(technologies: ['Flutter']),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(InMemoryJobsRepository()),
          searchRepositoryProvider.overrideWithValue(search),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Preferencias de búsqueda'));
    await tester.pumpAndSettle();
    expect(find.text('Aún no vigilas ninguna empresa.'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('boardUrl')),
      'https://www.linkedin.com/company/acme',
    );
    await tester.tap(find.byKey(const Key('addBoard')));
    await tester.pump();
    expect(
      find.text(
        'No reconocemos ese enlace. Debe ser de Greenhouse, Lever, Ashby, '
        'Workable, SmartRecruiters, Recruitee o Teamtailor.',
      ),
      findsOneWidget,
    );

    await tester.enterText(
      find.byKey(const Key('boardUrl')),
      'jobs.ashbyhq.com/truelogic',
    );
    await tester.tap(find.byKey(const Key('addBoard')));
    await tester.pump();
    expect(find.text('Truelogic · Ashby'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('boardUrl')),
      'https://jobs.ashbyhq.com/truelogic/abc',
    );
    await tester.tap(find.byKey(const Key('addBoard')));
    await tester.pump();
    expect(find.text('Ya vigilas esa empresa.'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('boardUrl')),
      'jobs.lever.co/spotify',
    );
    await tester.tap(find.byKey(const Key('addBoard')));
    await tester.pump();
    await tester.tap(find.byTooltip('Dejar de vigilar Spotify'));
    await tester.pump();
    expect(find.text('Spotify · Lever'), findsNothing);

    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(search.preferences!.watchedBoards, const [
      WatchedBoard(provider: BoardProvider.ashby, token: 'truelogic'),
    ]);
  });

  testWidgets(
    'las sugerencias con Flutter se añaden con un toque y deslizar recupera '
    'lo guardado',
    (tester) async {
      tester.view.physicalSize = const Size(1080, 4000);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      final search = InMemorySearchRepository(
        preferences: const SearchPreferences(technologies: ['Flutter']),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(
              const LocalAuthRepository(),
            ),
            jobsRepositoryProvider.overrideWithValue(InMemoryJobsRepository()),
            searchRepositoryProvider.overrideWithValue(search),
          ],
          child: const RumboApp(locale: Locale('es')),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Más'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Preferencias de búsqueda'));
      await tester.pumpAndSettle();

      expect(find.text('Sugerencias con Flutter'), findsOneWidget);
      expect(find.text('Ubuntu usa Flutter · remoto mundial'), findsOneWidget);
      await tester.tap(
        find.descendant(
          of: find.byKey(const Key('suggest-canonical')),
          matching: find.byIcon(Icons.add_circle_outline),
        ),
      );
      await tester.pump();
      // Pasa a vigiladas y deja de sugerirse.
      expect(find.byKey(const Key('suggest-canonical')), findsNothing);
      expect(
        find.widgetWithText(InputChip, 'Canonical · Greenhouse'),
        findsOneWidget,
      );

      // Deslizar descarta lo no guardado y vuelve a leer del servidor.
      unawaited(
        tester
            .state<RefreshIndicatorState>(find.byType(RefreshIndicator))
            .show(),
      );
      await tester.pumpAndSettle();
      expect(
        find.widgetWithText(InputChip, 'Canonical · Greenhouse'),
        findsNothing,
      );
      expect(find.byKey(const Key('suggest-canonical')), findsOneWidget);

      await tester.tap(
        find.descendant(
          of: find.byKey(const Key('suggest-revenuecat')),
          matching: find.byIcon(Icons.add_circle_outline),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('Guardar'));
      await tester.pumpAndSettle();
      expect(search.preferences!.watchedBoards, const [
        WatchedBoard(provider: BoardProvider.ashby, token: 'revenuecat'),
      ]);
    },
  );
}
