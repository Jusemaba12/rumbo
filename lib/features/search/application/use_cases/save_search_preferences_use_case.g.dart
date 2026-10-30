// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_search_preferences_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveSearchPreferencesUseCase)
final saveSearchPreferencesUseCaseProvider =
    SaveSearchPreferencesUseCaseProvider._();

final class SaveSearchPreferencesUseCaseProvider
    extends
        $FunctionalProvider<
          SaveSearchPreferencesUseCase,
          SaveSearchPreferencesUseCase,
          SaveSearchPreferencesUseCase
        >
    with $Provider<SaveSearchPreferencesUseCase> {
  SaveSearchPreferencesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveSearchPreferencesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveSearchPreferencesUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveSearchPreferencesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveSearchPreferencesUseCase create(Ref ref) {
    return saveSearchPreferencesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveSearchPreferencesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveSearchPreferencesUseCase>(value),
    );
  }
}

String _$saveSearchPreferencesUseCaseHash() =>
    r'ec6cb6b062ff2b38a073b8263fe1854f65327946';
