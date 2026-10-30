// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_answers_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAnswersUseCase)
final getAnswersUseCaseProvider = GetAnswersUseCaseProvider._();

final class GetAnswersUseCaseProvider
    extends
        $FunctionalProvider<
          GetAnswersUseCase,
          GetAnswersUseCase,
          GetAnswersUseCase
        >
    with $Provider<GetAnswersUseCase> {
  GetAnswersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAnswersUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAnswersUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAnswersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAnswersUseCase create(Ref ref) {
    return getAnswersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAnswersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAnswersUseCase>(value),
    );
  }
}

String _$getAnswersUseCaseHash() => r'3f0591aef5ab51bef00aa9602625523c59f08c58';
