// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JobsController)
final jobsControllerProvider = JobsControllerProvider._();

final class JobsControllerProvider
    extends $AsyncNotifierProvider<JobsController, List<SavedJob>> {
  JobsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jobsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jobsControllerHash();

  @$internal
  @override
  JobsController create() => JobsController();
}

String _$jobsControllerHash() => r'22d5a179ea254609a8af858524457f138895ed93';

abstract class _$JobsController extends $AsyncNotifier<List<SavedJob>> {
  FutureOr<List<SavedJob>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<SavedJob>>, List<SavedJob>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SavedJob>>, List<SavedJob>>,
              AsyncValue<List<SavedJob>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
