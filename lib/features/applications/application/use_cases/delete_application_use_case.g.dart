// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_application_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteApplicationUseCase)
final deleteApplicationUseCaseProvider = DeleteApplicationUseCaseProvider._();

final class DeleteApplicationUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteApplicationUseCase,
          DeleteApplicationUseCase,
          DeleteApplicationUseCase
        >
    with $Provider<DeleteApplicationUseCase> {
  DeleteApplicationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteApplicationUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteApplicationUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteApplicationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteApplicationUseCase create(Ref ref) {
    return deleteApplicationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteApplicationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteApplicationUseCase>(value),
    );
  }
}

String _$deleteApplicationUseCaseHash() =>
    r'c398efd39780006e39bb57b0d36ffe2a31ea57ff';
