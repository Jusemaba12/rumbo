// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interviews_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(interviewsRepository)
final interviewsRepositoryProvider = InterviewsRepositoryProvider._();

final class InterviewsRepositoryProvider
    extends
        $FunctionalProvider<
          InterviewsRepository,
          InterviewsRepository,
          InterviewsRepository
        >
    with $Provider<InterviewsRepository> {
  InterviewsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interviewsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interviewsRepositoryHash();

  @$internal
  @override
  $ProviderElement<InterviewsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InterviewsRepository create(Ref ref) {
    return interviewsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InterviewsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InterviewsRepository>(value),
    );
  }
}

String _$interviewsRepositoryHash() =>
    r'2faf07ecc8b0cd8aba9a80be06ebaeaebac042aa';
