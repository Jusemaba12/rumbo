import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rumbo/features/search/domain/entities/search_summary.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';

part 'search_state.freezed.dart';

/// Estado de la búsqueda en curso o de la última terminada.
@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState.idle() = SearchIdle;
  const factory SearchState.running() = SearchRunning;
  const factory SearchState.done(SearchSummary summary) = SearchDone;
  const factory SearchState.failed(Failure failure) = SearchFailed;
}
