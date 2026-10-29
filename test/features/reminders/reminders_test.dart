import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/core/time/clock.dart';
import 'package:rumbo/features/applications/data/applications_repository.dart';
import 'package:rumbo/features/applications/domain/application.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';
import 'package:rumbo/features/interviews/data/interviews_repository.dart';
import 'package:rumbo/features/interviews/domain/interview.dart';
import 'package:rumbo/features/jobs/data/jobs_repository.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/reminders/data/reminder_scheduler.dart';
import 'package:rumbo/features/reminders/data/reminder_settings_store.dart';
import 'package:rumbo/features/reminders/domain/reminder_plan.dart';

class _FakeScheduler implements ReminderScheduler {
  List<ScheduledNotice> notices = [];
  ScheduledNotice? daily;
  var permissionRequests = 0;
  var granted = true;

  @override
  Future<void> init(void Function(String route) onOpen) async {}

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return granted;
  }

  @override
  Future<void> replaceAll(
    List<ScheduledNotice> notices, {
    ScheduledNotice? daily,
  }) async {
    this.notices = notices;
    this.daily = daily;
  }

  @override
  Future<void> showNow(ScheduledNotice notice) async {}
}

class _MemoryStore implements ReminderSettingsStore {
  ReminderSettings settings = const ReminderSettings();
  bool asked = false;

  @override
  Future<ReminderSettings> load() async => settings;

  @override
  Future<void> save(ReminderSettings settings) async =>
      this.settings = settings;

  @override
  Future<bool> permissionAsked() async => asked;

  @override
  Future<void> markPermissionAsked() async => asked = true;
}

void main() {
  testWidgets('programa seguimientos y entrevistas y se configura en Más', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final now = DateTime(2026, 10, 16, 10);
    final jobs = InMemoryJobsRepository();
    await jobs.save(
      const SavedJob(
        job: Job(title: 'Flutter Developer', company: 'Fintech'),
      ),
    );
    final jobId = (await jobs.list()).single.job.id;
    final applications = InMemoryApplicationsRepository(jobs, clock: () => now);
    final process = await applications.save(
      Application(
        jobId: jobId,
        status: ApplicationStatus.applied,
        appliedAt: now.subtract(const Duration(days: 2)),
        nextFollowUpAt: now.add(const Duration(days: 5)),
      ),
    );
    final interviews = InMemoryInterviewsRepository();
    await interviews.save(
      Interview(
        applicationId: process.id,
        scheduledAt: DateTime(2026, 10, 18, 10, 30),
      ),
    );
    final scheduler = _FakeScheduler();
    final store = _MemoryStore();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          jobsRepositoryProvider.overrideWithValue(jobs),
          applicationsRepositoryProvider.overrideWithValue(applications),
          interviewsRepositoryProvider.overrideWithValue(interviews),
          clockProvider.overrideWithValue(() => now),
          reminderSchedulerProvider.overrideWithValue(scheduler),
          reminderSettingsStoreProvider.overrideWithValue(store),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    // La sincronización espera a que se calmen los cambios.
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(scheduler.permissionRequests, 1);
    expect(store.asked, isTrue);
    expect(scheduler.notices.map((n) => n.title).toList(), [
      'Mañana tienes entrevista',
      'Entrevista en una hora',
      'Toca hacer seguimiento',
    ]);
    expect(scheduler.notices.first.at, DateTime(2026, 10, 17, 19));
    expect(scheduler.notices.first.body, startsWith('Fintech a las 10:30.'));
    expect(scheduler.notices.last.route, '/applications/${process.id}');
    expect(scheduler.daily, isNull);

    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Recordatorios'));
    await tester.pumpAndSettle();
    expect(find.text('3 avisos programados.'), findsOneWidget);

    await tester.tap(find.byKey(const Key('remindersDaily')));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(store.settings.daily, isTrue);
    expect(scheduler.daily?.at, DateTime(2026, 10, 17, dailyHour));

    await tester.tap(find.byKey(const Key('remindersProcesses')));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(scheduler.notices, isEmpty);
    expect(find.text('No hay avisos programados.'), findsOneWidget);
    expect(scheduler.daily, isNotNull);
  });

  testWidgets('avisa si el teléfono deniega el permiso', (tester) async {
    final scheduler = _FakeScheduler()..granted = false;
    final store = _MemoryStore()
      ..settings = const ReminderSettings(processes: false);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
          reminderSchedulerProvider.overrideWithValue(scheduler),
          reminderSettingsStoreProvider.overrideWithValue(store),
        ],
        child: const RumboApp(locale: Locale('es')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Recordatorios'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('remindersProcesses')));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('remindersDenied')), findsOneWidget);
  });
}
