import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/search/domain/entities/search_preferences.dart';

SearchPreferences preferencesFromRow(Map<String, dynamic> row) {
  List<String> list(String key) => <String>[
    ...(row[key] as List<dynamic>? ?? const <dynamic>[]).cast<String>(),
  ];
  final String? lastRun = row['last_run_at'] as String?;
  return SearchPreferences(
    roles: list('roles'),
    technologies: list('technologies'),
    workModes: <WorkMode>[
      for (final String mode in list('work_modes'))
        ?WorkMode.values.asNameMap()[mode],
    ],
    countries: list('countries'),
    sources: list('active_sources').isEmpty
        ? searchSources
        : list('active_sources'),
    minScore: row['min_score'] as int? ?? 60,
    watchedBoards: <WatchedBoard>[
      for (final dynamic item
          in row['watched_boards'] as List<dynamic>? ?? const <dynamic>[])
        ?_boardFromJson(item),
    ],
    lastRunAt: lastRun == null ? null : DateTime.parse(lastRun).toLocal(),
  );
}

Map<String, dynamic> preferencesToRow(
  SearchPreferences preferences, {
  required String userId,
}) => <String, dynamic>{
  'user_id': userId,
  'roles': preferences.roles,
  'technologies': preferences.technologies,
  'work_modes': <String>[
    for (final WorkMode mode in preferences.workModes) mode.name,
  ],
  'countries': preferences.countries,
  'active_sources': preferences.sources,
  'min_score': preferences.minScore,
  'watched_boards': <Map<String, String>>[
    for (final WatchedBoard board in preferences.watchedBoards)
      <String, String>{'provider': board.provider.name, 'token': board.token},
  ],
};

WatchedBoard? _boardFromJson(Object? item) {
  if (item is! Map) return null;
  final BoardProvider? provider = BoardProvider.values
      .asNameMap()[item['provider']];
  final Object? token = item['token'];
  if (provider == null || token is! String) return null;
  return WatchedBoard(provider: provider, token: token);
}
