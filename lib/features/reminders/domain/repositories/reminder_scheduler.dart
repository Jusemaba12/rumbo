import 'package:rumbo/features/reminders/domain/entities/scheduled_notice.dart';

/// Programa avisos locales en el teléfono (sin servidor ni Firebase).
abstract interface class ReminderScheduler {
  /// Prepara el sistema; [onOpen] recibe la ruta del aviso tocado.
  Future<void> init(void Function(String route) onOpen);

  /// Pide permiso para mostrar notificaciones. Falso si se deniega.
  Future<bool> requestPermission();

  /// Sustituye todos los avisos programados por estos. [daily] se repite
  /// cada día a su hora.
  Future<void> replaceAll(
    List<ScheduledNotice> notices, {
    ScheduledNotice? daily,
  });

  /// Muestra un aviso al momento (prueba).
  Future<void> showNow(ScheduledNotice notice);
}
