// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interviews_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InterviewsController)
final interviewsControllerProvider = InterviewsControllerProvider._();

final class InterviewsControllerProvider
    extends $AsyncNotifierProvider<InterviewsController, List<Interview>> {
  InterviewsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interviewsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interviewsControllerHash();

  @$internal
  @override
  InterviewsController create() => InterviewsController();
}

String _$interviewsControllerHash() =>
    r'0b65190ae2785f79c07ce6e4f625de0605494b89';

abstract class _$InterviewsController extends $AsyncNotifier<List<Interview>> {
  FutureOr<List<Interview>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Interview>>, List<Interview>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Interview>>, List<Interview>>,
              AsyncValue<List<Interview>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
