import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';

/// Días sin respuesta tras los que conviene escribir a la empresa.
const Duration followUpAfter = Duration(days: 7);

/// Días tras postular sin noticias para sugerir «Sin respuesta».
const Duration noResponseAfter = Duration(days: 21);

/// Aplica un cambio de estado y recalcula fechas de postulación y seguimiento.
Application applyStatusChange({
  required Application application,
  required ApplicationStatus to,
  required DateTime now,
}) {
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
bool isFollowUpDue({required Application application, required DateTime now}) {
  final DateTime? followUp = application.nextFollowUpAt;
  return application.status.isActive &&
      followUp != null &&
      !followUp.isAfter(now);
}

/// Se postuló hace tiempo y no hubo ningún avance.
bool suggestsNoResponse({
  required Application application,
  required DateTime now,
}) {
  final DateTime? applied = application.appliedAt;
  return application.status == ApplicationStatus.applied &&
      applied != null &&
      now.difference(applied) >= noResponseAfter;
}

/// Orden del tablero: primero lo que pide acción, luego lo más reciente.
int compareForBoard({
  required Application a,
  required Application b,
  required DateTime now,
}) {
  final bool dueA = isFollowUpDue(application: a, now: now);
  final bool dueB = isFollowUpDue(application: b, now: now);
  if (dueA != dueB) return dueA ? -1 : 1;
  final DateTime updatedA = a.updatedAt ?? a.createdAt ?? DateTime(0);
  final DateTime updatedB = b.updatedAt ?? b.createdAt ?? DateTime(0);
  return updatedB.compareTo(updatedA);
}
