// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_application_events_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getApplicationEventsUseCase)
final getApplicationEventsUseCaseProvider =
    GetApplicationEventsUseCaseProvider._();

final class GetApplicationEventsUseCaseProvider
    extends
        $FunctionalProvider<
          GetApplicationEventsUseCase,
          GetApplicationEventsUseCase,
          GetApplicationEventsUseCase
        >
    with $Provider<GetApplicationEventsUseCase> {
  GetApplicationEventsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getApplicationEventsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getApplicationEventsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetApplicationEventsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetApplicationEventsUseCase create(Ref ref) {
    return getApplicationEventsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetApplicationEventsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetApplicationEventsUseCase>(value),
    );
  }
}

String _$getApplicationEventsUseCaseHash() =>
    r'5f12e899d6975cdc82e1839e22d142aee93935fe';
