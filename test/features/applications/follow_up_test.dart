import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/applications/domain/application.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/applications/domain/follow_up.dart';

void main() {
  final now = DateTime(2026, 10, 15, 9);
  const preparing = Application(
    jobId: 'job-1',
    status: ApplicationStatus.preparing,
  );

  test('al postular guarda la fecha y programa el seguimiento a 7 días', () {
    final applied = applyStatusChange(
      preparing,
      ApplicationStatus.applied,
      now,
    );
    expect(applied.appliedAt, now);
    expect(applied.nextFollowUpAt, DateTime(2026, 10, 22, 9));
  });

  test('avanzar reinicia el plazo y conserva la fecha de postulación', () {
    final applied = applyStatusChange(
      preparing,
      ApplicationStatus.applied,
      now,
    );
    final later = now.add(const Duration(days: 3));
    final review = applyStatusChange(
      applied,
      ApplicationStatus.inReview,
      later,
    );
    expect(review.appliedAt, now);
    expect(review.nextFollowUpAt, later.add(followUpAfter));
  });

  test('cerrar o marcar sin respuesta quita el seguimiento', () {
    final applied = applyStatusChange(
      preparing,
      ApplicationStatus.applied,
      now,
    );
    expect(
      applyStatusChange(
        applied,
        ApplicationStatus.rejected,
        now,
      ).nextFollowUpAt,
      isNull,
    );
    expect(
      applyStatusChange(
        applied,
        ApplicationStatus.noResponse,
        now,
      ).nextFollowUpAt,
      isNull,
    );
  });

  test('rechaza transiciones no permitidas', () {
    expect(
      () => applyStatusChange(preparing, ApplicationStatus.offer, now),
      throwsArgumentError,
    );
  });

  test('detecta seguimientos vencidos y procesos sin respuesta', () {
    final applied = applyStatusChange(
      preparing,
      ApplicationStatus.applied,
      now.subtract(const Duration(days: 22)),
    );
    expect(isFollowUpDue(applied, now), isTrue);
    expect(suggestsNoResponse(applied, now), isTrue);
    expect(isFollowUpDue(preparing, now), isFalse);
    expect(
      isFollowUpDue(applied, now.subtract(const Duration(days: 20))),
      isFalse,
    );
  });

  test('el tablero pone primero lo que pide acción', () {
    final due = Application(
      jobId: 'a',
      status: ApplicationStatus.applied,
      nextFollowUpAt: now.subtract(const Duration(days: 1)),
      updatedAt: DateTime(2026, 1),
    );
    final recent = Application(
      jobId: 'b',
      status: ApplicationStatus.applied,
      nextFollowUpAt: now.add(const Duration(days: 5)),
      updatedAt: DateTime(2026, 10),
    );
    final sorted = [recent, due]..sort((a, b) => compareForBoard(a, b, now));
    expect(sorted.first.jobId, 'a');
  });
}
