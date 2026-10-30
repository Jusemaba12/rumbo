// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_as_ats_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(readAsAtsUseCase)
final readAsAtsUseCaseProvider = ReadAsAtsUseCaseProvider._();

final class ReadAsAtsUseCaseProvider
    extends
        $FunctionalProvider<
          ReadAsAtsUseCase,
          ReadAsAtsUseCase,
          ReadAsAtsUseCase
        >
    with $Provider<ReadAsAtsUseCase> {
  ReadAsAtsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readAsAtsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readAsAtsUseCaseHash();

  @$internal
  @override
  $ProviderElement<ReadAsAtsUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReadAsAtsUseCase create(Ref ref) {
    return readAsAtsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReadAsAtsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReadAsAtsUseCase>(value),
    );
  }
}

String _$readAsAtsUseCaseHash() => r'464b12fbea46bb6bce5eaa9b87043d7d4f224e61';
