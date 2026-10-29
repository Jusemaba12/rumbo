// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_draft_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Abre la app de correo con un enlace mailto; falso si no se pudo.

@ProviderFor(mailLauncher)
final mailLauncherProvider = MailLauncherProvider._();

/// Abre la app de correo con un enlace mailto; falso si no se pudo.

final class MailLauncherProvider
    extends
        $FunctionalProvider<
          Future<bool> Function(Uri),
          Future<bool> Function(Uri),
          Future<bool> Function(Uri)
        >
    with $Provider<Future<bool> Function(Uri)> {
  /// Abre la app de correo con un enlace mailto; falso si no se pudo.
  MailLauncherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mailLauncherProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mailLauncherHash();

  @$internal
  @override
  $ProviderElement<Future<bool> Function(Uri)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<bool> Function(Uri) create(Ref ref) {
    return mailLauncher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<bool> Function(Uri) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<bool> Function(Uri)>(value),
    );
  }
}

String _$mailLauncherHash() => r'98bdc4e3824748ceb0892425107441c5123f5a28';
