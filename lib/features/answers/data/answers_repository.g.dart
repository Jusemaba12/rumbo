// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(answersRepository)
final answersRepositoryProvider = AnswersRepositoryProvider._();

final class AnswersRepositoryProvider
    extends
        $FunctionalProvider<
          AnswersRepository,
          AnswersRepository,
          AnswersRepository
        >
    with $Provider<AnswersRepository> {
  AnswersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'answersRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$answersRepositoryHash();

  @$internal
  @override
  $ProviderElement<AnswersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnswersRepository create(Ref ref) {
    return answersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnswersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnswersRepository>(value),
    );
  }
}

String _$answersRepositoryHash() => r'7d5ed4d823d58f0b58d82d45ee9a2152ce4f5550';
