// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_brief_repository.dart';

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

@ProviderFor(companyBrief)
final companyBriefProvider = CompanyBriefFamily._();

final class CompanyBriefProvider
    extends
        $FunctionalProvider<
          AsyncValue<CompanyBrief?>,
          CompanyBrief?,
          FutureOr<CompanyBrief?>
        >
    with $FutureModifier<CompanyBrief?>, $FutureProvider<CompanyBrief?> {
  CompanyBriefProvider._({
    required CompanyBriefFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'companyBriefProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$companyBriefHash();

  @override
  String toString() {
    return r'companyBriefProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CompanyBrief?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CompanyBrief?> create(Ref ref) {
    final argument = this.argument as String;
    return companyBrief(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyBriefProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$companyBriefHash() => r'48cc7d22c7ed7d77becf11a1ab233d9080433a41';

final class CompanyBriefFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CompanyBrief?>, String> {
  CompanyBriefFamily._()
    : super(
        retry: null,
        name: r'companyBriefProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  CompanyBriefProvider call(String jobId) =>
      CompanyBriefProvider._(argument: jobId, from: this);

  @override
  String toString() => r'companyBriefProvider';
}
