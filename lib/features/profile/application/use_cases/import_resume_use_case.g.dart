// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_resume_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(importResumeUseCase)
final importResumeUseCaseProvider = ImportResumeUseCaseProvider._();

final class ImportResumeUseCaseProvider
    extends
        $FunctionalProvider<
          ImportResumeUseCase,
          ImportResumeUseCase,
          ImportResumeUseCase
        >
    with $Provider<ImportResumeUseCase> {
  ImportResumeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'importResumeUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$importResumeUseCaseHash();

  @$internal
  @override
  $ProviderElement<ImportResumeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImportResumeUseCase create(Ref ref) {
    return importResumeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImportResumeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImportResumeUseCase>(value),
    );
  }
}

String _$importResumeUseCaseHash() =>
    r'ead21ec2e6fe8b9e96b76d4a221fb5069275630c';
