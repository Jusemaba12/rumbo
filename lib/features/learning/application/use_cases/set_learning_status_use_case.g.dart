// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_learning_status_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(setLearningStatusUseCase)
final setLearningStatusUseCaseProvider = SetLearningStatusUseCaseProvider._();

final class SetLearningStatusUseCaseProvider
    extends
        $FunctionalProvider<
          SetLearningStatusUseCase,
          SetLearningStatusUseCase,
          SetLearningStatusUseCase
        >
    with $Provider<SetLearningStatusUseCase> {
  SetLearningStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setLearningStatusUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setLearningStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<SetLearningStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SetLearningStatusUseCase create(Ref ref) {
    return setLearningStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetLearningStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetLearningStatusUseCase>(value),
    );
  }
}

String _$setLearningStatusUseCaseHash() =>
    r'061c4af02fba0fa3165fc17ad8b82357736d4890';
