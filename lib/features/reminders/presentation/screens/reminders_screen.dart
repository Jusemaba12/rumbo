import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/reminders/domain/entities/scheduled_notice.dart';
import 'package:rumbo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:rumbo/features/reminders/infrastructure/di/reminders_providers.dart';
import 'package:rumbo/features/reminders/presentation/providers/reminders/reminders_provider.dart';
import 'package:rumbo/features/reminders/presentation/providers/reminders/reminders_state.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/widgets/group_card.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';

/// Activar o desactivar los recordatorios locales y probarlos.
class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final RemindersState? state = ref.watch(remindersControllerProvider).value;
    final int planned = ref.watch(plannedRemindersProvider).length;
    final RemindersController controller = ref.read(
      remindersControllerProvider.notifier,
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.remindersTitle)),
      body: state == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              children: <Widget>[
                Text(
                  l10n.remindersHint,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: context.colors.muted,
                  ),
                ),
                const SizedBox(height: 16),
                if (state.denied) ...<Widget>[
                  NoticeBanner(
                    key: const Key('remindersDenied'),
                    text: l10n.remindersDenied,
                    icon: Icons.notifications_off_outlined,
                    tone: Tone.risk,
                  ),
                  const SizedBox(height: 16),
                ],
                GroupCard(
                  children: <Widget>[
                    SwitchListTile(
                      key: const Key('remindersProcesses'),
                      title: Text(l10n.remindersProcesses),
                      subtitle: Text(l10n.remindersProcessesHint),
                      value: state.settings.processes,
                      onChanged: (bool value) => controller.change(
                        state.settings.copyWith(processes: value),
                      ),
                    ),
                    SwitchListTile(
                      key: const Key('remindersDaily'),
                      title: Text(l10n.remindersDaily),
                      subtitle: Text(l10n.remindersDailyHint),
                      value: state.settings.daily,
                      onChanged: (bool value) => controller.change(
                        state.settings.copyWith(daily: value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.remindersPlanned(planned),
                  key: const Key('remindersPlanned'),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    key: const Key('remindersTest'),
                    onPressed: () async {
                      final ReminderScheduler scheduler = ref.read(
                        reminderSchedulerProvider,
                      );
                      await scheduler.requestPermission();
                      await scheduler.showNow(
                        ScheduledNotice(
                          id: 1,
                          at: DateTime.now(),
                          title: l10n.reminderTestTitle,
                          body: l10n.reminderTestBody,
                        ),
                      );
                    },
                    icon: const Icon(Icons.notifications_active_outlined),
                    label: Text(l10n.remindersTest),
                  ),
                ),
              ],
            ),
    );
  }
}
