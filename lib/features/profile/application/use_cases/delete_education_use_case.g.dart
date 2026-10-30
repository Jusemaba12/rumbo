// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_education_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteEducationUseCase)
final deleteEducationUseCaseProvider = DeleteEducationUseCaseProvider._();

final class DeleteEducationUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteEducationUseCase,
          DeleteEducationUseCase,
          DeleteEducationUseCase
        >
    with $Provider<DeleteEducationUseCase> {
  DeleteEducationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteEducationUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteEducationUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteEducationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteEducationUseCase create(Ref ref) {
    return deleteEducationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteEducationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteEducationUseCase>(value),
    );
  }
}

String _$deleteEducationUseCaseHash() =>
    r'173b553e39abf7144b960bfa36f94642832f3b42';
