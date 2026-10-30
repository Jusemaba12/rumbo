// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_job_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveJobUseCase)
final saveJobUseCaseProvider = SaveJobUseCaseProvider._();

final class SaveJobUseCaseProvider
    extends $FunctionalProvider<SaveJobUseCase, SaveJobUseCase, SaveJobUseCase>
    with $Provider<SaveJobUseCase> {
  SaveJobUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveJobUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveJobUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveJobUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveJobUseCase create(Ref ref) {
    return saveJobUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveJobUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveJobUseCase>(value),
    );
  }
}

String _$saveJobUseCaseHash() => r'f4180356602b3d107914384ccb3d985c602561d3';
