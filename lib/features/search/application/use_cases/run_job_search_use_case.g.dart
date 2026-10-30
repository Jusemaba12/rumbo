// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_job_search_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(runJobSearchUseCase)
final runJobSearchUseCaseProvider = RunJobSearchUseCaseProvider._();

final class RunJobSearchUseCaseProvider
    extends
        $FunctionalProvider<
          RunJobSearchUseCase,
          RunJobSearchUseCase,
          RunJobSearchUseCase
        >
    with $Provider<RunJobSearchUseCase> {
  RunJobSearchUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runJobSearchUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runJobSearchUseCaseHash();

  @$internal
  @override
  $ProviderElement<RunJobSearchUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RunJobSearchUseCase create(Ref ref) {
    return runJobSearchUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RunJobSearchUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RunJobSearchUseCase>(value),
    );
  }
}

String _$runJobSearchUseCaseHash() =>
    r'9556a8ea2560f56885f3f354ea48eada80c28c8f';
