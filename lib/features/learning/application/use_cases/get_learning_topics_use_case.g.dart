// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_learning_topics_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getLearningTopicsUseCase)
final getLearningTopicsUseCaseProvider = GetLearningTopicsUseCaseProvider._();

final class GetLearningTopicsUseCaseProvider
    extends
        $FunctionalProvider<
          GetLearningTopicsUseCase,
          GetLearningTopicsUseCase,
          GetLearningTopicsUseCase
        >
    with $Provider<GetLearningTopicsUseCase> {
  GetLearningTopicsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLearningTopicsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLearningTopicsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetLearningTopicsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetLearningTopicsUseCase create(Ref ref) {
    return getLearningTopicsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLearningTopicsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLearningTopicsUseCase>(value),
    );
  }
}

String _$getLearningTopicsUseCaseHash() =>
    r'ea9a0a4443720e9d990c6fd9cb271cd97d283b7a';
