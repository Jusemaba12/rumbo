// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gmail_connect_screen.dart';

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

String _$clipboardWriterHash() => r'376059b2aa0d58d1e13e0b5ced8886c9925035fa';
