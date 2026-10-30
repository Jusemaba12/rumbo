// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_resume_keywords_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(loadResumeKeywordsUseCase)
final loadResumeKeywordsUseCaseProvider = LoadResumeKeywordsUseCaseProvider._();

final class LoadResumeKeywordsUseCaseProvider
    extends
        $FunctionalProvider<
          LoadResumeKeywordsUseCase,
          LoadResumeKeywordsUseCase,
          LoadResumeKeywordsUseCase
        >
    with $Provider<LoadResumeKeywordsUseCase> {
  LoadResumeKeywordsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadResumeKeywordsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadResumeKeywordsUseCaseHash();

  @$internal
  @override
  $ProviderElement<LoadResumeKeywordsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LoadResumeKeywordsUseCase create(Ref ref) {
    return loadResumeKeywordsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadResumeKeywordsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadResumeKeywordsUseCase>(value),
    );
  }
}

String _$loadResumeKeywordsUseCaseHash() =>
    r'6e66630147524dd7b36e7503809215db3fd909f4';
