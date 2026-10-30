// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyze_job_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(analyzeJobUseCase)
final analyzeJobUseCaseProvider = AnalyzeJobUseCaseProvider._();

final class AnalyzeJobUseCaseProvider
    extends
        $FunctionalProvider<
          AnalyzeJobUseCase,
          AnalyzeJobUseCase,
          AnalyzeJobUseCase
        >
    with $Provider<AnalyzeJobUseCase> {
  AnalyzeJobUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyzeJobUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyzeJobUseCaseHash();

  @$internal
  @override
  $ProviderElement<AnalyzeJobUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnalyzeJobUseCase create(Ref ref) {
    return analyzeJobUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyzeJobUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyzeJobUseCase>(value),
    );
  }
}

String _$analyzeJobUseCaseHash() => r'ec179362f60d231e861383833caac6579ba0ab20';
