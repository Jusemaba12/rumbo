// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ats_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nulo en modo local: necesita el servidor.

@ProviderFor(atsReader)
final atsReaderProvider = AtsReaderProvider._();

/// Nulo en modo local: necesita el servidor.

final class AtsReaderProvider
    extends $FunctionalProvider<AtsReader?, AtsReader?, AtsReader?>
    with $Provider<AtsReader?> {
  /// Nulo en modo local: necesita el servidor.
  AtsReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'atsReaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$atsReaderHash();

  @$internal
  @override
  $ProviderElement<AtsReader?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AtsReader? create(Ref ref) {
    return atsReader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AtsReader? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AtsReader?>(value),
    );
  }
}

String _$atsReaderHash() => r'df873f8c46aa8fc04951aeb42c73a071d299fdc2';
