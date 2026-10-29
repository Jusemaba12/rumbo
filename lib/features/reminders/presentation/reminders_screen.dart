import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/group_card.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../data/reminder_scheduler.dart';
import 'reminders_controller.dart';

/// Activar o desactivar los recordatorios locales y probarlos.
class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final state = ref.watch(remindersControllerProvider).value;
    final planned = ref.watch(plannedRemindersProvider).length;
    final controller = ref.read(remindersControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.remindersTitle)),
      body: state == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              children: [
                Text(
                  l10n.remindersHint,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: context.colors.muted,
                  ),
                ),
                const SizedBox(height: 16),
                if (state.denied) ...[
                  NoticeBanner(
                    key: const Key('remindersDenied'),
                    text: l10n.remindersDenied,
                    icon: Icons.notifications_off_outlined,
                    tone: Tone.risk,
                  ),
                  const SizedBox(height: 16),
                ],
                GroupCard(
                  children: [
                    SwitchListTile(
                      key: const Key('remindersProcesses'),
                      title: Text(l10n.remindersProcesses),
                      subtitle: Text(l10n.remindersProcessesHint),
                      value: state.settings.processes,
                      onChanged: (value) => controller.change(
                        state.settings.copyWith(processes: value),
                      ),
                    ),
                    SwitchListTile(
                      key: const Key('remindersDaily'),
                      title: Text(l10n.remindersDaily),
                      subtitle: Text(l10n.remindersDailyHint),
                      value: state.settings.daily,
                      onChanged: (value) => controller.change(
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
                      final scheduler = ref.read(reminderSchedulerProvider);
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
