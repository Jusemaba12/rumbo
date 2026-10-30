// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_jobs_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getJobsUseCase)
final getJobsUseCaseProvider = GetJobsUseCaseProvider._();

final class GetJobsUseCaseProvider
    extends $FunctionalProvider<GetJobsUseCase, GetJobsUseCase, GetJobsUseCase>
    with $Provider<GetJobsUseCase> {
  GetJobsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getJobsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getJobsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetJobsUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetJobsUseCase create(Ref ref) {
    return getJobsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetJobsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetJobsUseCase>(value),
    );
  }
}

String _$getJobsUseCaseHash() => r'd660f208d089e2936f8eb6980660dfa92af4117a';
