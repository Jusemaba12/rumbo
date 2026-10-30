// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_job_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(completeJobUseCase)
final completeJobUseCaseProvider = CompleteJobUseCaseProvider._();

final class CompleteJobUseCaseProvider
    extends
        $FunctionalProvider<
          CompleteJobUseCase,
          CompleteJobUseCase,
          CompleteJobUseCase
        >
    with $Provider<CompleteJobUseCase> {
  CompleteJobUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completeJobUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completeJobUseCaseHash();

  @$internal
  @override
  $ProviderElement<CompleteJobUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompleteJobUseCase create(Ref ref) {
    return completeJobUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompleteJobUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompleteJobUseCase>(value),
    );
  }
}

String _$completeJobUseCaseHash() =>
    r'bd9acb94754c6169a60b41708b600185b5efe3dd';
