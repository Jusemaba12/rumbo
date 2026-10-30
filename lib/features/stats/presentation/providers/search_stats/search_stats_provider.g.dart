// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Embudo, tiempos de respuesta y brechas de la búsqueda.

@ProviderFor(searchStats)
final searchStatsProvider = SearchStatsProvider._();

/// Embudo, tiempos de respuesta y brechas de la búsqueda.

final class SearchStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<SearchStats>,
          SearchStats,
          FutureOr<SearchStats>
        >
    with $FutureModifier<SearchStats>, $FutureProvider<SearchStats> {
  /// Embudo, tiempos de respuesta y brechas de la búsqueda.
  SearchStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchStatsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchStatsHash();

  @$internal
  @override
  $FutureProviderElement<SearchStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SearchStats> create(Ref ref) {
    return searchStats(ref);
  }
}

String _$searchStatsHash() => r'021c44df5277e0952dd0c688bd68332b3efd93df';
