// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AnswersController)
final answersControllerProvider = AnswersControllerProvider._();

final class AnswersControllerProvider
    extends $AsyncNotifierProvider<AnswersController, List<SavedAnswer>> {
  AnswersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'answersControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$answersControllerHash();

  @$internal
  @override
  AnswersController create() => AnswersController();
}

String _$answersControllerHash() => r'a82b3556645367fd9f5ac3428713f3c7a8dfce43';

abstract class _$AnswersController extends $AsyncNotifier<List<SavedAnswer>> {
  FutureOr<List<SavedAnswer>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SavedAnswer>>, List<SavedAnswer>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SavedAnswer>>, List<SavedAnswer>>,
              AsyncValue<List<SavedAnswer>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
