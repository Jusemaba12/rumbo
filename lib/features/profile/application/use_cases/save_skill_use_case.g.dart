// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_skill_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveSkillUseCase)
final saveSkillUseCaseProvider = SaveSkillUseCaseProvider._();

final class SaveSkillUseCaseProvider
    extends
        $FunctionalProvider<
          SaveSkillUseCase,
          SaveSkillUseCase,
          SaveSkillUseCase
        >
    with $Provider<SaveSkillUseCase> {
  SaveSkillUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveSkillUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveSkillUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveSkillUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveSkillUseCase create(Ref ref) {
    return saveSkillUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveSkillUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveSkillUseCase>(value),
    );
  }
}

String _$saveSkillUseCaseHash() => r'2a651f545ff91bd81a13ce7381e085f430c062e8';
