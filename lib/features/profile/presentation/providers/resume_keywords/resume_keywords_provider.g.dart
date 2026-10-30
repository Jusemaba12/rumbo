// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_keywords_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Palabras clave de los cargos: al abrir se leen las guardadas (sin gastar
/// IA); el botón las pide o las vuelve a generar.

@ProviderFor(ResumeKeywords)
final resumeKeywordsProvider = ResumeKeywordsProvider._();

/// Palabras clave de los cargos: al abrir se leen las guardadas (sin gastar
/// IA); el botón las pide o las vuelve a generar.
final class ResumeKeywordsProvider
    extends $AsyncNotifierProvider<ResumeKeywords, KeywordsResult?> {
  /// Palabras clave de los cargos: al abrir se leen las guardadas (sin gastar
  /// IA); el botón las pide o las vuelve a generar.
  ResumeKeywordsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeKeywordsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeKeywordsHash();

  @$internal
  @override
  ResumeKeywords create() => ResumeKeywords();
}

String _$resumeKeywordsHash() => r'dc2c5ef67cc93c648889ed29e8ca31cab8ee8739';

/// Palabras clave de los cargos: al abrir se leen las guardadas (sin gastar
/// IA); el botón las pide o las vuelve a generar.

abstract class _$ResumeKeywords extends $AsyncNotifier<KeywordsResult?> {
  FutureOr<KeywordsResult?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<KeywordsResult?>, KeywordsResult?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KeywordsResult?>, KeywordsResult?>,
              AsyncValue<KeywordsResult?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
