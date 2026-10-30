// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_answer_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteAnswerUseCase)
final deleteAnswerUseCaseProvider = DeleteAnswerUseCaseProvider._();

final class DeleteAnswerUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteAnswerUseCase,
          DeleteAnswerUseCase,
          DeleteAnswerUseCase
        >
    with $Provider<DeleteAnswerUseCase> {
  DeleteAnswerUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteAnswerUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteAnswerUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteAnswerUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteAnswerUseCase create(Ref ref) {
    return deleteAnswerUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteAnswerUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteAnswerUseCase>(value),
    );
  }
}

String _$deleteAnswerUseCaseHash() =>
    r'4e72dcde13d9593563554f589caf0733906bfe89';
