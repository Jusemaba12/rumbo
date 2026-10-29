// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_versions_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(resumeVersionsRepository)
final resumeVersionsRepositoryProvider = ResumeVersionsRepositoryProvider._();

final class ResumeVersionsRepositoryProvider
    extends
        $FunctionalProvider<
          ResumeVersionsRepository,
          ResumeVersionsRepository,
          ResumeVersionsRepository
        >
    with $Provider<ResumeVersionsRepository> {
  ResumeVersionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeVersionsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeVersionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ResumeVersionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResumeVersionsRepository create(Ref ref) {
    return resumeVersionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResumeVersionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResumeVersionsRepository>(value),
    );
  }
}

String _$resumeVersionsRepositoryHash() =>
    r'2c2cb9e510f347961a026e9bb08c42adf01926ea';
