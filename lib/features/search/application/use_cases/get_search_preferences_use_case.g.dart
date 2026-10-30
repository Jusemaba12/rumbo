// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_search_preferences_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getSearchPreferencesUseCase)
final getSearchPreferencesUseCaseProvider =
    GetSearchPreferencesUseCaseProvider._();

final class GetSearchPreferencesUseCaseProvider
    extends
        $FunctionalProvider<
          GetSearchPreferencesUseCase,
          GetSearchPreferencesUseCase,
          GetSearchPreferencesUseCase
        >
    with $Provider<GetSearchPreferencesUseCase> {
  GetSearchPreferencesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSearchPreferencesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSearchPreferencesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetSearchPreferencesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetSearchPreferencesUseCase create(Ref ref) {
    return getSearchPreferencesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSearchPreferencesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSearchPreferencesUseCase>(value),
    );
  }
}

String _$getSearchPreferencesUseCaseHash() =>
    r'7fa15f385327c1847b5a11b5081cbf4dd0c392c8';
