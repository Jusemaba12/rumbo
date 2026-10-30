// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(applicationsRepository)
final applicationsRepositoryProvider = ApplicationsRepositoryProvider._();

final class ApplicationsRepositoryProvider
    extends
        $FunctionalProvider<
          ApplicationsRepository,
          ApplicationsRepository,
          ApplicationsRepository
        >
    with $Provider<ApplicationsRepository> {
  ApplicationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicationsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ApplicationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ApplicationsRepository create(Ref ref) {
    return applicationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApplicationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApplicationsRepository>(value),
    );
  }
}

String _$applicationsRepositoryHash() =>
    r'f0af45952d10ae2030aeae6bd7fe2dc2639aebfd';

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

/// Nulo en modo local: adaptar necesita el servidor.

@ProviderFor(resumeTailor)
final resumeTailorProvider = ResumeTailorProvider._();

/// Nulo en modo local: adaptar necesita el servidor.

final class ResumeTailorProvider
    extends $FunctionalProvider<ResumeTailor?, ResumeTailor?, ResumeTailor?>
    with $Provider<ResumeTailor?> {
  /// Nulo en modo local: adaptar necesita el servidor.
  ResumeTailorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeTailorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeTailorHash();

  @$internal
  @override
  $ProviderElement<ResumeTailor?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResumeTailor? create(Ref ref) {
    return resumeTailor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResumeTailor? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResumeTailor?>(value),
    );
  }
}

String _$resumeTailorHash() => r'd4d5fe8c7c1881db78701c7242f5cde1764d2dbd';

/// Nulo en modo local: necesita el servidor.

@ProviderFor(atsReader)
final atsReaderProvider = AtsReaderProvider._();

/// Nulo en modo local: necesita el servidor.

final class AtsReaderProvider
    extends $FunctionalProvider<AtsReader?, AtsReader?, AtsReader?>
    with $Provider<AtsReader?> {
  /// Nulo en modo local: necesita el servidor.
  AtsReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'atsReaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$atsReaderHash();

  @$internal
  @override
  $ProviderElement<AtsReader?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AtsReader? create(Ref ref) {
    return atsReader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AtsReader? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AtsReader?>(value),
    );
  }
}

String _$atsReaderHash() => r'df873f8c46aa8fc04951aeb42c73a071d299fdc2';
