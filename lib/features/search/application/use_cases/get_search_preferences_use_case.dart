import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/domain/repositories/search_repository.dart';
import 'package:rumbo/features/search/infrastructure/di/search_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_search_preferences_use_case.g.dart';

/// Preferencias de búsqueda; nulas si aún no se configuraron.
class GetSearchPreferencesUseCase {
  const GetSearchPreferencesUseCase({required this._repository});

  final SearchRepository _repository;

  Future<Result<SearchPreferences?>> call() => _repository.loadPreferences();
}

@Riverpod(keepAlive: true)
GetSearchPreferencesUseCase getSearchPreferencesUseCase(Ref ref) =>
    GetSearchPreferencesUseCase(
      repository: ref.watch(searchRepositoryProvider),
    );
