// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_experience_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteExperienceUseCase)
final deleteExperienceUseCaseProvider = DeleteExperienceUseCaseProvider._();

final class DeleteExperienceUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteExperienceUseCase,
          DeleteExperienceUseCase,
          DeleteExperienceUseCase
        >
    with $Provider<DeleteExperienceUseCase> {
  DeleteExperienceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteExperienceUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteExperienceUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteExperienceUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteExperienceUseCase create(Ref ref) {
    return deleteExperienceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteExperienceUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteExperienceUseCase>(value),
    );
  }
}

String _$deleteExperienceUseCaseHash() =>
    r'887007b37b1107501d1e7436b001e595a4aeab77';
