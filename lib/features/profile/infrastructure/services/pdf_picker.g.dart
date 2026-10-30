// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_picker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$pdfPickerHash() => r'0b419bef489195647505aebf82c0bb988dfe81d0';
