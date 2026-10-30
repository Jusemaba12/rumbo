import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/domain/entities/search_summary.dart';
import 'package:rumbo/shared/domain/result.dart';

abstract interface class SearchRepository {
  /// Nulo si el usuario aún no configuró la búsqueda.
  Future<Result<SearchPreferences?>> loadPreferences();

  Future<Result<void>> savePreferences(SearchPreferences preferences);

  /// Busca en los portales y guarda las sugerencias nuevas. Falla con
  /// `NoPreferencesFailure` o `TooSoonFailure`.
  Future<Result<SearchSummary>> search();
}
