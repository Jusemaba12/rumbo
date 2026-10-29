// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_review_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Revisión ATS de la HV base con los cargos de las preferencias; nula
/// mientras carga el perfil.

@ProviderFor(resumeReview)
final resumeReviewProvider = ResumeReviewProvider._();

/// Revisión ATS de la HV base con los cargos de las preferencias; nula
/// mientras carga el perfil.

final class ResumeReviewProvider
    extends $FunctionalProvider<ResumeReview?, ResumeReview?, ResumeReview?>
    with $Provider<ResumeReview?> {
  /// Revisión ATS de la HV base con los cargos de las preferencias; nula
  /// mientras carga el perfil.
  ResumeReviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resumeReviewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resumeReviewHash();

  @$internal
  @override
  $ProviderElement<ResumeReview?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResumeReview? create(Ref ref) {
    return resumeReview(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResumeReview? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResumeReview?>(value),
    );
  }
}

String _$resumeReviewHash() => r'f3f0c8d81e13eb01dd25b00cfc59b81ab095ca1a';

/// Historial de la nota; se actualiza al cambiar la nota.

@ProviderFor(ReviewHistory)
final reviewHistoryProvider = ReviewHistoryProvider._();

/// Historial de la nota; se actualiza al cambiar la nota.
final class ReviewHistoryProvider
    extends $AsyncNotifierProvider<ReviewHistory, List<ScorePoint>> {
  /// Historial de la nota; se actualiza al cambiar la nota.
  ReviewHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reviewHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reviewHistoryHash();

  @$internal
  @override
  ReviewHistory create() => ReviewHistory();
}

String _$reviewHistoryHash() => r'1c2cb92897af2af4f00a03e918a8d8a3f352732f';

/// Historial de la nota; se actualiza al cambiar la nota.

abstract class _$ReviewHistory extends $AsyncNotifier<List<ScorePoint>> {
  FutureOr<List<ScorePoint>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ScorePoint>>, List<ScorePoint>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ScorePoint>>, List<ScorePoint>>,
              AsyncValue<List<ScorePoint>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
