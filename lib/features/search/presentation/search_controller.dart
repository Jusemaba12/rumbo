import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/time/clock.dart';
import '../../auth/data/auth_repository.dart';
import '../../jobs/presentation/jobs_controller.dart';
import '../data/search_repository.dart';
import '../domain/search_preferences.dart';

part 'search_controller.freezed.dart';
part 'search_controller.g.dart';

@Riverpod(keepAlive: true)
Future<SearchPreferences?> searchPreferences(Ref ref) {
  ref.watch(sessionChangesProvider);
  return ref.watch(searchRepositoryProvider).loadPreferences();
}

/// Estado de la búsqueda en curso o de la última terminada.
@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState.idle() = SearchIdle;
  const factory SearchState.running() = SearchRunning;
  const factory SearchState.done(SearchSummary summary) = SearchDone;
  const factory SearchState.failed(SearchFailure reason) = SearchFailed;
}

@Riverpod(keepAlive: true)
class JobSearchController extends _$JobSearchController {
  @override
  SearchState build() => const SearchIdle();

  /// Busca solo si hay preferencias y la última búsqueda es antigua.
  Future<void> runIfStale() async {
    final preferences = await ref.read(searchPreferencesProvider.future);
    final now = ref.read(clockProvider)();
    if (preferences == null ||
        !preferences.isConfigured ||
        !preferences.isStale(now) ||
        state is SearchRunning) {
      return;
    }
    await run();
  }

  Future<void> run() async {
    if (state is SearchRunning) return;
    state = const SearchRunning();
    try {
      final summary = await ref.read(searchRepositoryProvider).search();
      await ref.read(jobsControllerProvider.notifier).reload();
      state = SearchDone(summary);
    } on SearchException catch (error) {
      state = SearchFailed(error.reason);
    } catch (_) {
      state = const SearchFailed(SearchFailure.other);
    }
    ref.invalidate(searchPreferencesProvider);
  }
}
