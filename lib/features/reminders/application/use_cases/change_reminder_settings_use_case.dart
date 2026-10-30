import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:rumbo/features/reminders/domain/repositories/reminder_settings_store.dart';
import 'package:rumbo/features/reminders/domain/services/reminder_plan.dart';
import 'package:rumbo/features/reminders/infrastructure/di/reminders_providers.dart';

part 'change_reminder_settings_use_case.g.dart';

/// Guarda las preferencias y, si se activa algún aviso, pide permiso.
class ChangeReminderSettingsUseCase {
  const ChangeReminderSettingsUseCase({
    required this._store,
    required this._scheduler,
  });

  final ReminderSettingsStore _store;
  final ReminderScheduler _scheduler;

  /// Devuelve si el sistema denegó el permiso.
  Future<bool> call({
    required ReminderSettings settings,
    ReminderSettings? previous,
  }) async {
    bool denied = false;
    final bool enabling =
        (settings.processes && !(previous?.processes ?? false)) ||
        (settings.daily && !(previous?.daily ?? false));
    if (enabling) {
      denied = !await _scheduler.requestPermission();
      await _store.markPermissionAsked();
    }
    await _store.save(settings);
    return denied;
  }
}

@Riverpod(keepAlive: true)
ChangeReminderSettingsUseCase changeReminderSettingsUseCase(Ref ref) =>
    ChangeReminderSettingsUseCase(
      store: ref.watch(reminderSettingsStoreProvider),
      scheduler: ref.watch(reminderSchedulerProvider),
    );
