import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/domain/services/follow_up.dart';

void main() {
  final DateTime now = DateTime(2026, 10, 15, 9);
  const Application preparing = Application(
    jobId: 'job-1',
    status: ApplicationStatus.preparing,
  );

  test('al postular guarda la fecha y programa el seguimiento a 7 días', () {
    final Application applied = applyStatusChange(
      application: preparing,
      to: ApplicationStatus.applied,
      now: now,
    );
    expect(applied.appliedAt, now);
    expect(applied.nextFollowUpAt, DateTime(2026, 10, 22, 9));
  });

  test('avanzar reinicia el plazo y conserva la fecha de postulación', () {
    final Application applied = applyStatusChange(
      application: preparing,
      to: ApplicationStatus.applied,
      now: now,
    );
    final DateTime later = now.add(const Duration(days: 3));
    final Application review = applyStatusChange(
      application: applied,
      to: ApplicationStatus.inReview,
      now: later,
    );
    expect(review.appliedAt, now);
    expect(review.nextFollowUpAt, later.add(followUpAfter));
  });

  test('cerrar o marcar sin respuesta quita el seguimiento', () {
    final Application applied = applyStatusChange(
      application: preparing,
      to: ApplicationStatus.applied,
      now: now,
    );
    expect(
      applyStatusChange(
        application: applied,
        to: ApplicationStatus.rejected,
        now: now,
      ).nextFollowUpAt,
      isNull,
    );
    expect(
      applyStatusChange(
        application: applied,
        to: ApplicationStatus.noResponse,
        now: now,
      ).nextFollowUpAt,
      isNull,
    );
  });

  test('rechaza transiciones no permitidas', () {
    expect(
      () => applyStatusChange(
        application: preparing,
        to: ApplicationStatus.offer,
        now: now,
      ),
      throwsArgumentError,
    );
  });

  test('detecta seguimientos vencidos y procesos sin respuesta', () {
    final Application applied = applyStatusChange(
      application: preparing,
      to: ApplicationStatus.applied,
      now: now.subtract(const Duration(days: 22)),
    );
    expect(isFollowUpDue(application: applied, now: now), isTrue);
    expect(suggestsNoResponse(application: applied, now: now), isTrue);
    expect(isFollowUpDue(application: preparing, now: now), isFalse);
    expect(
      isFollowUpDue(
        application: applied,
        now: now.subtract(const Duration(days: 20)),
      ),
      isFalse,
    );
  });

  test('el tablero pone primero lo que pide acción', () {
    final Application due = Application(
      jobId: 'a',
      status: ApplicationStatus.applied,
      nextFollowUpAt: now.subtract(const Duration(days: 1)),
      updatedAt: DateTime(2026, 1),
    );
    final Application recent = Application(
      jobId: 'b',
      status: ApplicationStatus.applied,
      nextFollowUpAt: now.add(const Duration(days: 5)),
      updatedAt: DateTime(2026, 10),
    );
    final List<Application> sorted = <Application>[recent, due]
      ..sort(
        (Application a, Application b) => compareForBoard(a: a, b: b, now: now),
      );
    expect(sorted.first.jobId, 'a');
  });
}
