// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_sign_in_code_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(verifySignInCodeUseCase)
final verifySignInCodeUseCaseProvider = VerifySignInCodeUseCaseProvider._();

final class VerifySignInCodeUseCaseProvider
    extends
        $FunctionalProvider<
          VerifySignInCodeUseCase,
          VerifySignInCodeUseCase,
          VerifySignInCodeUseCase
        >
    with $Provider<VerifySignInCodeUseCase> {
  VerifySignInCodeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifySignInCodeUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifySignInCodeUseCaseHash();

  @$internal
  @override
  $ProviderElement<VerifySignInCodeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VerifySignInCodeUseCase create(Ref ref) {
    return verifySignInCodeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerifySignInCodeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerifySignInCodeUseCase>(value),
    );
  }
}

String _$verifySignInCodeUseCaseHash() =>
    r'86f411289ce9831f5179f3809f81a4c90530842a';
