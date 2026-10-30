// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_privacy_accepted_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isPrivacyAcceptedUseCase)
final isPrivacyAcceptedUseCaseProvider = IsPrivacyAcceptedUseCaseProvider._();

final class IsPrivacyAcceptedUseCaseProvider
    extends
        $FunctionalProvider<
          IsPrivacyAcceptedUseCase,
          IsPrivacyAcceptedUseCase,
          IsPrivacyAcceptedUseCase
        >
    with $Provider<IsPrivacyAcceptedUseCase> {
  IsPrivacyAcceptedUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isPrivacyAcceptedUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isPrivacyAcceptedUseCaseHash();

  @$internal
  @override
  $ProviderElement<IsPrivacyAcceptedUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IsPrivacyAcceptedUseCase create(Ref ref) {
    return isPrivacyAcceptedUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IsPrivacyAcceptedUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IsPrivacyAcceptedUseCase>(value),
    );
  }
}

String _$isPrivacyAcceptedUseCaseHash() =>
    r'3fa498d456114bfcd05d6cf14e0aca20ac1228c2';
