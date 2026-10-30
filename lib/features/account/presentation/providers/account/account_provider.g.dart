// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Si la cuenta aceptó el aviso de privacidad. Sin conexión no se bloquea:
/// un error cuenta como aceptado.

@ProviderFor(PrivacyAccepted)
final privacyAcceptedProvider = PrivacyAcceptedProvider._();

/// Si la cuenta aceptó el aviso de privacidad. Sin conexión no se bloquea:
/// un error cuenta como aceptado.
final class PrivacyAcceptedProvider
    extends $AsyncNotifierProvider<PrivacyAccepted, bool> {
  /// Si la cuenta aceptó el aviso de privacidad. Sin conexión no se bloquea:
  /// un error cuenta como aceptado.
  PrivacyAcceptedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'privacyAcceptedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$privacyAcceptedHash();

  @$internal
  @override
  PrivacyAccepted create() => PrivacyAccepted();
}

String _$privacyAcceptedHash() => r'9afcd5d8efe302f3898ed7ad00a663bfbb3fef9d';

/// Si la cuenta aceptó el aviso de privacidad. Sin conexión no se bloquea:
/// un error cuenta como aceptado.

abstract class _$PrivacyAccepted extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Número de compilación instalado, o nulo si no se puede leer.

@ProviderFor(installedBuild)
final installedBuildProvider = InstalledBuildProvider._();

/// Número de compilación instalado, o nulo si no se puede leer.

final class InstalledBuildProvider
    extends $FunctionalProvider<AsyncValue<int?>, int?, FutureOr<int?>>
    with $FutureModifier<int?>, $FutureProvider<int?> {
  /// Número de compilación instalado, o nulo si no se puede leer.
  InstalledBuildProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'installedBuildProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$installedBuildHash();

  @$internal
  @override
  $FutureProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int?> create(Ref ref) {
    return installedBuild(ref);
  }
}

String _$installedBuildHash() => r'd01811f1cf0be9d1ef71c7a1b975a75d0966acf8';

/// Versión nueva del APK para avisar en Inicio. Solo Android: en iPhone la
/// app se reinstala desde el Mac.

@ProviderFor(availableUpdate)
final availableUpdateProvider = AvailableUpdateProvider._();

/// Versión nueva del APK para avisar en Inicio. Solo Android: en iPhone la
/// app se reinstala desde el Mac.

final class AvailableUpdateProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppRelease?>,
          AppRelease?,
          FutureOr<AppRelease?>
        >
    with $FutureModifier<AppRelease?>, $FutureProvider<AppRelease?> {
  /// Versión nueva del APK para avisar en Inicio. Solo Android: en iPhone la
  /// app se reinstala desde el Mac.
  AvailableUpdateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableUpdateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableUpdateHash();

  @$internal
  @override
  $FutureProviderElement<AppRelease?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppRelease?> create(Ref ref) {
    return availableUpdate(ref);
  }
}

String _$availableUpdateHash() => r'1e126b427272798976b0ff56b2c3e08a6ae72b34';
