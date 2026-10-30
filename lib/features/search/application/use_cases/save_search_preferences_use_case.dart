import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/domain/repositories/search_repository.dart';
import 'package:rumbo/features/search/infrastructure/di/search_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_search_preferences_use_case.g.dart';

/// Guarda las preferencias de búsqueda.
class SaveSearchPreferencesUseCase {
  const SaveSearchPreferencesUseCase({required this._repository});

  final SearchRepository _repository;

  Future<Result<void>> call(SearchPreferences preferences) =>
      _repository.savePreferences(preferences);
}

@Riverpod(keepAlive: true)
SaveSearchPreferencesUseCase saveSearchPreferencesUseCase(Ref ref) =>
    SaveSearchPreferencesUseCase(
      repository: ref.watch(searchRepositoryProvider),
    );
