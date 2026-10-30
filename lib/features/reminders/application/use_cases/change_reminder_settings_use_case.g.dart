// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_reminder_settings_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(changeReminderSettingsUseCase)
final changeReminderSettingsUseCaseProvider =
    ChangeReminderSettingsUseCaseProvider._();

final class ChangeReminderSettingsUseCaseProvider
    extends
        $FunctionalProvider<
          ChangeReminderSettingsUseCase,
          ChangeReminderSettingsUseCase,
          ChangeReminderSettingsUseCase
        >
    with $Provider<ChangeReminderSettingsUseCase> {
  ChangeReminderSettingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changeReminderSettingsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changeReminderSettingsUseCaseHash();

  @$internal
  @override
  $ProviderElement<ChangeReminderSettingsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChangeReminderSettingsUseCase create(Ref ref) {
    return changeReminderSettingsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChangeReminderSettingsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChangeReminderSettingsUseCase>(
        value,
      ),
    );
  }
}

String _$changeReminderSettingsUseCaseHash() =>
    r'4c5d7532732972d0eec50c65891c6d7b8d895eed';
