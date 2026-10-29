// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(learningRepository)
final learningRepositoryProvider = LearningRepositoryProvider._();

final class LearningRepositoryProvider
    extends
        $FunctionalProvider<
          LearningRepository,
          LearningRepository,
          LearningRepository
        >
    with $Provider<LearningRepository> {
  LearningRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningRepositoryHash();

  @$internal
  @override
  $ProviderElement<LearningRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LearningRepository create(Ref ref) {
    return learningRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearningRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearningRepository>(value),
    );
  }
}

String _$learningRepositoryHash() =>
    r'8837d442f6082fcfa65e66f17cedb69e6bdf16fd';

/// Nulo en modo local: necesita el servidor.

@ProviderFor(learningPlanner)
final learningPlannerProvider = LearningPlannerProvider._();

/// Nulo en modo local: necesita el servidor.

final class LearningPlannerProvider
    extends
        $FunctionalProvider<
          LearningPlanner?,
          LearningPlanner?,
          LearningPlanner?
        >
    with $Provider<LearningPlanner?> {
  /// Nulo en modo local: necesita el servidor.
  LearningPlannerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningPlannerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningPlannerHash();

  @$internal
  @override
  $ProviderElement<LearningPlanner?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LearningPlanner? create(Ref ref) {
    return learningPlanner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearningPlanner? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearningPlanner?>(value),
    );
  }
}

String _$learningPlannerHash() => r'3411a777da38a36cc6402b1c5675735408db22a9';
