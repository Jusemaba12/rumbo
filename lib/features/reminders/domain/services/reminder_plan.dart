import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';

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
    final String key =
        '${kind.name}|${applicationId ?? ''}|'
        '${interviewAt?.millisecondsSinceEpoch ?? ''}';
    int hash = 0x811c9dc5;
    for (final int unit in key.codeUnits) {
      hash = ((hash ^ unit) * 0x01000193) & 0xFFFFFFFF;
    }
    return hash & 0x7FFFFFFF;
  }
}

/// Horas fijas de los avisos.
const int followUpHour = 9;
const int interviewEveHour = 19;
const int dailyHour = 8;
const Duration interviewSoonBefore = Duration(hours: 1);

/// iOS no guarda más de 64 avisos pendientes; se deja margen.
const int maxReminders = 60;

/// Avisos futuros de seguimientos y entrevistas, del más próximo al más
/// lejano. El diario se programa aparte porque se repite.
List<PlannedReminder> planReminders({
  required List<ApplicationWithJob> applications,
  required List<Interview> interviews,
  required DateTime now,
}) {
  final Map<String, ApplicationWithJob> byId = <String, ApplicationWithJob>{
    for (final ApplicationWithJob item in applications)
      item.application.id: item,
  };
  final List<PlannedReminder> plan =
      <PlannedReminder>[
          for (final ApplicationWithJob item in applications)
            if (item.application.status.isActive)
              if (item.application.nextFollowUpAt case final DateTime followUp?)
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
          for (final Interview interview in interviews)
            if (byId[interview.applicationId]
                case final ApplicationWithJob process?) ...<PlannedReminder>[
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
        ].where((PlannedReminder reminder) => reminder.at.isAfter(now)).toList()
        ..sort((PlannedReminder a, PlannedReminder b) => a.at.compareTo(b.at));
  return plan.take(maxReminders).toList();
}
