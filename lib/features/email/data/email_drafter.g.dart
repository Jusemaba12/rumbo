// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_drafter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nulo en modo local: necesita el servidor.

@ProviderFor(emailDrafter)
final emailDrafterProvider = EmailDrafterProvider._();

/// Nulo en modo local: necesita el servidor.

final class EmailDrafterProvider
    extends $FunctionalProvider<EmailDrafter?, EmailDrafter?, EmailDrafter?>
    with $Provider<EmailDrafter?> {
  /// Nulo en modo local: necesita el servidor.
  EmailDrafterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailDrafterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailDrafterHash();

  @$internal
  @override
  $ProviderElement<EmailDrafter?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmailDrafter? create(Ref ref) {
    return emailDrafter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailDrafter? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailDrafter?>(value),
    );
  }
}

String _$emailDrafterHash() => r'f406a7d785915773699cf3810c43c3bab853f69b';
