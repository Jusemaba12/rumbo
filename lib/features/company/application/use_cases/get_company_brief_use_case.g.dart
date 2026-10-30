// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_company_brief_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getCompanyBriefUseCase)
final getCompanyBriefUseCaseProvider = GetCompanyBriefUseCaseProvider._();

final class GetCompanyBriefUseCaseProvider
    extends
        $FunctionalProvider<
          GetCompanyBriefUseCase,
          GetCompanyBriefUseCase,
          GetCompanyBriefUseCase
        >
    with $Provider<GetCompanyBriefUseCase> {
  GetCompanyBriefUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCompanyBriefUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCompanyBriefUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCompanyBriefUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCompanyBriefUseCase create(Ref ref) {
    return getCompanyBriefUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCompanyBriefUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCompanyBriefUseCase>(value),
    );
  }
}

String _$getCompanyBriefUseCaseHash() =>
    r'15164923bfae6790b6799a2efb0961bbc1b0e99b';
