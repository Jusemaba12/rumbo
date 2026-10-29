// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_analyzer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nulo en modo local: analizar necesita el servidor.

@ProviderFor(jobAnalyzer)
final jobAnalyzerProvider = JobAnalyzerProvider._();

/// Nulo en modo local: analizar necesita el servidor.

final class JobAnalyzerProvider
    extends $FunctionalProvider<JobAnalyzer?, JobAnalyzer?, JobAnalyzer?>
    with $Provider<JobAnalyzer?> {
  /// Nulo en modo local: analizar necesita el servidor.
  JobAnalyzerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jobAnalyzerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jobAnalyzerHash();

  @$internal
  @override
  $ProviderElement<JobAnalyzer?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JobAnalyzer? create(Ref ref) {
    return jobAnalyzer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JobAnalyzer? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JobAnalyzer?>(value),
    );
  }
}

String _$jobAnalyzerHash() => r'e3ec51f9e80d2b2826a93011ec388457421d5aa4';
