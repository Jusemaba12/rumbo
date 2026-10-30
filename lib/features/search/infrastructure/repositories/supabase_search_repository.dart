import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/domain/entities/search_summary.dart';
import 'package:rumbo/features/search/domain/failures/search_failures.dart';
import 'package:rumbo/features/search/domain/repositories/search_repository.dart';
import 'package:rumbo/features/search/infrastructure/mappers/search_preferences_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSearchRepository implements SearchRepository {
  SupabaseSearchRepository(this._client);

  static const String _tag = 'SupabaseSearchRepository';

  final SupabaseClient _client;

  @override
  Future<Result<SearchPreferences?>> loadPreferences() => guard(
    tag: _tag,
    run: () async {
      final PostgrestMap? row = await _client
          .from('search_preferences')
          .select()
          .maybeSingle();
      return row == null ? null : preferencesFromRow(row);
    },
  );

  @override
  Future<Result<void>> savePreferences(SearchPreferences preferences) => guard(
    tag: _tag,
    run: () => _client
        .from('search_preferences')
        .upsert(
          preferencesToRow(preferences, userId: _client.auth.currentUser!.id),
        ),
  );

  @override
  Future<Result<SearchSummary>> search() => guard(
    tag: _tag,
    run: () async {
      try {
        return SearchSummary.fromJson(
          await invokeAiJson(functions: _client.functions, name: 'search-jobs'),
        );
      } on FunctionException catch (error) {
        throw switch ((error.status, functionErrorCode(error))) {
          (422, 'no_preferences') => const NoPreferencesFailure(),
          (429, 'too_soon') => const TooSoonFailure(),
          _ => error,
        };
      }
    },
  );
}
