// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OffersController)
final offersControllerProvider = OffersControllerProvider._();

final class OffersControllerProvider
    extends $AsyncNotifierProvider<OffersController, List<JobOffer>> {
  OffersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offersControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offersControllerHash();

  @$internal
  @override
  OffersController create() => OffersController();
}

String _$offersControllerHash() => r'53e36b96ad84cd1e834da962967a271a7a3d7af0';

abstract class _$OffersController extends $AsyncNotifier<List<JobOffer>> {
  FutureOr<List<JobOffer>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<JobOffer>>, List<JobOffer>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<JobOffer>>, List<JobOffer>>,
              AsyncValue<List<JobOffer>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
