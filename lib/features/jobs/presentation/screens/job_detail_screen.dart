import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:rumbo/features/applications/application/use_cases/tailor_resume_use_case.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/applications/presentation/screens/prepare_application_screen.dart';
import 'package:rumbo/features/applications/presentation/widgets/application_widgets.dart';
import 'package:rumbo/features/email/application/use_cases/draft_email_use_case.dart';
import 'package:rumbo/features/jobs/application/use_cases/analyze_job_use_case.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_contact_section.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/features/practice/application/use_cases/next_practice_turn_use_case.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';
import 'package:rumbo/shared/presentation/widgets/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailScreen extends ConsumerWidget {
  const JobDetailScreen({super.key, required this.jobId});

  final String jobId;

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    String title,
  ) async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final NavigatorState navigator = Navigator.of(context);
    if (!await confirmDelete(context, title)) return;
    final Result<void> result = await ref
        .read(jobsControllerProvider.notifier)
        .delete(jobId);
    if (showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: result,
      success: l10n.jobDeleted,
    )) {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final SavedJob? saved = ref
        .watch(jobsControllerProvider)
        .value
        ?.firstWhereOrNull((SavedJob item) => item.job.id == jobId);
    if (saved == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.jobNotFound)),
      );
    }
    final Job job = saved.job;
    final JobMatch? match = saved.match;
    final String? url = job.url;
    final bool canPrepare = ref.watch(tailorResumeUseCaseProvider).isAvailable;
    final bool canComplete = ref.watch(analyzeJobUseCaseProvider).isAvailable;
    final bool canApplyByEmail = ref
        .watch(draftEmailUseCaseProvider)
        .isAvailable;
    final bool canPractice =
        ref.watch(nextPracticeTurnUseCaseProvider).isAvailable && job.isSaved;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          if (canComplete && !job.needsDescription)
            IconButton(
              key: const Key('completeJobAction'),
              tooltip: l10n.jobUpdateDescription,
              icon: const Icon(Icons.edit_note),
              onPressed: () => JobCompleteRoute(id: job.id).push(context),
            ),
          IconButton(
            tooltip: l10n.delete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _delete(context, ref, jobTitle(l10n, job)),
          ),
        ],
      ),
      bottomNavigationBar: canPrepare
          ? DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border(top: BorderSide(color: context.colors.line)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: PrepareApplicationButton(
                    onPressed: () => JobPrepareRoute(id: job.id).push(context),
                  ),
                ),
              ),
            )
          : null,
      body: PullToRefresh(
        providers: <Refreshable<Future<Object?>>>[
          jobsControllerProvider.future,
          applicationsControllerProvider.future,
        ],
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: <Widget>[
            JobHeader(job: job),
            if (sourceName(job.source) case final String source?) ...<Widget>[
              const SizedBox(height: 6),
              Text(l10n.foundOn(source), style: theme.textTheme.bodySmall),
            ],
            if (canComplete && job.needsDescription) ...<Widget>[
              const SizedBox(height: 14),
              NoticeBanner(
                key: const Key('jobNeedsDescription'),
                text: l10n.jobNeedsDescription,
                icon: Icons.short_text,
                tone: Tone.signal,
                action: TextButton(
                  key: const Key('completeJobBanner'),
                  onPressed: () => JobCompleteRoute(id: job.id).push(context),
                  child: Text(l10n.jobCompleteTitle),
                ),
              ),
            ],
            const SizedBox(height: 18),
            if (job.isSuggestion)
              _SuggestionActions(jobId: job.id)
            else
              _ProcessRow(jobId: job.id),
            if (match != null) ...<Widget>[
              const SizedBox(height: 16),
              JobMatchSection(match: match),
            ],
            if (canApplyByEmail && job.appliesByEmail) ...<Widget>[
              const SizedBox(height: 16),
              FilledButton.tonalIcon(
                key: const Key('applyByEmail'),
                onPressed: () => JobApplyEmailRoute(id: job.id).push(context),
                icon: const Icon(Icons.forward_to_inbox),
                label: Text(l10n.applyEmailTitle),
              ),
            ],
            const SizedBox(height: 16),
            JobContactSection(job: job),
            if (canPractice || url != null) ...<Widget>[
              const SizedBox(height: 16),
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    if (canPractice) ...<Widget>[
                      _LinkRow(
                        key: const Key('companyBrief'),
                        icon: Icons.apartment_outlined,
                        label: l10n.briefOpen,
                        onTap: () => JobCompanyRoute(id: job.id).push(context),
                      ),
                      const Divider(indent: 52),
                      _LinkRow(
                        key: const Key('practiceInterview'),
                        icon: Icons.record_voice_over_outlined,
                        label: l10n.practiceOpen,
                        onTap: () => JobPracticeRoute(id: job.id).push(context),
                      ),
                    ],
                    if (url != null) ...<Widget>[
                      if (canPractice) const Divider(indent: 52),
                      _LinkRow(
                        icon: Icons.open_in_new,
                        label: l10n.jobOpenLink,
                        onTap: () => launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
            if (job.requirements.isNotEmpty) ...<Widget>[
              const SizedBox(height: 28),
              JobRequirements(requirements: job.requirements),
            ],
            if (job.description.isNotEmpty) ...<Widget>[
              const SizedBox(height: 24),
              Text(l10n.jobDescription, style: AppTheme.sectionTitle(context)),
              const SizedBox(height: 8),
              Text(job.description),
            ],
          ],
        ),
      ),
    );
  }
}

/// Fila de un grupo de accesos: icono, texto y flecha.
class _LinkRow extends StatelessWidget {
  const _LinkRow({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: context.colors.text),
    title: Text(label),
    trailing: const Icon(Icons.chevron_right),
    minTileHeight: 54,
    onTap: onTap,
  );
}

/// Estado del proceso de esta oferta, o botón para empezar a seguirla.
class _ProcessRow extends ConsumerWidget {
  const _ProcessRow({required this.jobId});

  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    ref.watch(applicationsControllerProvider);
    final ApplicationsController controller = ref.read(
      applicationsControllerProvider.notifier,
    );
    final Application? application = controller.forJob(jobId);
    if (application == null) {
      return OutlinedButton.icon(
        key: const Key('trackJob'),
        onPressed: () => controller.startForJob(jobId),
        icon: const Icon(Icons.view_kanban_outlined),
        label: Text(l10n.trackJob),
      );
    }
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 6, 6),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(l10n.processStatus),
                  StatusPill(status: application.status),
                ],
              ),
            ),
            TextButton(
              onPressed: () =>
                  ApplicationDetailRoute(id: application.id).go(context),
              child: Text(l10n.viewProcess),
            ),
          ],
        ),
      ),
    );
  }
}

/// Guardar o descartar una oferta sugerida por la búsqueda.
class _SuggestionActions extends ConsumerWidget {
  const _SuggestionActions({required this.jobId});

  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final JobsController jobs = ref.read(jobsControllerProvider.notifier);
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

    return Row(
      children: <Widget>[
        Expanded(
          child: FilledButton(
            key: const Key('keepSuggestion'),
            style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
            onPressed: () =>
                run(() => jobs.keepSuggestion(jobId), l10n.suggestionKept),
            child: Text(l10n.suggestionKeep),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            key: const Key('dismissSuggestion'),
            onPressed: () async {
              final NavigatorState navigator = Navigator.of(context);
              await run(
                () => jobs.dismissSuggestion(jobId),
                l10n.suggestionDismissed,
              );
              navigator.pop();
            },
            child: Text(l10n.suggestionDismiss),
          ),
        ),
      ],
    );
  }
}
