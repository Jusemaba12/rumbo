import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:rumbo/features/reminders/domain/repositories/reminder_settings_store.dart';
import 'package:rumbo/features/reminders/infrastructure/services/local_reminder_scheduler.dart';
import 'package:rumbo/features/reminders/infrastructure/services/prefs_reminder_settings_store.dart';

part 'reminders_providers.g.dart';

@Riverpod(keepAlive: true)
ReminderScheduler reminderScheduler(Ref ref) => LocalReminderScheduler();

@Riverpod(keepAlive: true)
ReminderSettingsStore reminderSettingsStore(Ref ref) =>
    PrefsReminderSettingsStore();
