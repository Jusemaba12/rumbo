// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RemindersController)
final remindersControllerProvider = RemindersControllerProvider._();

final class RemindersControllerProvider
    extends $AsyncNotifierProvider<RemindersController, RemindersState> {
  RemindersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersControllerHash();

  @$internal
  @override
  RemindersController create() => RemindersController();
}

String _$remindersControllerHash() =>
    r'da950e42cc92880d4c7f60d2119a28a4ea70e495';

abstract class _$RemindersController extends $AsyncNotifier<RemindersState> {
  FutureOr<RemindersState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RemindersState>, RemindersState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RemindersState>, RemindersState>,
              AsyncValue<RemindersState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Avisos que tocan ahora según los procesos y entrevistas.

@ProviderFor(plannedReminders)
final plannedRemindersProvider = PlannedRemindersProvider._();

/// Avisos que tocan ahora según los procesos y entrevistas.

final class PlannedRemindersProvider
    extends
        $FunctionalProvider<
          List<PlannedReminder>,
          List<PlannedReminder>,
          List<PlannedReminder>
        >
    with $Provider<List<PlannedReminder>> {
  /// Avisos que tocan ahora según los procesos y entrevistas.
  PlannedRemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plannedRemindersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plannedRemindersHash();

  @$internal
  @override
  $ProviderElement<List<PlannedReminder>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PlannedReminder> create(Ref ref) {
    return plannedReminders(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PlannedReminder> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PlannedReminder>>(value),
    );
  }
}

String _$plannedRemindersHash() => r'4a72109778282a672ee8356fbb7957ae54a6d00c';
