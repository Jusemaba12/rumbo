// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(emailRepository)
final emailRepositoryProvider = EmailRepositoryProvider._();

final class EmailRepositoryProvider
    extends
        $FunctionalProvider<EmailRepository, EmailRepository, EmailRepository>
    with $Provider<EmailRepository> {
  EmailRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailRepositoryHash();

  @$internal
  @override
  $ProviderElement<EmailRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmailRepository create(Ref ref) {
    return emailRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailRepository>(value),
    );
  }
}

String _$emailRepositoryHash() => r'98fca1fe64464a9a8fe6203fd68827068ccd6aaf';

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
