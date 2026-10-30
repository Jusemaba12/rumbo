// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_profile_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveProfileUseCase)
final saveProfileUseCaseProvider = SaveProfileUseCaseProvider._();

final class SaveProfileUseCaseProvider
    extends
        $FunctionalProvider<
          SaveProfileUseCase,
          SaveProfileUseCase,
          SaveProfileUseCase
        >
    with $Provider<SaveProfileUseCase> {
  SaveProfileUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveProfileUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveProfileUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveProfileUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveProfileUseCase create(Ref ref) {
    return saveProfileUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveProfileUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveProfileUseCase>(value),
    );
  }
}

String _$saveProfileUseCaseHash() =>
    r'92e70286c19a1ad808c5e8cebea98402f47fd664';
