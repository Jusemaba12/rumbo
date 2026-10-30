import 'package:rumbo/features/reminders/domain/repositories/reminder_settings_store.dart';
import 'package:rumbo/features/reminders/domain/services/reminder_plan.dart';
import 'package:rumbo/shared/utils/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsReminderSettingsStore implements ReminderSettingsStore {
  static const String _tag = 'PrefsReminderSettingsStore';
  static const String _processes = 'reminders.processes';
  static const String _daily = 'reminders.daily';
  static const String _asked = 'reminders.permissionAsked';

  Future<SharedPreferences?> get _prefs async {
    try {
      return await SharedPreferences.getInstance();
    } catch (error) {
      Log.w(tag: _tag, message: 'Preferencias no disponibles: $error');
      return null;
    }
  }

  @override
  Future<ReminderSettings> load() async {
    final SharedPreferences? prefs = await _prefs;
    return ReminderSettings(
      processes: prefs?.getBool(_processes) ?? true,
      daily: prefs?.getBool(_daily) ?? false,
    );
  }

  @override
  Future<void> save(ReminderSettings settings) async {
    final SharedPreferences? prefs = await _prefs;
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
