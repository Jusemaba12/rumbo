// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_email_sync_key_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(createEmailSyncKeyUseCase)
final createEmailSyncKeyUseCaseProvider = CreateEmailSyncKeyUseCaseProvider._();

final class CreateEmailSyncKeyUseCaseProvider
    extends
        $FunctionalProvider<
          CreateEmailSyncKeyUseCase,
          CreateEmailSyncKeyUseCase,
          CreateEmailSyncKeyUseCase
        >
    with $Provider<CreateEmailSyncKeyUseCase> {
  CreateEmailSyncKeyUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createEmailSyncKeyUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createEmailSyncKeyUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateEmailSyncKeyUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateEmailSyncKeyUseCase create(Ref ref) {
    return createEmailSyncKeyUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateEmailSyncKeyUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateEmailSyncKeyUseCase>(value),
    );
  }
}

String _$createEmailSyncKeyUseCaseHash() =>
    r'ec6a07f6f3cd703646376ba917100b891ccaa881';
