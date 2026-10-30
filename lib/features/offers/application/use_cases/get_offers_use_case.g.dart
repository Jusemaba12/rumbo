// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_offers_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getOffersUseCase)
final getOffersUseCaseProvider = GetOffersUseCaseProvider._();

final class GetOffersUseCaseProvider
    extends
        $FunctionalProvider<
          GetOffersUseCase,
          GetOffersUseCase,
          GetOffersUseCase
        >
    with $Provider<GetOffersUseCase> {
  GetOffersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getOffersUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getOffersUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetOffersUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetOffersUseCase create(Ref ref) {
    return getOffersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetOffersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetOffersUseCase>(value),
    );
  }
}

String _$getOffersUseCaseHash() => r'2ef9909dd3176d1d4bb04faaf630a429a062d9f3';
