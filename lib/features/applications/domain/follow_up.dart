import 'application.dart';
import 'application_status.dart';

/// Días sin respuesta tras los que conviene escribir a la empresa.
const followUpAfter = Duration(days: 7);

/// Días tras postular sin noticias para sugerir «Sin respuesta».
const noResponseAfter = Duration(days: 21);

/// Aplica un cambio de estado y recalcula fechas de postulación y seguimiento.
Application applyStatusChange(
  Application application,
  ApplicationStatus to,
  DateTime now,
) {
  if (!application.status.canMoveTo(to)) {
    throw ArgumentError('${application.status} no puede pasar a $to');
  }
  final DateTime? followUp = switch (to) {
    _ when to.isClosed => null,
    ApplicationStatus.noResponse => null,
    _ when to.isActive => now.add(followUpAfter),
    _ => application.nextFollowUpAt,
  };
  return application.copyWith(
    status: to,
    appliedAt: to == ApplicationStatus.applied && application.appliedAt == null
        ? now
        : application.appliedAt,
    nextFollowUpAt: followUp,
  );
}

/// Toca escribir a la empresa: el plazo de seguimiento ya pasó.
bool isFollowUpDue(Application application, DateTime now) {
  final followUp = application.nextFollowUpAt;
  return application.status.isActive &&
      followUp != null &&
      !followUp.isAfter(now);
}

/// Se postuló hace tiempo y no hubo ningún avance.
bool suggestsNoResponse(Application application, DateTime now) {
  final applied = application.appliedAt;
  return application.status == ApplicationStatus.applied &&
      applied != null &&
      now.difference(applied) >= noResponseAfter;
}

/// Orden del tablero: primero lo que pide acción, luego lo más reciente.
int compareForBoard(Application a, Application b, DateTime now) {
  final dueA = isFollowUpDue(a, now);
  final dueB = isFollowUpDue(b, now);
  if (dueA != dueB) return dueA ? -1 : 1;
  final updatedA = a.updatedAt ?? a.createdAt ?? DateTime(0);
  final updatedB = b.updatedAt ?? b.createdAt ?? DateTime(0);
  return updatedB.compareTo(updatedA);
}
