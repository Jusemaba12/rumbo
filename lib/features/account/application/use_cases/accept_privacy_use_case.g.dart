// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_privacy_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(acceptPrivacyUseCase)
final acceptPrivacyUseCaseProvider = AcceptPrivacyUseCaseProvider._();

final class AcceptPrivacyUseCaseProvider
    extends
        $FunctionalProvider<
          AcceptPrivacyUseCase,
          AcceptPrivacyUseCase,
          AcceptPrivacyUseCase
        >
    with $Provider<AcceptPrivacyUseCase> {
  AcceptPrivacyUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'acceptPrivacyUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$acceptPrivacyUseCaseHash();

  @$internal
  @override
  $ProviderElement<AcceptPrivacyUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AcceptPrivacyUseCase create(Ref ref) {
    return acceptPrivacyUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AcceptPrivacyUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AcceptPrivacyUseCase>(value),
    );
  }
}

String _$acceptPrivacyUseCaseHash() =>
    r'679c8037212f68a05de8a8a6b76f717e20494c69';
