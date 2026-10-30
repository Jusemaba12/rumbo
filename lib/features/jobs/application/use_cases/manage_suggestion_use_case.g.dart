// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_suggestion_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(manageSuggestionUseCase)
final manageSuggestionUseCaseProvider = ManageSuggestionUseCaseProvider._();

final class ManageSuggestionUseCaseProvider
    extends
        $FunctionalProvider<
          ManageSuggestionUseCase,
          ManageSuggestionUseCase,
          ManageSuggestionUseCase
        >
    with $Provider<ManageSuggestionUseCase> {
  ManageSuggestionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'manageSuggestionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$manageSuggestionUseCaseHash();

  @$internal
  @override
  $ProviderElement<ManageSuggestionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ManageSuggestionUseCase create(Ref ref) {
    return manageSuggestionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ManageSuggestionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ManageSuggestionUseCase>(value),
    );
  }
}

String _$manageSuggestionUseCaseHash() =>
    r'6e751f52a7fce33bf22ce858532adc7007570a60';
