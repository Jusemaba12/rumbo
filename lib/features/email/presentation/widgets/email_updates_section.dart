import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/applications/presentation/widgets/application_widgets.dart';
import 'package:rumbo/features/email/domain/entities/email_update.dart';
import 'package:rumbo/features/email/presentation/providers/email/email_provider.dart';
import 'package:rumbo/features/interviews/presentation/widgets/interview_widgets.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/widgets/company_mark.dart';

/// Propuestas detectadas en el correo, para aplicar o ignorar (Inicio).
class EmailUpdatesSection extends ConsumerWidget {
  const EmailUpdatesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<EmailUpdate> updates =
        ref.watch(emailUpdatesControllerProvider).value ?? <EmailUpdate>[];
    if (updates.isEmpty) return const SizedBox.shrink();
    final AppLocalizations l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.emailUpdatesTitle, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 10),
          for (final EmailUpdate update in updates) _UpdateCard(update: update),
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
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final ApplicationWithJob? process = ref
        .watch(applicationsControllerProvider)
        .value
        ?.firstWhereOrNull(
          (ApplicationWithJob i) => i.application.id == update.applicationId,
        );
    final EmailUpdatesController controller = ref.read(
      emailUpdatesControllerProvider.notifier,
    );
    Future<void> run(
      Future<Result<void>> Function() action,
      String done,
    ) async {
      final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
      showResultSnackBar(
        messenger: messenger,
        l10n: l10n,
        result: await action(),
        success: done,
      );
    }

    final ApplicationStatus? status = update.suggestedStatus;
    final DateTime? interviewAt = update.interviewAt;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (process != null) ...<Widget>[
                  CompanyMark(company: process.job.company),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (process != null)
                        Text(
                          '${jobTitle(l10n, process.job)} · '
                          '${process.job.company}',
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
            if (status != null || interviewAt != null) ...<Widget>[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
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
              children: <Widget>[
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
