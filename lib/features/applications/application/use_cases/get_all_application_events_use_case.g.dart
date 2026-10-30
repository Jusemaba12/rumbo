// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_application_events_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAllApplicationEventsUseCase)
final getAllApplicationEventsUseCaseProvider =
    GetAllApplicationEventsUseCaseProvider._();

final class GetAllApplicationEventsUseCaseProvider
    extends
        $FunctionalProvider<
          GetAllApplicationEventsUseCase,
          GetAllApplicationEventsUseCase,
          GetAllApplicationEventsUseCase
        >
    with $Provider<GetAllApplicationEventsUseCase> {
  GetAllApplicationEventsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllApplicationEventsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllApplicationEventsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAllApplicationEventsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAllApplicationEventsUseCase create(Ref ref) {
    return getAllApplicationEventsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllApplicationEventsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllApplicationEventsUseCase>(
        value,
      ),
    );
  }
}

String _$getAllApplicationEventsUseCaseHash() =>
    r'989f09c63cfce8d115c0e1aac91189d742180479';
