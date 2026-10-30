// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nulo en modo local: necesita el servidor.

@ProviderFor(companyBriefRepository)
final companyBriefRepositoryProvider = CompanyBriefRepositoryProvider._();

/// Nulo en modo local: necesita el servidor.

final class CompanyBriefRepositoryProvider
    extends
        $FunctionalProvider<
          CompanyBriefRepository?,
          CompanyBriefRepository?,
          CompanyBriefRepository?
        >
    with $Provider<CompanyBriefRepository?> {
  /// Nulo en modo local: necesita el servidor.
  CompanyBriefRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'companyBriefRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$companyBriefRepositoryHash();

  @$internal
  @override
  $ProviderElement<CompanyBriefRepository?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompanyBriefRepository? create(Ref ref) {
    return companyBriefRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompanyBriefRepository? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompanyBriefRepository?>(value),
    );
  }
}

String _$companyBriefRepositoryHash() =>
    r'042b67618881f68c452cb1081e506874d7af0dfa';
