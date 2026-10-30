// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_services.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Copia el texto al portapapeles; se sustituye en los tests.

@ProviderFor(clipboardWriter)
final clipboardWriterProvider = ClipboardWriterProvider._();

/// Copia el texto al portapapeles; se sustituye en los tests.

final class ClipboardWriterProvider
    extends
        $FunctionalProvider<
          Future<void> Function(String),
          Future<void> Function(String),
          Future<void> Function(String)
        >
    with $Provider<Future<void> Function(String)> {
  /// Copia el texto al portapapeles; se sustituye en los tests.
  ClipboardWriterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clipboardWriterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clipboardWriterHash();

  @$internal
  @override
  $ProviderElement<Future<void> Function(String)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<void> Function(String) create(Ref ref) {
    return clipboardWriter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<void> Function(String) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<void> Function(String)>(
        value,
      ),
    );
  }
}

String _$clipboardWriterHash() => r'a16849b4d0b0f99cec9328ffa460e827ab55c17f';

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

String _$mailLauncherHash() => r'71815cef020416e5a1e36191f8c910c860832935';

@ProviderFor(mailWithAttachment)
final mailWithAttachmentProvider = MailWithAttachmentProvider._();

final class MailWithAttachmentProvider
    extends
        $FunctionalProvider<
          MailWithAttachment,
          MailWithAttachment,
          MailWithAttachment
        >
    with $Provider<MailWithAttachment> {
  MailWithAttachmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mailWithAttachmentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mailWithAttachmentHash();

  @$internal
  @override
  $ProviderElement<MailWithAttachment> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MailWithAttachment create(Ref ref) {
    return mailWithAttachment(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MailWithAttachment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MailWithAttachment>(value),
    );
  }
}

String _$mailWithAttachmentHash() =>
    r'471e240685f29ddcafe5ec1477cdf7b0281b23f4';
