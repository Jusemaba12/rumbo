// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_settings_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
