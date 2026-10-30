// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_interview_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveInterviewUseCase)
final saveInterviewUseCaseProvider = SaveInterviewUseCaseProvider._();

final class SaveInterviewUseCaseProvider
    extends
        $FunctionalProvider<
          SaveInterviewUseCase,
          SaveInterviewUseCase,
          SaveInterviewUseCase
        >
    with $Provider<SaveInterviewUseCase> {
  SaveInterviewUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveInterviewUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveInterviewUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveInterviewUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveInterviewUseCase create(Ref ref) {
    return saveInterviewUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveInterviewUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveInterviewUseCase>(value),
    );
  }
}

String _$saveInterviewUseCaseHash() =>
    r'a95c4c63ff656f1fb9bb63bf259ac2c9ae51eed4';
