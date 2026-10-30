// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getProfileUseCase)
final getProfileUseCaseProvider = GetProfileUseCaseProvider._();

final class GetProfileUseCaseProvider
    extends
        $FunctionalProvider<
          GetProfileUseCase,
          GetProfileUseCase,
          GetProfileUseCase
        >
    with $Provider<GetProfileUseCase> {
  GetProfileUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProfileUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProfileUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetProfileUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetProfileUseCase create(Ref ref) {
    return getProfileUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetProfileUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetProfileUseCase>(value),
    );
  }
}

String _$getProfileUseCaseHash() => r'266d2de4affc110a7f9efb90e474373d83eb08d4';
