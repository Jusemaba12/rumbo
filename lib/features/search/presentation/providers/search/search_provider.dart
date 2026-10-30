import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/search/application/use_cases/get_search_preferences_use_case.dart';
import 'package:rumbo/features/search/application/use_cases/run_job_search_use_case.dart';
import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/domain/entities/search_summary.dart';
import 'package:rumbo/features/search/presentation/providers/search/search_state.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'search_provider.g.dart';

@Riverpod(keepAlive: true)
Future<SearchPreferences?> searchPreferences(Ref ref) async {
  ref.watch(sessionChangesProvider);
  return (await ref.watch(getSearchPreferencesUseCaseProvider)()).getOrThrow();
}

@Riverpod(keepAlive: true)
class JobSearchController extends _$JobSearchController {
  @override
  SearchState build() => const SearchIdle();

  /// Busca solo si hay preferencias y la última búsqueda es antigua.
  Future<void> runIfStale() async {
    final SearchPreferences? preferences = await ref.read(
      searchPreferencesProvider.future,
    );
    final DateTime now = ref.read(clockProvider)();
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
    final Result<SearchSummary> result = await ref.read(
      runJobSearchUseCaseProvider,
    )();
    switch (result) {
      case Ok<SearchSummary>(value: final SearchSummary summary):
        await ref.read(jobsControllerProvider.notifier).reload();
        state = SearchDone(summary);
      case Err<SearchSummary>(:final Failure failure):
        state = SearchFailed(failure);
    }
    ref.invalidate(searchPreferencesProvider);
  }
}
