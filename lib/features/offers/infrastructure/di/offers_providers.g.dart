// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(offersRepository)
final offersRepositoryProvider = OffersRepositoryProvider._();

final class OffersRepositoryProvider
    extends
        $FunctionalProvider<
          OffersRepository,
          OffersRepository,
          OffersRepository
        >
    with $Provider<OffersRepository> {
  OffersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offersRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offersRepositoryHash();

  @$internal
  @override
  $ProviderElement<OffersRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OffersRepository create(Ref ref) {
    return offersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OffersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OffersRepository>(value),
    );
  }
}

String _$offersRepositoryHash() => r'24d3d5e408b390698327df6ffc80c7fb47d70f96';

/// Nulo en modo local: necesita el servidor.

@ProviderFor(negotiator)
final negotiatorProvider = NegotiatorProvider._();

/// Nulo en modo local: necesita el servidor.

final class NegotiatorProvider
    extends $FunctionalProvider<Negotiator?, Negotiator?, Negotiator?>
    with $Provider<Negotiator?> {
  /// Nulo en modo local: necesita el servidor.
  NegotiatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'negotiatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$negotiatorHash();

  @$internal
  @override
  $ProviderElement<Negotiator?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Negotiator? create(Ref ref) {
    return negotiator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Negotiator? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Negotiator?>(value),
    );
  }
}

String _$negotiatorHash() => r'd4d0c4c034415cb1272203b1cb6aea49d43a96d8';
