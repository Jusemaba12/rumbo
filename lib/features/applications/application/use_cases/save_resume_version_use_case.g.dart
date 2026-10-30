// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_resume_version_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveResumeVersionUseCase)
final saveResumeVersionUseCaseProvider = SaveResumeVersionUseCaseProvider._();

final class SaveResumeVersionUseCaseProvider
    extends
        $FunctionalProvider<
          SaveResumeVersionUseCase,
          SaveResumeVersionUseCase,
          SaveResumeVersionUseCase
        >
    with $Provider<SaveResumeVersionUseCase> {
  SaveResumeVersionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveResumeVersionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveResumeVersionUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveResumeVersionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveResumeVersionUseCase create(Ref ref) {
    return saveResumeVersionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveResumeVersionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveResumeVersionUseCase>(value),
    );
  }
}

String _$saveResumeVersionUseCaseHash() =>
    r'576c58e154917e1373b6bfbba17a0b8cf39472ac';
