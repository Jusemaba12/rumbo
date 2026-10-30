// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_learning_plan_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(generateLearningPlanUseCase)
final generateLearningPlanUseCaseProvider =
    GenerateLearningPlanUseCaseProvider._();

final class GenerateLearningPlanUseCaseProvider
    extends
        $FunctionalProvider<
          GenerateLearningPlanUseCase,
          GenerateLearningPlanUseCase,
          GenerateLearningPlanUseCase
        >
    with $Provider<GenerateLearningPlanUseCase> {
  GenerateLearningPlanUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generateLearningPlanUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generateLearningPlanUseCaseHash();

  @$internal
  @override
  $ProviderElement<GenerateLearningPlanUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GenerateLearningPlanUseCase create(Ref ref) {
    return generateLearningPlanUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GenerateLearningPlanUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GenerateLearningPlanUseCase>(value),
    );
  }
}

String _$generateLearningPlanUseCaseHash() =>
    r'234d40150c7cc87ed024ebe6c20a3ea45d799070';
