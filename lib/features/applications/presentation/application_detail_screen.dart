import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/company_mark.dart';
import '../../../shared/widgets/group_card.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../../../shared/widgets/pull_to_refresh.dart';
import '../../email/data/email_drafter.dart';
import '../../email/presentation/email_draft_screen.dart';
import '../../interviews/presentation/interview_widgets.dart';
import '../../interviews/presentation/interviews_controller.dart';
import '../../jobs/presentation/job_widgets.dart';
import '../../offers/data/negotiation.dart';
import '../../offers/domain/job_offer.dart';
import '../../offers/presentation/offer_widgets.dart';
import '../../offers/presentation/offers_controller.dart';
import '../../profile/presentation/form_helpers.dart';
import '../domain/application_status.dart';
import '../domain/follow_up.dart';
import 'application_widgets.dart';
import 'applications_controller.dart';

class ApplicationDetailScreen extends ConsumerWidget {
  const ApplicationDetailScreen({super.key, required this.applicationId});

  final String applicationId;

  Future<void> _run(
    BuildContext context,
    Future<void> Function() action, {
    String? done,
  }) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
      if (done != null) {
        messenger.showSnackBar(SnackBar(content: Text(done)));
      }
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final item = ref
        .watch(applicationsControllerProvider)
        .value
        ?.firstWhereOrNull((i) => i.application.id == applicationId);
    if (item == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.jobNotFound)),
      );
    }
    final controller = ref.read(applicationsControllerProvider.notifier);
    final application = item.application;
    final job = item.job;
    final now = ref.watch(clockProvider)();
    final url = job.url;

    Widget section(String title, List<Widget> children) => Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(title, style: AppTheme.sectionTitle(context)),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
    // Botones en fila: el tema les da ancho completo.
    const inline = Size(0, 44);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: l10n.delete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final navigator = Navigator.of(context);
              if (!await confirmDelete(context, jobTitle(l10n, job))) return;
              await controller.delete(application.id);
              navigator.pop();
            },
          ),
        ],
      ),
      body: PullToRefresh(
        providers: [
          applicationsControllerProvider.future,
          interviewsControllerProvider.future,
          offersControllerProvider.future,
          applicationEventsProvider(applicationId).future,
        ],
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: [
            CompanyMark(company: job.company, size: 48),
            const SizedBox(height: 12),
            Text(jobTitle(l10n, job), style: theme.textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              jobSubtitle(context, job),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                StatusPill(status: application.status),
                FollowUpLine(application: application, now: now),
              ],
            ),
            if (suggestsNoResponse(application, now)) ...[
              const SizedBox(height: 14),
              NoticeBanner(
                icon: Icons.hourglass_bottom,
                tone: Tone.neutral,
                text: l10n.noResponseHint(
                  now.difference(application.appliedAt!).inDays,
                ),
              ),
            ],
            const SizedBox(height: 16),
            GroupCard(
              indent: 52,
              children: [
                ListTile(
                  leading: const Icon(Icons.work_outline),
                  title: Text(l10n.viewJob),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => JobDetailRoute(id: job.id).go(context),
                ),
                if (url != null)
                  ListTile(
                    leading: const Icon(Icons.open_in_new),
                    title: Text(l10n.jobOpenLink),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => launchUrl(
                      Uri.parse(url),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
              ],
            ),
            if (application.status.nextStatuses.isNotEmpty)
              section(l10n.nextStepTitle, [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final next in boardOrder.where(
                      application.status.nextStatuses.contains,
                    ))
                      FilledButton.tonal(
                        key: Key('status-${next.name}'),
                        style: FilledButton.styleFrom(minimumSize: inline),
                        onPressed: () => _run(
                          context,
                          () => controller.changeStatus(application, next),
                        ),
                        child: Text(statusAction(l10n, next)),
                      ),
                  ],
                ),
              ]),
            if (application.status.isActive)
              section(l10n.followUpTitle, [
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          application.nextFollowUpAt == null
                              ? l10n.followUpNone
                              : l10n.followUpOn(
                                  DateFormat.yMMMd(
                                    Localizations.localeOf(context)
                                        .toLanguageTag(),
                                  ).format(application.nextFollowUpAt!),
                                ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            OutlinedButton(
                              key: const Key('followUpDone'),
                              style: OutlinedButton.styleFrom(
                                minimumSize: inline,
                              ),
                              onPressed: () => _run(
                                context,
                                () => controller.followUpDone(application),
                              ),
                              child: Text(l10n.followUpDoneButton),
                            ),
                            TextButton(
                              onPressed: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      application.nextFollowUpAt ??
                                      now.add(followUpAfter),
                                  firstDate: now,
                                  lastDate: now.add(const Duration(days: 365)),
                                );
                                if (picked == null || !context.mounted) return;
                                await _run(
                                  context,
                                  () => controller.setFollowUp(
                                    application,
                                    picked,
                                  ),
                                );
                              },
                              child: Text(l10n.followUpChange),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            if (offerStatuses.contains(application.status))
              section(l10n.offerTitle, [
                _OfferSummary(applicationId: application.id),
                Wrap(
                  spacing: 8,
                  children: [
                    TextButton.icon(
                      key: const Key('editOffer'),
                      onPressed: () =>
                          OfferFormRoute(id: application.id).push(context),
                      icon: const Icon(Icons.edit_outlined),
                      label: Text(l10n.offerEdit),
                    ),
                    if (application.status == ApplicationStatus.offer &&
                        ref.watch(negotiatorProvider) != null)
                      TextButton.icon(
                        key: const Key('openNegotiation'),
                        onPressed: () =>
                            NegotiationRoute(id: application.id).push(context),
                        icon: const Icon(Icons.handshake_outlined),
                        label: Text(l10n.negotiateOpen),
                      ),
                    TextButton.icon(
                      onPressed: () => const CompareOffersRoute().push(context),
                      icon: const Icon(Icons.compare_arrows),
                      label: Text(l10n.offerCompare),
                    ),
                  ],
                ),
              ]),
            if (ref.watch(emailDrafterProvider) != null &&
                emailKindsFor(application.status).isNotEmpty)
              section(l10n.emailDraftsTitle, [
                Text(l10n.emailDraftsHint, style: theme.textTheme.bodySmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final kind in emailKindsFor(application.status))
                      OutlinedButton.icon(
                        key: Key('email-${kind.name}'),
                        style: OutlinedButton.styleFrom(minimumSize: inline),
                        onPressed: () => EmailDraftRoute(
                          id: application.id,
                          kind: kind,
                        ).push(context),
                        icon: const Icon(Icons.edit_note, size: 20),
                        label: Text(emailKindLabel(l10n, kind)),
                      ),
                  ],
                ),
              ]),
            section(l10n.interviewsTitle, [
              _Interviews(applicationId: application.id),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  key: const Key('addInterview'),
                  onPressed: () =>
                      InterviewNewRoute(id: application.id).push(context),
                  icon: const Icon(Icons.event_available_outlined),
                  label: Text(l10n.interviewAdd),
                ),
              ),
            ]),
            section(l10n.notesLabel, [
              _NotesEditor(
                key: ValueKey(application.id),
                initial: application.notes,
                onSave: (notes) => _run(
                  context,
                  () => controller.saveNotes(application, notes),
                  done: l10n.notesSaved,
                ),
              ),
            ]),
            section(l10n.historyTitle, [
              _History(applicationId: application.id),
            ]),
          ],
        ),
      ),
    );
  }
}

