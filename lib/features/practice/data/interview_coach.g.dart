// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_coach.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nulo en modo local: practicar necesita el servidor.

@ProviderFor(interviewCoach)
final interviewCoachProvider = InterviewCoachProvider._();

/// Nulo en modo local: practicar necesita el servidor.

final class InterviewCoachProvider
    extends
        $FunctionalProvider<InterviewCoach?, InterviewCoach?, InterviewCoach?>
    with $Provider<InterviewCoach?> {
  /// Nulo en modo local: practicar necesita el servidor.
  InterviewCoachProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interviewCoachProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interviewCoachHash();

  @$internal
  @override
  $ProviderElement<InterviewCoach?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InterviewCoach? create(Ref ref) {
    return interviewCoach(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InterviewCoach? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InterviewCoach?>(value),
    );
  }
}

String _$interviewCoachHash() => r'8c83da8981ca72a2e15e68ac3d26ad5651040987';
