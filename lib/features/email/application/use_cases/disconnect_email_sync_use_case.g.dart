// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disconnect_email_sync_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(disconnectEmailSyncUseCase)
final disconnectEmailSyncUseCaseProvider =
    DisconnectEmailSyncUseCaseProvider._();

final class DisconnectEmailSyncUseCaseProvider
    extends
        $FunctionalProvider<
          DisconnectEmailSyncUseCase,
          DisconnectEmailSyncUseCase,
          DisconnectEmailSyncUseCase
        >
    with $Provider<DisconnectEmailSyncUseCase> {
  DisconnectEmailSyncUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'disconnectEmailSyncUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$disconnectEmailSyncUseCaseHash();

  @$internal
  @override
  $ProviderElement<DisconnectEmailSyncUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DisconnectEmailSyncUseCase create(Ref ref) {
    return disconnectEmailSyncUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DisconnectEmailSyncUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DisconnectEmailSyncUseCase>(value),
    );
  }
}

String _$disconnectEmailSyncUseCaseHash() =>
    r'18fc086c5f5d909d5f8f09315850f741faabe55a';
