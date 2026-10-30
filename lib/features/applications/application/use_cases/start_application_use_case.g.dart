// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_application_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(startApplicationUseCase)
final startApplicationUseCaseProvider = StartApplicationUseCaseProvider._();

final class StartApplicationUseCaseProvider
    extends
        $FunctionalProvider<
          StartApplicationUseCase,
          StartApplicationUseCase,
          StartApplicationUseCase
        >
    with $Provider<StartApplicationUseCase> {
  StartApplicationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startApplicationUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startApplicationUseCaseHash();

  @$internal
  @override
  $ProviderElement<StartApplicationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StartApplicationUseCase create(Ref ref) {
    return startApplicationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StartApplicationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StartApplicationUseCase>(value),
    );
  }
}

String _$startApplicationUseCaseHash() =>
    r'7b4250c2ef4a5aa000e85bc0706021d7e4a4da43';
