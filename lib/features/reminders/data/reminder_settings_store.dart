import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/reminder_plan.dart';

part 'reminder_settings_store.g.dart';

/// Guarda las preferencias de recordatorios en el propio teléfono: son de
/// este dispositivo, no de la cuenta.
abstract interface class ReminderSettingsStore {
  Future<ReminderSettings> load();
  Future<void> save(ReminderSettings settings);

  /// Si ya se pidió el permiso de notificaciones alguna vez.
  Future<bool> permissionAsked();
  Future<void> markPermissionAsked();
}

class PrefsReminderSettingsStore implements ReminderSettingsStore {
  static const _processes = 'reminders.processes';
  static const _daily = 'reminders.daily';
  static const _asked = 'reminders.permissionAsked';

  Future<SharedPreferences?> get _prefs async {
    try {
      return await SharedPreferences.getInstance();
    } catch (error) {
      debugPrint('reminders: preferencias no disponibles: $error');
      return null;
    }
  }

  @override
  Future<ReminderSettings> load() async {
    final prefs = await _prefs;
    return ReminderSettings(
      processes: prefs?.getBool(_processes) ?? true,
      daily: prefs?.getBool(_daily) ?? false,
    );
  }

  @override
  Future<void> save(ReminderSettings settings) async {
    final prefs = await _prefs;
    await prefs?.setBool(_processes, settings.processes);
    await prefs?.setBool(_daily, settings.daily);
  }

  @override
  Future<bool> permissionAsked() async =>
      (await _prefs)?.getBool(_asked) ?? false;

  @override
  Future<void> markPermissionAsked() async =>
      (await _prefs)?.setBool(_asked, true);
}

@Riverpod(keepAlive: true)
ReminderSettingsStore reminderSettingsStore(Ref ref) =>
    PrefsReminderSettingsStore();
