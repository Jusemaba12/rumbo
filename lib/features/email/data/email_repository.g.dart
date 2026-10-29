// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_repository.dart';

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
