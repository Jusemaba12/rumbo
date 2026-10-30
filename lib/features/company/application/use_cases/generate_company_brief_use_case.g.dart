// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_company_brief_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(generateCompanyBriefUseCase)
final generateCompanyBriefUseCaseProvider =
    GenerateCompanyBriefUseCaseProvider._();

final class GenerateCompanyBriefUseCaseProvider
    extends
        $FunctionalProvider<
          GenerateCompanyBriefUseCase,
          GenerateCompanyBriefUseCase,
          GenerateCompanyBriefUseCase
        >
    with $Provider<GenerateCompanyBriefUseCase> {
  GenerateCompanyBriefUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generateCompanyBriefUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generateCompanyBriefUseCaseHash();

  @$internal
  @override
  $ProviderElement<GenerateCompanyBriefUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GenerateCompanyBriefUseCase create(Ref ref) {
    return generateCompanyBriefUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GenerateCompanyBriefUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GenerateCompanyBriefUseCase>(value),
    );
  }
}

String _$generateCompanyBriefUseCaseHash() =>
    r'9c310d7c0b866e9395362ace7e0d4daa5798b27d';
