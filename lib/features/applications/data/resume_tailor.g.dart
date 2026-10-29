// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_tailor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nulo en modo local: adaptar necesita el servidor.

@ProviderFor(resumeTailor)
final resumeTailorProvider = ResumeTailorProvider._();

/// Nulo en modo local: adaptar necesita el servidor.

final class ResumeTailorProvider
    extends $FunctionalProvider<ResumeTailor?, ResumeTailor?, ResumeTailor?>
    with $Provider<ResumeTailor?> {
  /// Nulo en modo local: adaptar necesita el servidor.
  ResumeTailorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeTailorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeTailorHash();

  @$internal
  @override
  $ProviderElement<ResumeTailor?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResumeTailor? create(Ref ref) {
    return resumeTailor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResumeTailor? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResumeTailor?>(value),
    );
  }
}

String _$resumeTailorHash() => r'd4d5fe8c7c1881db78701c7242f5cde1764d2dbd';
