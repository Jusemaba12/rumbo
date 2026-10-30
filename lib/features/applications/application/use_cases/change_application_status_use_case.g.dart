// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_application_status_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(changeApplicationStatusUseCase)
final changeApplicationStatusUseCaseProvider =
    ChangeApplicationStatusUseCaseProvider._();

final class ChangeApplicationStatusUseCaseProvider
    extends
        $FunctionalProvider<
          ChangeApplicationStatusUseCase,
          ChangeApplicationStatusUseCase,
          ChangeApplicationStatusUseCase
        >
    with $Provider<ChangeApplicationStatusUseCase> {
  ChangeApplicationStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changeApplicationStatusUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changeApplicationStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<ChangeApplicationStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChangeApplicationStatusUseCase create(Ref ref) {
    return changeApplicationStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChangeApplicationStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChangeApplicationStatusUseCase>(
        value,
      ),
    );
  }
}

String _$changeApplicationStatusUseCaseHash() =>
    r'02aa0b07b83e33a37bb9a295072ea042fe3c1856';
