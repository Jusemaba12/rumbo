// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LearningController)
final learningControllerProvider = LearningControllerProvider._();

final class LearningControllerProvider
    extends $AsyncNotifierProvider<LearningController, List<LearningTopic>> {
  LearningControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningControllerHash();

  @$internal
  @override
  LearningController create() => LearningController();
}

String _$learningControllerHash() =>
    r'eb8f09fd26c64c673b8936ac34cf614fcf03bd36';

abstract class _$LearningController
    extends $AsyncNotifier<List<LearningTopic>> {
  FutureOr<List<LearningTopic>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<LearningTopic>>, List<LearningTopic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<LearningTopic>>, List<LearningTopic>>,
              AsyncValue<List<LearningTopic>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Sugerencias de qué aprender con lo que la app ya sabe del usuario.

@ProviderFor(learningCandidates)
final learningCandidatesProvider = LearningCandidatesProvider._();

/// Sugerencias de qué aprender con lo que la app ya sabe del usuario.

final class LearningCandidatesProvider
    extends
        $FunctionalProvider<
          List<LearningCandidate>,
          List<LearningCandidate>,
          List<LearningCandidate>
        >
    with $Provider<List<LearningCandidate>> {
  /// Sugerencias de qué aprender con lo que la app ya sabe del usuario.
  LearningCandidatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningCandidatesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningCandidatesHash();

  @$internal
  @override
  $ProviderElement<List<LearningCandidate>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<LearningCandidate> create(Ref ref) {
    return learningCandidates(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<LearningCandidate> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<LearningCandidate>>(value),
    );
  }
}

String _$learningCandidatesHash() =>
    r'fb4da2732126eae5142469897e2c85235f0625c5';
