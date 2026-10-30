// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_latest_android_release_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getLatestAndroidReleaseUseCase)
final getLatestAndroidReleaseUseCaseProvider =
    GetLatestAndroidReleaseUseCaseProvider._();

final class GetLatestAndroidReleaseUseCaseProvider
    extends
        $FunctionalProvider<
          GetLatestAndroidReleaseUseCase,
          GetLatestAndroidReleaseUseCase,
          GetLatestAndroidReleaseUseCase
        >
    with $Provider<GetLatestAndroidReleaseUseCase> {
  GetLatestAndroidReleaseUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLatestAndroidReleaseUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLatestAndroidReleaseUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetLatestAndroidReleaseUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetLatestAndroidReleaseUseCase create(Ref ref) {
    return getLatestAndroidReleaseUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLatestAndroidReleaseUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLatestAndroidReleaseUseCase>(
        value,
      ),
    );
  }
}

String _$getLatestAndroidReleaseUseCaseHash() =>
    r'586020054e6da93c2d0f8d024906b8bea064d224';
