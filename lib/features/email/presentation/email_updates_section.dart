import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/company_mark.dart';
import '../../applications/presentation/application_widgets.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../interviews/presentation/interview_widgets.dart';
import '../../jobs/presentation/job_widgets.dart';
import '../domain/email_update.dart';
import 'email_controller.dart';

/// Propuestas detectadas en el correo, para aplicar o ignorar (Inicio).
class EmailUpdatesSection extends ConsumerWidget {
  const EmailUpdatesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updates = ref.watch(emailUpdatesControllerProvider).value ?? [];
    if (updates.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.emailUpdatesTitle, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 10),
          for (final update in updates) _UpdateCard(update: update),
        ],
      ),
    );
  }
}

class _UpdateCard extends ConsumerWidget {
  const _UpdateCard({required this.update});

  final EmailUpdate update;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final process = ref
        .watch(applicationsControllerProvider)
        .value
        ?.firstWhereOrNull((i) => i.application.id == update.applicationId);
    final controller = ref.read(emailUpdatesControllerProvider.notifier);
    Future<void> run(Future<void> Function() action, String done) async {
      final messenger = ScaffoldMessenger.of(context);
      try {
        await action();
        messenger.showSnackBar(SnackBar(content: Text(done)));
      } catch (_) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
      }
    }

    final status = update.suggestedStatus;
    final interviewAt = update.interviewAt;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (process != null) ...[
                  CompanyMark(company: process.job.company),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (process != null)
                        Text(
                          '${jobTitle(l10n, process.job)} · ${process.job.company}',
                          style: theme.textTheme.titleSmall,
                        ),
                      const SizedBox(height: 2),
                      Text(update.summary),
                      const SizedBox(height: 4),
                      Text(update.subject, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
            if (status != null || interviewAt != null) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (status != null) StatusPill(status: status),
                  if (interviewAt != null)
                    Text(
                      l10n.emailInterviewAt(
                        interviewWhen(context, interviewAt),
                      ),
                      style: theme.textTheme.bodySmall,
                    ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    key: Key('apply-${update.id}'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 44),
                    ),
                    onPressed: () =>
                        run(() => controller.apply(update), l10n.emailApplied),
                    child: Text(l10n.emailApply),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    key: Key('dismiss-${update.id}'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 44),
                    ),
                    onPressed: () => run(
                      () => controller.dismiss(update),
                      l10n.emailDismissed,
                    ),
                    child: Text(l10n.emailDismiss),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
