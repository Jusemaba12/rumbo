// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_email_sync_status_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getEmailSyncStatusUseCase)
final getEmailSyncStatusUseCaseProvider = GetEmailSyncStatusUseCaseProvider._();

final class GetEmailSyncStatusUseCaseProvider
    extends
        $FunctionalProvider<
          GetEmailSyncStatusUseCase,
          GetEmailSyncStatusUseCase,
          GetEmailSyncStatusUseCase
        >
    with $Provider<GetEmailSyncStatusUseCase> {
  GetEmailSyncStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getEmailSyncStatusUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getEmailSyncStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetEmailSyncStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetEmailSyncStatusUseCase create(Ref ref) {
    return getEmailSyncStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetEmailSyncStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetEmailSyncStatusUseCase>(value),
    );
  }
}

String _$getEmailSyncStatusUseCaseHash() =>
    r'29b4b80667d4a63100c243eae37cc5a076e85c6c';
