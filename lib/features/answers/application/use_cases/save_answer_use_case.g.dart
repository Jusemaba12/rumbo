// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_answer_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveAnswerUseCase)
final saveAnswerUseCaseProvider = SaveAnswerUseCaseProvider._();

final class SaveAnswerUseCaseProvider
    extends
        $FunctionalProvider<
          SaveAnswerUseCase,
          SaveAnswerUseCase,
          SaveAnswerUseCase
        >
    with $Provider<SaveAnswerUseCase> {
  SaveAnswerUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveAnswerUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveAnswerUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveAnswerUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveAnswerUseCase create(Ref ref) {
    return saveAnswerUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveAnswerUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveAnswerUseCase>(value),
    );
  }
}

String _$saveAnswerUseCaseHash() => r'9deb1df5a72dc04e2328d92c9faa8dcd360e6949';
