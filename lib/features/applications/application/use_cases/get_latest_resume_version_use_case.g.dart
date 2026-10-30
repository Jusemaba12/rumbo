// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_latest_resume_version_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getLatestResumeVersionUseCase)
final getLatestResumeVersionUseCaseProvider =
    GetLatestResumeVersionUseCaseProvider._();

final class GetLatestResumeVersionUseCaseProvider
    extends
        $FunctionalProvider<
          GetLatestResumeVersionUseCase,
          GetLatestResumeVersionUseCase,
          GetLatestResumeVersionUseCase
        >
    with $Provider<GetLatestResumeVersionUseCase> {
  GetLatestResumeVersionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLatestResumeVersionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLatestResumeVersionUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetLatestResumeVersionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetLatestResumeVersionUseCase create(Ref ref) {
    return getLatestResumeVersionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLatestResumeVersionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLatestResumeVersionUseCase>(
        value,
      ),
    );
  }
}

String _$getLatestResumeVersionUseCaseHash() =>
    r'eb88dd722321cb53cf749abd927dd6282b896c88';
