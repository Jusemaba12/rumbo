// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_offer_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveOfferUseCase)
final saveOfferUseCaseProvider = SaveOfferUseCaseProvider._();

final class SaveOfferUseCaseProvider
    extends
        $FunctionalProvider<
          SaveOfferUseCase,
          SaveOfferUseCase,
          SaveOfferUseCase
        >
    with $Provider<SaveOfferUseCase> {
  SaveOfferUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveOfferUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveOfferUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveOfferUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveOfferUseCase create(Ref ref) {
    return saveOfferUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveOfferUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveOfferUseCase>(value),
    );
  }
}

String _$saveOfferUseCaseHash() => r'b72adc6681587d1e35019a2ae17f3ed363c181a9';