class _NotesEditor extends StatefulWidget {
  const _NotesEditor({super.key, required this.initial, required this.onSave});

  final String initial;
  final ValueChanged<String> onSave;

  @override
  State<_NotesEditor> createState() => _NotesEditorState();
}

class _NotesEditorState extends State<_NotesEditor> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          key: const Key('notes'),
          controller: _controller,
          minLines: 3,
          maxLines: 10,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(hintText: l10n.notesHint),
        ),
        TextButton(
          onPressed: () => widget.onSave(_controller.text.trim()),
          child: Text(l10n.save),
        ),
      ],
    );
  }
}

class _History extends ConsumerWidget {
  const _History({required this.applicationId});

  final String applicationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final events = ref.watch(applicationEventsProvider(applicationId)).value;
    if (events == null) return const LinearProgressIndicator();
    final format = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).add_Hm();
    return Column(
      children: [
        for (final event in events.reversed)
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Icon(
              Icons.circle,
              size: 10,
              color: context.colors.soft(statusTone(event.toStatus)).$2,
            ),
            title: Text(
              event.fromStatus == null
                  ? l10n.historyCreated(statusLabel(l10n, event.toStatus))
                  : '${statusLabel(l10n, event.fromStatus!)} → '
                        '${statusLabel(l10n, event.toStatus)}',
            ),
            subtitle: Text(
              format.format(event.createdAt),
              style: theme.textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}

class _Interviews extends ConsumerWidget {
  const _Interviews({required this.applicationId});

  final String applicationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interviews = (ref.watch(interviewsControllerProvider).value ?? [])
        .where((i) => i.applicationId == applicationId)
        .toList();
    if (interviews.isEmpty) {
      final theme = Theme.of(context);
      return Text(
        AppLocalizations.of(context).interviewsEmpty,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            for (final interview in interviews)
              InterviewTile(
                interview: interview,
                onTap: () => InterviewEditRoute(
                  id: applicationId,
                  interviewId: interview.id,
                ).push(context),
              ),
          ],
        ),
      ),
    );
  }
}

class _OfferSummary extends ConsumerWidget {
  const _OfferSummary({required this.applicationId});

  final String applicationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final offer = ref
        .watch(offersControllerProvider)
        .value
        ?.firstWhereOrNull((o) => o.applicationId == applicationId);
    final salary = offer == null ? null : offerSalaryText(context, offer);
    if (offer == null || salary == null) return Text(l10n.offerNoDetails);
    return Text(
      [
        '$salary · ${offer.period == SalaryPeriod.year ? l10n.periodYear : l10n.periodMonth}',
        if (offer.benefits.isNotEmpty) offer.benefits,
      ].join('\n'),
    );
  }
}

/// Correos que tiene sentido escribir según el estado del proceso.
List<EmailDraftKind> emailKindsFor(ApplicationStatus status) => [
  if (const {
    ApplicationStatus.applied,
    ApplicationStatus.inReview,
    ApplicationStatus.technicalTest,
    ApplicationStatus.interview,
    ApplicationStatus.noResponse,
  }.contains(status))
    EmailDraftKind.followUp,
  if (const {
    ApplicationStatus.technicalTest,
    ApplicationStatus.interview,
    ApplicationStatus.offer,
  }.contains(status))
    EmailDraftKind.thankYou,
  if (status == ApplicationStatus.rejected) EmailDraftKind.rejectionReply,
];
