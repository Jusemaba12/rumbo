// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ApplicationsController)
final applicationsControllerProvider = ApplicationsControllerProvider._();

final class ApplicationsControllerProvider
    extends
        $AsyncNotifierProvider<
          ApplicationsController,
          List<ApplicationWithJob>
        > {
  ApplicationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicationsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicationsControllerHash();

  @$internal
  @override
  ApplicationsController create() => ApplicationsController();
}

String _$applicationsControllerHash() =>
    r'4b4b3235eaae1dbe41cf951d86b03c3398cbc40f';

abstract class _$ApplicationsController
    extends $AsyncNotifier<List<ApplicationWithJob>> {
  FutureOr<List<ApplicationWithJob>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ApplicationWithJob>>,
              List<ApplicationWithJob>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ApplicationWithJob>>,
                List<ApplicationWithJob>
              >,
              AsyncValue<List<ApplicationWithJob>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(applicationEvents)
final applicationEventsProvider = ApplicationEventsFamily._();

final class ApplicationEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ApplicationEvent>>,
          List<ApplicationEvent>,
          FutureOr<List<ApplicationEvent>>
        >
    with
        $FutureModifier<List<ApplicationEvent>>,
        $FutureProvider<List<ApplicationEvent>> {
  ApplicationEventsProvider._({
    required ApplicationEventsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'applicationEventsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$applicationEventsHash();

  @override
  String toString() {
    return r'applicationEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ApplicationEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ApplicationEvent>> create(Ref ref) {
    final argument = this.argument as String;
    return applicationEvents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ApplicationEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$applicationEventsHash() => r'4d40fa16db283fd620390c5654bd217f16a21364';

final class ApplicationEventsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ApplicationEvent>>, String> {
  ApplicationEventsFamily._()
    : super(
        retry: null,
        name: r'applicationEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ApplicationEventsProvider call(String applicationId) =>
      ApplicationEventsProvider._(argument: applicationId, from: this);

  @override
  String toString() => r'applicationEventsProvider';
}
