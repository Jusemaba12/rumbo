// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_application_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveApplicationUseCase)
final saveApplicationUseCaseProvider = SaveApplicationUseCaseProvider._();

final class SaveApplicationUseCaseProvider
    extends
        $FunctionalProvider<
          SaveApplicationUseCase,
          SaveApplicationUseCase,
          SaveApplicationUseCase
        >
    with $Provider<SaveApplicationUseCase> {
  SaveApplicationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveApplicationUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveApplicationUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveApplicationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveApplicationUseCase create(Ref ref) {
    return saveApplicationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveApplicationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveApplicationUseCase>(value),
    );
  }
}

String _$saveApplicationUseCaseHash() =>
    r'791207cf1ce3a775949366b51fc2beb651ccdf9a';
