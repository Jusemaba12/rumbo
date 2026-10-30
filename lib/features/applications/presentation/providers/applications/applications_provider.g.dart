// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tablero de procesos. Cada acción devuelve un [Result] y, si sale bien,
/// vuelve a leer la lista.

@ProviderFor(ApplicationsController)
final applicationsControllerProvider = ApplicationsControllerProvider._();

/// Tablero de procesos. Cada acción devuelve un [Result] y, si sale bien,
/// vuelve a leer la lista.
final class ApplicationsControllerProvider
    extends
        $AsyncNotifierProvider<
          ApplicationsController,
          List<ApplicationWithJob>
        > {
  /// Tablero de procesos. Cada acción devuelve un [Result] y, si sale bien,
  /// vuelve a leer la lista.
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
    r'3656c41d11052b26ef0b9f3ec5cfe12dc978411e';

/// Tablero de procesos. Cada acción devuelve un [Result] y, si sale bien,
/// vuelve a leer la lista.

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

String _$applicationEventsHash() => r'9b100f01862c67b2ae92b9c859b0eac17ef3569d';

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
