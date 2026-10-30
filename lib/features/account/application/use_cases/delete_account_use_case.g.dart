// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteAccountUseCase)
final deleteAccountUseCaseProvider = DeleteAccountUseCaseProvider._();

final class DeleteAccountUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteAccountUseCase,
          DeleteAccountUseCase,
          DeleteAccountUseCase
        >
    with $Provider<DeleteAccountUseCase> {
  DeleteAccountUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteAccountUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteAccountUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteAccountUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteAccountUseCase create(Ref ref) {
    return deleteAccountUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteAccountUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteAccountUseCase>(value),
    );
  }
}

String _$deleteAccountUseCaseHash() =>
    r'bddd1c84e83d79ccece9d349296c53e5db246299';
