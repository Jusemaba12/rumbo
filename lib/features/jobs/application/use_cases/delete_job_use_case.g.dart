// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_job_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteJobUseCase)
final deleteJobUseCaseProvider = DeleteJobUseCaseProvider._();

final class DeleteJobUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteJobUseCase,
          DeleteJobUseCase,
          DeleteJobUseCase
        >
    with $Provider<DeleteJobUseCase> {
  DeleteJobUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteJobUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteJobUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteJobUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteJobUseCase create(Ref ref) {
    return deleteJobUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteJobUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteJobUseCase>(value),
    );
  }
}

String _$deleteJobUseCaseHash() => r'0623f856c87edf39b9518758885487553574d909';
