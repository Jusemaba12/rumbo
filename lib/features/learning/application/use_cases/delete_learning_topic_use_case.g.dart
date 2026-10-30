// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_learning_topic_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteLearningTopicUseCase)
final deleteLearningTopicUseCaseProvider =
    DeleteLearningTopicUseCaseProvider._();

final class DeleteLearningTopicUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteLearningTopicUseCase,
          DeleteLearningTopicUseCase,
          DeleteLearningTopicUseCase
        >
    with $Provider<DeleteLearningTopicUseCase> {
  DeleteLearningTopicUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteLearningTopicUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteLearningTopicUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteLearningTopicUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteLearningTopicUseCase create(Ref ref) {
    return deleteLearningTopicUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteLearningTopicUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteLearningTopicUseCase>(value),
    );
  }
}

String _$deleteLearningTopicUseCaseHash() =>
    r'4adaf152ab06dfee99337a5ae8f41250ecea4ef5';
