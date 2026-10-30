// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_skill_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteSkillUseCase)
final deleteSkillUseCaseProvider = DeleteSkillUseCaseProvider._();

final class DeleteSkillUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteSkillUseCase,
          DeleteSkillUseCase,
          DeleteSkillUseCase
        >
    with $Provider<DeleteSkillUseCase> {
  DeleteSkillUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteSkillUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteSkillUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteSkillUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteSkillUseCase create(Ref ref) {
    return deleteSkillUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteSkillUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteSkillUseCase>(value),
    );
  }
}

String _$deleteSkillUseCaseHash() =>
    r'769490942728bed4d147b86a262f6177a7be891b';
