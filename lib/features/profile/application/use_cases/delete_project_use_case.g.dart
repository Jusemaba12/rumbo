// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_project_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteProjectUseCase)
final deleteProjectUseCaseProvider = DeleteProjectUseCaseProvider._();

final class DeleteProjectUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteProjectUseCase,
          DeleteProjectUseCase,
          DeleteProjectUseCase
        >
    with $Provider<DeleteProjectUseCase> {
  DeleteProjectUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteProjectUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteProjectUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteProjectUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteProjectUseCase create(Ref ref) {
    return deleteProjectUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteProjectUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteProjectUseCase>(value),
    );
  }
}

String _$deleteProjectUseCaseHash() =>
    r'8a0d4fb4536a44ed6c218203f7574bf4d775a0dc';
