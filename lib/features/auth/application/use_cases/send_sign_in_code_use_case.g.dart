// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_sign_in_code_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sendSignInCodeUseCase)
final sendSignInCodeUseCaseProvider = SendSignInCodeUseCaseProvider._();

final class SendSignInCodeUseCaseProvider
    extends
        $FunctionalProvider<
          SendSignInCodeUseCase,
          SendSignInCodeUseCase,
          SendSignInCodeUseCase
        >
    with $Provider<SendSignInCodeUseCase> {
  SendSignInCodeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendSignInCodeUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendSignInCodeUseCaseHash();

  @$internal
  @override
  $ProviderElement<SendSignInCodeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SendSignInCodeUseCase create(Ref ref) {
    return sendSignInCodeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendSignInCodeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendSignInCodeUseCase>(value),
    );
  }
}

String _$sendSignInCodeUseCaseHash() =>
    r'4ac322ac9316ef6f42e9f635ab73ee3f85177d20';
