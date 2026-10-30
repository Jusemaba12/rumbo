// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ofertas guardadas y sugeridas. Cada acción devuelve un [Result] y, si sale
/// bien, vuelve a leer la lista.

@ProviderFor(JobsController)
final jobsControllerProvider = JobsControllerProvider._();

/// Ofertas guardadas y sugeridas. Cada acción devuelve un [Result] y, si sale
/// bien, vuelve a leer la lista.
final class JobsControllerProvider
    extends $AsyncNotifierProvider<JobsController, List<SavedJob>> {
  /// Ofertas guardadas y sugeridas. Cada acción devuelve un [Result] y, si sale
  /// bien, vuelve a leer la lista.
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

String _$jobsControllerHash() => r'd86eff93cd2bbbeee9ef61316e3b86351b766ae5';

/// Ofertas guardadas y sugeridas. Cada acción devuelve un [Result] y, si sale
/// bien, vuelve a leer la lista.

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
