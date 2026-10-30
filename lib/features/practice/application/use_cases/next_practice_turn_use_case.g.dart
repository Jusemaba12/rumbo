// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_practice_turn_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nextPracticeTurnUseCase)
final nextPracticeTurnUseCaseProvider = NextPracticeTurnUseCaseProvider._();

final class NextPracticeTurnUseCaseProvider
    extends
        $FunctionalProvider<
          NextPracticeTurnUseCase,
          NextPracticeTurnUseCase,
          NextPracticeTurnUseCase
        >
    with $Provider<NextPracticeTurnUseCase> {
  NextPracticeTurnUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nextPracticeTurnUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nextPracticeTurnUseCaseHash();

  @$internal
  @override
  $ProviderElement<NextPracticeTurnUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NextPracticeTurnUseCase create(Ref ref) {
    return nextPracticeTurnUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NextPracticeTurnUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NextPracticeTurnUseCase>(value),
    );
  }
}

String _$nextPracticeTurnUseCaseHash() =>
    r'c5e42c43cd5b80f77e420eca33f460fbb2a235ef';
