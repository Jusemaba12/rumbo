// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_learning_topic_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(addLearningTopicUseCase)
final addLearningTopicUseCaseProvider = AddLearningTopicUseCaseProvider._();

final class AddLearningTopicUseCaseProvider
    extends
        $FunctionalProvider<
          AddLearningTopicUseCase,
          AddLearningTopicUseCase,
          AddLearningTopicUseCase
        >
    with $Provider<AddLearningTopicUseCase> {
  AddLearningTopicUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addLearningTopicUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addLearningTopicUseCaseHash();

  @$internal
  @override
  $ProviderElement<AddLearningTopicUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AddLearningTopicUseCase create(Ref ref) {
    return addLearningTopicUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddLearningTopicUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddLearningTopicUseCase>(value),
    );
  }
}

String _$addLearningTopicUseCaseHash() =>
    r'1c5871541b49d58d4edef5e80e253ef87e632817';
