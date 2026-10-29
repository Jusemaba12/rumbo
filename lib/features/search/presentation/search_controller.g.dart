// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchPreferences)
final searchPreferencesProvider = SearchPreferencesProvider._();

final class SearchPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SearchPreferences?>,
          SearchPreferences?,
          FutureOr<SearchPreferences?>
        >
    with
        $FutureModifier<SearchPreferences?>,
        $FutureProvider<SearchPreferences?> {
  SearchPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SearchPreferences?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SearchPreferences?> create(Ref ref) {
    return searchPreferences(ref);
  }
}

String _$searchPreferencesHash() => r'48cc61a1fafcf8cadb0e25bc968bdb5b2762e79c';

@ProviderFor(JobSearchController)
final jobSearchControllerProvider = JobSearchControllerProvider._();

final class JobSearchControllerProvider
    extends $NotifierProvider<JobSearchController, SearchState> {
  JobSearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jobSearchControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jobSearchControllerHash();

  @$internal
  @override
  JobSearchController create() => JobSearchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchState>(value),
    );
  }
}

String _$jobSearchControllerHash() =>
    r'0e4df364091ed624f59cec204d57c469ec0efc68';

abstract class _$JobSearchController extends $Notifier<SearchState> {
  SearchState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SearchState, SearchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchState, SearchState>,
              SearchState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
