import 'package:rumbo/features/reminders/domain/services/reminder_plan.dart';

/// Guarda las preferencias de recordatorios en el propio teléfono: son de
/// este dispositivo, no de la cuenta.
abstract interface class ReminderSettingsStore {
  Future<ReminderSettings> load();
  Future<void> save(ReminderSettings settings);

  /// Si ya se pidió el permiso de notificaciones alguna vez.
  Future<bool> permissionAsked();
  Future<void> markPermissionAsked();
}
