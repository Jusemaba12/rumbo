// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_services.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pdfSharer)
final pdfSharerProvider = PdfSharerProvider._();

final class PdfSharerProvider
    extends $FunctionalProvider<PdfSharer, PdfSharer, PdfSharer>
    with $Provider<PdfSharer> {
  PdfSharerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pdfSharerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pdfSharerHash();

  @$internal
  @override
  $ProviderElement<PdfSharer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PdfSharer create(Ref ref) {
    return pdfSharer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PdfSharer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PdfSharer>(value),
    );
  }
}

String _$pdfSharerHash() => r'05d6d3a6d557d86d7850af67bbc665c4a86fe1ca';

/// Fuentes con tildes y eñes; se descargan una vez y quedan en caché.

@ProviderFor(resumeFonts)
final resumeFontsProvider = ResumeFontsProvider._();

/// Fuentes con tildes y eñes; se descargan una vez y quedan en caché.

final class ResumeFontsProvider
    extends
        $FunctionalProvider<
          AsyncValue<(pw.Font, pw.Font)?>,
          (pw.Font, pw.Font)?,
          FutureOr<(pw.Font, pw.Font)?>
        >
    with
        $FutureModifier<(pw.Font, pw.Font)?>,
        $FutureProvider<(pw.Font, pw.Font)?> {
  /// Fuentes con tildes y eñes; se descargan una vez y quedan en caché.
  ResumeFontsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeFontsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeFontsHash();

  @$internal
  @override
  $FutureProviderElement<(pw.Font, pw.Font)?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<(pw.Font, pw.Font)?> create(Ref ref) {
    return resumeFonts(ref);
  }
}

String _$resumeFontsHash() => r'3c91196acbee1913ebffade183ad1dbd2d3bdfd6';
