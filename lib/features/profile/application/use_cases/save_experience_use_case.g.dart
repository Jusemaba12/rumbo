// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_experience_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveExperienceUseCase)
final saveExperienceUseCaseProvider = SaveExperienceUseCaseProvider._();

final class SaveExperienceUseCaseProvider
    extends
        $FunctionalProvider<
          SaveExperienceUseCase,
          SaveExperienceUseCase,
          SaveExperienceUseCase
        >
    with $Provider<SaveExperienceUseCase> {
  SaveExperienceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveExperienceUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveExperienceUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveExperienceUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveExperienceUseCase create(Ref ref) {
    return saveExperienceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveExperienceUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveExperienceUseCase>(value),
    );
  }
}

String _$saveExperienceUseCaseHash() =>
    r'a3048fb4f9926bb7724b7364e2202e63e9145345';
