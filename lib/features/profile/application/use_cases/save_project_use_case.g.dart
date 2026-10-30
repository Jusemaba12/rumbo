// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_project_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveProjectUseCase)
final saveProjectUseCaseProvider = SaveProjectUseCaseProvider._();

final class SaveProjectUseCaseProvider
    extends
        $FunctionalProvider<
          SaveProjectUseCase,
          SaveProjectUseCase,
          SaveProjectUseCase
        >
    with $Provider<SaveProjectUseCase> {
  SaveProjectUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveProjectUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveProjectUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveProjectUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveProjectUseCase create(Ref ref) {
    return saveProjectUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveProjectUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveProjectUseCase>(value),
    );
  }
}

String _$saveProjectUseCaseHash() =>
    r'6bbcda107f1cd24c7939ee07b8d14c2ff7f936bc';
