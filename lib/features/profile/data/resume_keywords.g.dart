// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_keywords.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nulo en modo local: necesita el servidor.

@ProviderFor(resumeKeywordsSource)
final resumeKeywordsSourceProvider = ResumeKeywordsSourceProvider._();

/// Nulo en modo local: necesita el servidor.

final class ResumeKeywordsSourceProvider
    extends
        $FunctionalProvider<
          ResumeKeywordsSource?,
          ResumeKeywordsSource?,
          ResumeKeywordsSource?
        >
    with $Provider<ResumeKeywordsSource?> {
  /// Nulo en modo local: necesita el servidor.
  ResumeKeywordsSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeKeywordsSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeKeywordsSourceHash();

  @$internal
  @override
  $ProviderElement<ResumeKeywordsSource?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResumeKeywordsSource? create(Ref ref) {
    return resumeKeywordsSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResumeKeywordsSource? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResumeKeywordsSource?>(value),
    );
  }
}

String _$resumeKeywordsSourceHash() =>
    r'6078a3326efd46662540d479b5a09af8cc483e1b';

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

String _$resumeKeywordsHash() => r'419d1bc93d3ceba0eb89cecfab5dfbeb566e7e0f';

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
