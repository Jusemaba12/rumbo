import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/presentation/providers/interviews/interviews_provider.dart';
import 'package:rumbo/features/reminders/application/use_cases/change_reminder_settings_use_case.dart';
import 'package:rumbo/features/reminders/domain/services/reminder_plan.dart';
import 'package:rumbo/features/reminders/infrastructure/di/reminders_providers.dart';
import 'package:rumbo/features/reminders/presentation/providers/reminders/reminders_state.dart';
import 'package:rumbo/shared/application/services/clock.dart';

part 'reminders_provider.g.dart';

@Riverpod(keepAlive: true)
class RemindersController extends _$RemindersController {
  @override
  Future<RemindersState> build() async => RemindersState(
    settings: await ref.read(reminderSettingsStoreProvider).load(),
  );

  Future<void> change(ReminderSettings settings) async {
    final bool denied = await ref.read(changeReminderSettingsUseCaseProvider)(
      settings: settings,
      previous: state.value?.settings,
    );
    state = AsyncData<RemindersState>(
      RemindersState(settings: settings, denied: denied),
    );
  }
}

/// Avisos que tocan ahora según los procesos y entrevistas.
@Riverpod(keepAlive: true)
List<PlannedReminder> plannedReminders(Ref ref) {
  final ReminderSettings? settings = ref
      .watch(remindersControllerProvider)
      .value
      ?.settings;
  if (settings == null || !settings.processes) return const <PlannedReminder>[];
  return planReminders(
    applications:
        ref.watch(applicationsControllerProvider).value ??
        const <ApplicationWithJob>[],
    interviews:
        ref.watch(interviewsControllerProvider).value ?? const <Interview>[],
    now: ref.watch(clockProvider)(),
  );
}
