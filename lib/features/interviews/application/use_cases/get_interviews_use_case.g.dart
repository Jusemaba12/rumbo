// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_interviews_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getInterviewsUseCase)
final getInterviewsUseCaseProvider = GetInterviewsUseCaseProvider._();

final class GetInterviewsUseCaseProvider
    extends
        $FunctionalProvider<
          GetInterviewsUseCase,
          GetInterviewsUseCase,
          GetInterviewsUseCase
        >
    with $Provider<GetInterviewsUseCase> {
  GetInterviewsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getInterviewsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getInterviewsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetInterviewsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetInterviewsUseCase create(Ref ref) {
    return getInterviewsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetInterviewsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetInterviewsUseCase>(value),
    );
  }
}

String _$getInterviewsUseCaseHash() =>
    r'47ff010e44cdcdf9ee868baf963bea614baf38fb';
