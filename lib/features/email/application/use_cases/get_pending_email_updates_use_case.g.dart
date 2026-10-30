// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pending_email_updates_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getPendingEmailUpdatesUseCase)
final getPendingEmailUpdatesUseCaseProvider =
    GetPendingEmailUpdatesUseCaseProvider._();

final class GetPendingEmailUpdatesUseCaseProvider
    extends
        $FunctionalProvider<
          GetPendingEmailUpdatesUseCase,
          GetPendingEmailUpdatesUseCase,
          GetPendingEmailUpdatesUseCase
        >
    with $Provider<GetPendingEmailUpdatesUseCase> {
  GetPendingEmailUpdatesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPendingEmailUpdatesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPendingEmailUpdatesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPendingEmailUpdatesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPendingEmailUpdatesUseCase create(Ref ref) {
    return getPendingEmailUpdatesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPendingEmailUpdatesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPendingEmailUpdatesUseCase>(
        value,
      ),
    );
  }
}

String _$getPendingEmailUpdatesUseCaseHash() =>
    r'20fcd659563c38b481347fd49d6efcfb1ffc7973';
