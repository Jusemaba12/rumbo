// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_brief_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ficha de la empresa de la oferta [jobId].

@ProviderFor(CompanyBriefController)
final companyBriefControllerProvider = CompanyBriefControllerFamily._();

/// Ficha de la empresa de la oferta [jobId].
final class CompanyBriefControllerProvider
    extends $AsyncNotifierProvider<CompanyBriefController, CompanyBrief?> {
  /// Ficha de la empresa de la oferta [jobId].
  CompanyBriefControllerProvider._({
    required CompanyBriefControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'companyBriefControllerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$companyBriefControllerHash();

  @override
  String toString() {
    return r'companyBriefControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CompanyBriefController create() => CompanyBriefController();

  @override
  bool operator ==(Object other) {
    return other is CompanyBriefControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$companyBriefControllerHash() =>
    r'188a81f9a78216bfb3aae08d32dfe6b7d599fb5c';

/// Ficha de la empresa de la oferta [jobId].

final class CompanyBriefControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CompanyBriefController,
          AsyncValue<CompanyBrief?>,
          CompanyBrief?,
          FutureOr<CompanyBrief?>,
          String
        > {
  CompanyBriefControllerFamily._()
    : super(
        retry: null,
        name: r'companyBriefControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Ficha de la empresa de la oferta [jobId].

  CompanyBriefControllerProvider call(String jobId) =>
      CompanyBriefControllerProvider._(argument: jobId, from: this);

  @override
  String toString() => r'companyBriefControllerProvider';
}

/// Ficha de la empresa de la oferta [jobId].

abstract class _$CompanyBriefController extends $AsyncNotifier<CompanyBrief?> {
  late final _$args = ref.$arg as String;
  String get jobId => _$args;

  FutureOr<CompanyBrief?> build(String jobId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CompanyBrief?>, CompanyBrief?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CompanyBrief?>, CompanyBrief?>,
              AsyncValue<CompanyBrief?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
