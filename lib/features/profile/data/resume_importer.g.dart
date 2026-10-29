// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_importer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nulo en modo local: importar necesita el servidor.

@ProviderFor(resumeImporter)
final resumeImporterProvider = ResumeImporterProvider._();

/// Nulo en modo local: importar necesita el servidor.

final class ResumeImporterProvider
    extends
        $FunctionalProvider<ResumeImporter?, ResumeImporter?, ResumeImporter?>
    with $Provider<ResumeImporter?> {
  /// Nulo en modo local: importar necesita el servidor.
  ResumeImporterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeImporterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeImporterHash();

  @$internal
  @override
  $ProviderElement<ResumeImporter?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResumeImporter? create(Ref ref) {
    return resumeImporter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResumeImporter? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResumeImporter?>(value),
    );
  }
}

String _$resumeImporterHash() => r'036571a51a827acfaf46742bb1212d270997a625';

@ProviderFor(pdfPicker)
final pdfPickerProvider = PdfPickerProvider._();

final class PdfPickerProvider
    extends $FunctionalProvider<PdfPicker, PdfPicker, PdfPicker>
    with $Provider<PdfPicker> {
  PdfPickerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pdfPickerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pdfPickerHash();

  @$internal
  @override
  $ProviderElement<PdfPicker> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PdfPicker create(Ref ref) {
    return pdfPicker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PdfPicker value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PdfPicker>(value),
    );
  }
}

String _$pdfPickerHash() => r'04c47978e7d12223491ea485336b3f0f8902b43a';
