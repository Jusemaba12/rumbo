// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_education_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveEducationUseCase)
final saveEducationUseCaseProvider = SaveEducationUseCaseProvider._();

final class SaveEducationUseCaseProvider
    extends
        $FunctionalProvider<
          SaveEducationUseCase,
          SaveEducationUseCase,
          SaveEducationUseCase
        >
    with $Provider<SaveEducationUseCase> {
  SaveEducationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveEducationUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveEducationUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveEducationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveEducationUseCase create(Ref ref) {
    return saveEducationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveEducationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveEducationUseCase>(value),
    );
  }
}

String _$saveEducationUseCaseHash() =>
    r'410ace59362fd9c1bc7da30a0080ed79b2805fa7';
