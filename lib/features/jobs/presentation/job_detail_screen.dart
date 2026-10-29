import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../applications/data/resume_tailor.dart';
import '../../applications/presentation/application_widgets.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../applications/presentation/prepare_application_screen.dart';
import '../../practice/data/interview_coach.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../data/job_analyzer.dart';
import '../domain/job.dart';

import '../../../l10n/app_localizations.dart';
import '../../profile/presentation/form_helpers.dart';
import '../../email/data/email_drafter.dart';
import 'job_contact.dart';
import 'job_widgets.dart';
import 'jobs_controller.dart';
import '../../../shared/widgets/pull_to_refresh.dart';

class JobDetailScreen extends ConsumerWidget {
  const JobDetailScreen({super.key, required this.jobId});

  final String jobId;

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    String title,
  ) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    if (!await confirmDelete(context, title)) return;
    try {
      await ref.read(jobsControllerProvider.notifier).delete(jobId);
      messenger.showSnackBar(SnackBar(content: Text(l10n.jobDeleted)));
      navigator.pop();
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final saved = ref
        .watch(jobsControllerProvider)
        .value
        ?.firstWhereOrNull((item) => item.job.id == jobId);
    if (saved == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.jobNotFound)),
      );
    }
    final job = saved.job;
    final match = saved.match;
    final url = job.url;
    final canPrepare = ref.watch(resumeTailorProvider) != null;
    final canComplete = ref.watch(jobAnalyzerProvider) != null;
    final canApplyByEmail = ref.watch(emailDrafterProvider) != null;
    final canPractice =
        ref.watch(interviewCoachProvider) != null && job.isSaved;
    return Scaffold(
      appBar: AppBar(
        actions: [
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
        providers: [
          jobsControllerProvider.future,
          applicationsControllerProvider.future,
        ],
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: [
            JobHeader(job: job),
            if (sourceName(job.source) case final source?) ...[
              const SizedBox(height: 6),
              Text(l10n.foundOn(source), style: theme.textTheme.bodySmall),
            ],
            if (canComplete && job.needsDescription) ...[
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
            if (match != null) ...[
              const SizedBox(height: 16),
              JobMatchSection(match: match),
            ],
            if (canApplyByEmail && job.appliesByEmail) ...[
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
            if (canPractice || url != null) ...[
              const SizedBox(height: 16),
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    if (canPractice) ...[
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
                    if (url != null) ...[
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
            if (job.requirements.isNotEmpty) ...[
              const SizedBox(height: 28),
              JobRequirements(requirements: job.requirements),
            ],
            if (job.description.isNotEmpty) ...[
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
    final l10n = AppLocalizations.of(context);
    ref.watch(applicationsControllerProvider);
    final controller = ref.read(applicationsControllerProvider.notifier);
    final application = controller.forJob(jobId);
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
          children: [
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
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
    final l10n = AppLocalizations.of(context);
    final jobs = ref.read(jobsControllerProvider.notifier);
    Future<void> run(Future<void> Function() action, String done) async {
      final messenger = ScaffoldMessenger.of(context);
      try {
        await action();
        messenger.showSnackBar(SnackBar(content: Text(done)));
      } catch (_) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
      }
    }

    return Row(
      children: [
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
              final navigator = Navigator.of(context);
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
