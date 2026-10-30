import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/domain/entities/search_summary.dart';
import 'package:rumbo/features/search/domain/repositories/search_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Modo local y tests: guarda preferencias y no busca en internet.
class InMemorySearchRepository implements SearchRepository {
  InMemorySearchRepository({this.preferences, this.onSearch});

  SearchPreferences? preferences;
  final Future<Result<SearchSummary>> Function()? onSearch;
  int searches = 0;

  @override
  Future<Result<SearchPreferences?>> loadPreferences() async =>
      Ok<SearchPreferences?>(preferences);

  @override
  Future<Result<void>> savePreferences(SearchPreferences value) async {
    preferences = value;
    return ok;
  }

  @override
  Future<Result<SearchSummary>> search() async {
    searches++;
    preferences = preferences?.copyWith(lastRunAt: DateTime.now());
    return await onSearch?.call() ??
        const Ok<SearchSummary>(
          SearchSummary(found: 0, scored: 0, suggested: 0),
        );
  }
}
