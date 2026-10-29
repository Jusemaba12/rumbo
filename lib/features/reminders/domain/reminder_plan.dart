import 'package:freezed_annotation/freezed_annotation.dart';

import '../../applications/domain/application.dart';
import '../../interviews/domain/interview.dart';

part 'reminder_plan.freezed.dart';

enum ReminderKind { followUp, interviewEve, interviewSoon, daily }

/// Preferencias de los recordatorios locales.
@freezed
abstract class ReminderSettings with _$ReminderSettings {
  const factory ReminderSettings({
    /// Seguimientos y entrevistas.
    @Default(true) bool processes,

    /// Aviso diario para revisar sugerencias y tareas.
    @Default(false) bool daily,
  }) = _ReminderSettings;
}

/// Un aviso a programar en el teléfono. Sin textos: los pone la app en el
/// idioma del usuario.
@freezed
abstract class PlannedReminder with _$PlannedReminder {
  const PlannedReminder._();

  const factory PlannedReminder({
    required ReminderKind kind,

    /// Hora local del aviso.
    required DateTime at,
    String? applicationId,
    @Default('') String company,
    @Default('') String role,
    DateTime? interviewAt,
  }) = _PlannedReminder;

  /// Identificador estable de 31 bits (Android lo exige): el mismo aviso
  /// conserva el número al reprogramarse. FNV-1a sobre su clave.
  int get id {
    final key =
        '${kind.name}|${applicationId ?? ''}|'
        '${interviewAt?.millisecondsSinceEpoch ?? ''}';
    var hash = 0x811c9dc5;
    for (final unit in key.codeUnits) {
      hash = ((hash ^ unit) * 0x01000193) & 0xFFFFFFFF;
    }
    return hash & 0x7FFFFFFF;
  }
}

/// Horas fijas de los avisos.
const followUpHour = 9;
const interviewEveHour = 19;
const dailyHour = 8;
const interviewSoonBefore = Duration(hours: 1);

/// iOS no guarda más de 64 avisos pendientes; se deja margen.
const maxReminders = 60;

/// Avisos futuros de seguimientos y entrevistas, del más próximo al más
/// lejano. El diario se programa aparte porque se repite.
List<PlannedReminder> planReminders({
  required List<ApplicationWithJob> applications,
  required List<Interview> interviews,
  required DateTime now,
}) {
  final byId = {for (final item in applications) item.application.id: item};
  final plan =
      <PlannedReminder>[
          for (final item in applications)
            if (item.application.status.isActive)
              if (item.application.nextFollowUpAt case final followUp?)
                PlannedReminder(
                  kind: ReminderKind.followUp,
                  at: DateTime(
                    followUp.year,
                    followUp.month,
                    followUp.day,
                    followUpHour,
                  ),
                  applicationId: item.application.id,
                  company: item.job.company,
                  role: item.job.title,
                ),
          for (final interview in interviews)
            if (byId[interview.applicationId] case final process?) ...[
              PlannedReminder(
                kind: ReminderKind.interviewEve,
                at: DateTime(
                  interview.scheduledAt.year,
                  interview.scheduledAt.month,
                  interview.scheduledAt.day - 1,
                  interviewEveHour,
                ),
                applicationId: process.application.id,
                company: process.job.company,
                role: process.job.title,
                interviewAt: interview.scheduledAt,
              ),
              PlannedReminder(
                kind: ReminderKind.interviewSoon,
                at: interview.scheduledAt.subtract(interviewSoonBefore),
                applicationId: process.application.id,
                company: process.job.company,
                role: process.job.title,
                interviewAt: interview.scheduledAt,
              ),
            ],
        ].where((reminder) => reminder.at.isAfter(now)).toList()
        ..sort((a, b) => a.at.compareTo(b.at));
  return plan.take(maxReminders).toList();
}
