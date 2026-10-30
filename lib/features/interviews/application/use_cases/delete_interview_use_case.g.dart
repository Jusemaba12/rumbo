// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_interview_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteInterviewUseCase)
final deleteInterviewUseCaseProvider = DeleteInterviewUseCaseProvider._();

final class DeleteInterviewUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteInterviewUseCase,
          DeleteInterviewUseCase,
          DeleteInterviewUseCase
        >
    with $Provider<DeleteInterviewUseCase> {
  DeleteInterviewUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteInterviewUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteInterviewUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteInterviewUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteInterviewUseCase create(Ref ref) {
    return deleteInterviewUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteInterviewUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteInterviewUseCase>(value),
    );
  }
}

String _$deleteInterviewUseCaseHash() =>
    r'a498a7e7a3a4da8cce1781831d12ddd7f71c2730';
