// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_profile_import_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(applyProfileImportUseCase)
final applyProfileImportUseCaseProvider = ApplyProfileImportUseCaseProvider._();

final class ApplyProfileImportUseCaseProvider
    extends
        $FunctionalProvider<
          ApplyProfileImportUseCase,
          ApplyProfileImportUseCase,
          ApplyProfileImportUseCase
        >
    with $Provider<ApplyProfileImportUseCase> {
  ApplyProfileImportUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applyProfileImportUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applyProfileImportUseCaseHash();

  @$internal
  @override
  $ProviderElement<ApplyProfileImportUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ApplyProfileImportUseCase create(Ref ref) {
    return applyProfileImportUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApplyProfileImportUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApplyProfileImportUseCase>(value),
    );
  }
}

String _$applyProfileImportUseCaseHash() =>
    r'a5f64fb8500cfbd6a62d3a2dea5623e8786e85e1';
