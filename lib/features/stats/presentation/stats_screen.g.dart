// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchStats)
final searchStatsProvider = SearchStatsProvider._();

final class SearchStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<SearchStats>,
          SearchStats,
          FutureOr<SearchStats>
        >
    with $FutureModifier<SearchStats>, $FutureProvider<SearchStats> {
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

String _$searchStatsHash() => r'77ae1c84a76ccbfb10d15d770759d8ebf3e48677';
