// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_job_contact_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateJobContactUseCase)
final updateJobContactUseCaseProvider = UpdateJobContactUseCaseProvider._();

final class UpdateJobContactUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateJobContactUseCase,
          UpdateJobContactUseCase,
          UpdateJobContactUseCase
        >
    with $Provider<UpdateJobContactUseCase> {
  UpdateJobContactUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateJobContactUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateJobContactUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateJobContactUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateJobContactUseCase create(Ref ref) {
    return updateJobContactUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateJobContactUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateJobContactUseCase>(value),
    );
  }
}

String _$updateJobContactUseCaseHash() =>
    r'f27870dae3639144ea09dc73a3f4e503ad9e0d8c';
