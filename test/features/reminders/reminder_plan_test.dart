import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/reminders/domain/services/reminder_plan.dart';

void main() {
  final DateTime now = DateTime(2026, 10, 16, 10);

  ApplicationWithJob process(
    String id, {
    ApplicationStatus status = ApplicationStatus.applied,
    DateTime? followUp,
  }) => ApplicationWithJob(
    application: Application(
      id: id,
      jobId: 'job-$id',
      status: status,
      nextFollowUpAt: followUp,
    ),
    job: Job(title: 'Flutter Developer', company: 'Empresa $id'),
  );

  test('seguimiento a las 9:00 del día que toca; los pasados no', () {
    final List<PlannedReminder> plan = planReminders(
      applications: <ApplicationWithJob>[
        process('a', followUp: DateTime(2026, 10, 20, 15)),
        // Hoy, pero ya pasaron las 9:00: Inicio ya lo muestra.
        process('b', followUp: DateTime(2026, 10, 16, 8)),
        // Cerrado: no se le hace seguimiento.
        process(
          'c',
          status: ApplicationStatus.rejected,
          followUp: DateTime(2026, 10, 25),
        ),
      ],
      interviews: const <Interview>[],
      now: now,
    );
    expect(plan, hasLength(1));
    expect(plan.single.kind, ReminderKind.followUp);
    expect(plan.single.at, DateTime(2026, 10, 20, 9));
    expect(plan.single.company, 'Empresa a');
  });

  test('entrevista: la víspera a las 19:00 y una hora antes', () {
    final List<PlannedReminder> plan = planReminders(
      applications: <ApplicationWithJob>[process('a')],
      interviews: <Interview>[
        Interview(applicationId: 'a', scheduledAt: DateTime(2026, 10, 18, 10)),
        // Mañana temprano: la víspera es hoy a las 19:00, aún a tiempo.
        Interview(applicationId: 'a', scheduledAt: DateTime(2026, 10, 17, 9)),
        // De un proceso que ya no existe.
        Interview(applicationId: 'x', scheduledAt: DateTime(2026, 10, 19, 9)),
      ],
      now: now,
    );
    expect(
      plan.map((PlannedReminder r) => (r.kind, r.at)).toList(),
      <(ReminderKind, DateTime)>[
        (ReminderKind.interviewEve, DateTime(2026, 10, 16, 19)),
        (ReminderKind.interviewSoon, DateTime(2026, 10, 17, 8)),
        (ReminderKind.interviewEve, DateTime(2026, 10, 17, 19)),
        (ReminderKind.interviewSoon, DateTime(2026, 10, 18, 9)),
      ],
    );
    // Cada aviso tiene su número y es el mismo al volver a planificar.
    expect(plan.map((PlannedReminder r) => r.id).toSet(), hasLength(4));
    final List<PlannedReminder> again = planReminders(
      applications: <ApplicationWithJob>[process('a')],
      interviews: <Interview>[
        Interview(applicationId: 'a', scheduledAt: DateTime(2026, 10, 18, 10)),
      ],
      now: now,
    );
    expect(again.first.id, plan[2].id);
    expect(
      plan.every((PlannedReminder r) => r.id >= 0 && r.id < 0x80000000),
      isTrue,
    );
  });

  test('no pasa del máximo que admite iOS', () {
    final List<PlannedReminder> plan = planReminders(
      applications: <ApplicationWithJob>[
        for (int i = 0; i < 80; i++)
          process('p$i', followUp: now.add(Duration(days: i + 1))),
      ],
      interviews: const <Interview>[],
      now: now,
    );
    expect(plan, hasLength(maxReminders));
    expect(plan.first.at, DateTime(2026, 10, 17, 9));
  });
}
