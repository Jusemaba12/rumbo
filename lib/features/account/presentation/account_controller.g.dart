// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_controller.dart';

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

String _$privacyAcceptedHash() => r'a037d1c8aa9f2571d1c51ae58c1ce4c85bc748d2';

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

String _$installedBuildHash() => r'e1155376aa964b41599827758a744eea3a3db8d1';

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

String _$availableUpdateHash() => r'd12edf002b8bad73098416c1075a0216f59d7cb0';
