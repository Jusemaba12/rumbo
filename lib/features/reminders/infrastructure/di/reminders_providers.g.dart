// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reminderScheduler)
final reminderSchedulerProvider = ReminderSchedulerProvider._();

final class ReminderSchedulerProvider
    extends
        $FunctionalProvider<
          ReminderScheduler,
          ReminderScheduler,
          ReminderScheduler
        >
    with $Provider<ReminderScheduler> {
  ReminderSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSchedulerHash();

  @$internal
  @override
  $ProviderElement<ReminderScheduler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReminderScheduler create(Ref ref) {
    return reminderScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderScheduler>(value),
    );
  }
}

String _$reminderSchedulerHash() => r'a5941753a8a191312dee9a8350697a30ca5f818a';

@ProviderFor(reminderSettingsStore)
final reminderSettingsStoreProvider = ReminderSettingsStoreProvider._();

final class ReminderSettingsStoreProvider
    extends
        $FunctionalProvider<
          ReminderSettingsStore,
          ReminderSettingsStore,
          ReminderSettingsStore
        >
    with $Provider<ReminderSettingsStore> {
  ReminderSettingsStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSettingsStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSettingsStoreHash();

  @$internal
  @override
  $ProviderElement<ReminderSettingsStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReminderSettingsStore create(Ref ref) {
    return reminderSettingsStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderSettingsStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderSettingsStore>(value),
    );
  }
}

String _$reminderSettingsStoreHash() =>
    r'9cf58dcace039280062dac798c146d9060d94f92';
