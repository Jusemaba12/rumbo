import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';
import '../../jobs/domain/job.dart';
import '../domain/search_preferences.dart';

part 'search_repository.g.dart';
part 'search_repository.freezed.dart';

/// Resultado de una búsqueda en los portales.
@Freezed(fromJson: false, toJson: false)
abstract class SearchSummary with _$SearchSummary {
  const factory SearchSummary({
    required int found,
    required int scored,
    required int suggested,
    @Default([]) List<String> failedSources,
  }) = _SearchSummary;

  factory SearchSummary.fromJson(Map<String, dynamic> json) => SearchSummary(
    found: json['found'] as int? ?? 0,
    scored: json['scored'] as int? ?? 0,
    suggested: json['suggested'] as int? ?? 0,
    failedSources: [
      ...(json['failed_sources'] as List? ?? const []).cast<String>(),
    ],
  );
}

enum SearchFailure {
  noPreferences,
  tooSoon,
  rateLimited,
  dailyLimit,
  busy,
  other,
}

class SearchException implements Exception {
  const SearchException(this.reason);

  final SearchFailure reason;

  @override
  String toString() => 'SearchException($reason)';
}

abstract interface class SearchRepository {
  /// Nulo si el usuario aún no configuró la búsqueda.
  Future<SearchPreferences?> loadPreferences();
  Future<void> savePreferences(SearchPreferences preferences);

  /// Busca en los portales y guarda las sugerencias nuevas.
  Future<SearchSummary> search();
}

class SupabaseSearchRepository implements SearchRepository {
  SupabaseSearchRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<SearchPreferences?> loadPreferences() async {
    final row = await _client.from('search_preferences').select().maybeSingle();
    return row == null ? null : preferencesFromRow(row);
  }

  @override
  Future<void> savePreferences(SearchPreferences preferences) => _client
      .from('search_preferences')
      .upsert(
        preferencesToRow(preferences, userId: _client.auth.currentUser!.id),
      );

  @override
  Future<SearchSummary> search() async {
    try {
      final response = await invokeAi(_client.functions, 'search-jobs');
      return SearchSummary.fromJson(
        (response.data as Map).cast<String, dynamic>(),
      );
    } on FunctionException catch (error) {
      debugPrint('search-jobs ${error.status}: ${error.details}');
      final code = error.details is Map
          ? (error.details as Map)['error']
          : null;
      if (isDailyLimit(error)) {
        throw const SearchException(SearchFailure.dailyLimit);
      }
      throw SearchException(switch ((error.status, code)) {
        (422, 'no_preferences') => SearchFailure.noPreferences,
        (429, 'too_soon') => SearchFailure.tooSoon,
        (429, _) => SearchFailure.rateLimited,
        (503, _) => SearchFailure.busy,
        _ => SearchFailure.other,
      });
    }
  }
}

/// Modo local y tests: guarda preferencias y no busca en internet.
class InMemorySearchRepository implements SearchRepository {
  InMemorySearchRepository({this.preferences, this.onSearch});

  SearchPreferences? preferences;
  final Future<SearchSummary> Function()? onSearch;
  int searches = 0;

  @override
  Future<SearchPreferences?> loadPreferences() async => preferences;

  @override
  Future<void> savePreferences(SearchPreferences value) async =>
      preferences = value;

  @override
  Future<SearchSummary> search() async {
    searches++;
    preferences = preferences?.copyWith(lastRunAt: DateTime.now());
    return await onSearch?.call() ??
        const SearchSummary(found: 0, scored: 0, suggested: 0);
  }
}

SearchPreferences preferencesFromRow(Map<String, dynamic> row) {
  List<String> list(String key) => [
    ...(row[key] as List? ?? const []).cast<String>(),
  ];
  final lastRun = row['last_run_at'] as String?;
  return SearchPreferences(
    roles: list('roles'),
    technologies: list('technologies'),
    workModes: [
      for (final mode in list('work_modes')) ?WorkMode.values.asNameMap()[mode],
    ],
    countries: list('countries'),
    sources: list('active_sources').isEmpty
        ? searchSources
        : list('active_sources'),
    minScore: row['min_score'] as int? ?? 60,
    watchedBoards: [
      for (final item in row['watched_boards'] as List? ?? const [])
        ?_boardFromJson(item),
    ],
    lastRunAt: lastRun == null ? null : DateTime.parse(lastRun).toLocal(),
  );
}

Map<String, dynamic> preferencesToRow(
  SearchPreferences preferences, {
  required String userId,
}) => {
  'user_id': userId,
  'roles': preferences.roles,
  'technologies': preferences.technologies,
  'work_modes': [for (final mode in preferences.workModes) mode.name],
  'countries': preferences.countries,
  'active_sources': preferences.sources,
  'min_score': preferences.minScore,
  'watched_boards': [
    for (final board in preferences.watchedBoards)
      {'provider': board.provider.name, 'token': board.token},
  ],
};

@Riverpod(keepAlive: true)
SearchRepository searchRepository(Ref ref) {
  if (!Env.hasBackend) return InMemorySearchRepository();
  return SupabaseSearchRepository(Supabase.instance.client);
}

WatchedBoard? _boardFromJson(Object? item) {
  if (item is! Map) return null;
  final provider = BoardProvider.values.asNameMap()[item['provider']];
  final token = item['token'];
  if (provider == null || token is! String) return null;
  return WatchedBoard(provider: provider, token: token);
}
