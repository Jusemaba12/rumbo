import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:intl/intl.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/domain/services/follow_up.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/applications/presentation/widgets/application_widgets.dart';
import 'package:rumbo/features/email/application/use_cases/draft_email_use_case.dart';
import 'package:rumbo/features/email/domain/entities/email_draft.dart';
import 'package:rumbo/features/email/presentation/screens/email_draft_screen.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/presentation/providers/interviews/interviews_provider.dart';
import 'package:rumbo/features/interviews/presentation/widgets/interview_widgets.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/features/offers/application/use_cases/draft_negotiation_use_case.dart';
import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/features/offers/presentation/providers/offers/offers_provider.dart';
import 'package:rumbo/features/offers/presentation/widgets/offer_widgets.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/company_mark.dart';
import 'package:rumbo/shared/presentation/widgets/group_card.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';
import 'package:rumbo/shared/presentation/widgets/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationDetailScreen extends ConsumerWidget {
  const ApplicationDetailScreen({super.key, required this.applicationId});

  final String applicationId;

  Future<void> _run(
    BuildContext context,
    Future<Result<Object?>> Function() action, {
    String? done,
  }) async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: await action(),
      success: done,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final ApplicationWithJob? item = ref
        .watch(applicationsControllerProvider)
        .value
        ?.firstWhereOrNull(
          (ApplicationWithJob i) => i.application.id == applicationId,
        );
    if (item == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.jobNotFound)),
      );
    }
    final ApplicationsController controller = ref.read(
      applicationsControllerProvider.notifier,
    );
    final Application application = item.application;
    final Job job = item.job;
    final DateTime now = ref.watch(clockProvider)();
    final String? url = job.url;

    Widget section(String title, List<Widget> children) => Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
    const Size inline = Size(0, 44);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            tooltip: l10n.delete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final NavigatorState navigator = Navigator.of(context);
              final ScaffoldMessengerState messenger = ScaffoldMessenger.of(
                context,
              );
              if (!await confirmDelete(context, jobTitle(l10n, job))) return;
              if (showResultSnackBar(
                messenger: messenger,
                l10n: l10n,
                result: await controller.delete(application.id),
              )) {
                navigator.pop();
              }
            },
          ),
        ],
      ),
      body: PullToRefresh(
        providers: <Refreshable<Future<Object?>>>[
          applicationsControllerProvider.future,
          interviewsControllerProvider.future,
          offersControllerProvider.future,
          applicationEventsProvider(applicationId).future,
        ],
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: <Widget>[
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
              children: <Widget>[
                StatusPill(status: application.status),
                FollowUpLine(application: application, now: now),
              ],
            ),
            if (suggestsNoResponse(
              application: application,
              now: now,
            )) ...<Widget>[
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
              children: <Widget>[
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
              section(l10n.nextStepTitle, <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final ApplicationStatus next in boardOrder.where(
                      application.status.nextStatuses.contains,
                    ))
                      FilledButton.tonal(
                        key: Key('status-${next.name}'),
                        style: FilledButton.styleFrom(minimumSize: inline),
                        onPressed: () => _run(
                          context,
                          () => controller.changeStatus(
                            application: application,
                            to: next,
                          ),
                        ),
                        child: Text(statusAction(l10n, next)),
                      ),
                  ],
                ),
              ]),
            if (application.status.isActive)
              section(l10n.followUpTitle, <Widget>[
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                          children: <Widget>[
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
                                final DateTime? picked = await showDatePicker(
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
                                    application: application,
                                    date: picked,
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
              section(l10n.offerTitle, <Widget>[
                _OfferSummary(applicationId: application.id),
                Wrap(
                  spacing: 8,
                  children: <Widget>[
                    TextButton.icon(
                      key: const Key('editOffer'),
                      onPressed: () =>
                          OfferFormRoute(id: application.id).push(context),
                      icon: const Icon(Icons.edit_outlined),
                      label: Text(l10n.offerEdit),
                    ),
                    if (application.status == ApplicationStatus.offer &&
                        ref.watch(draftNegotiationUseCaseProvider).isAvailable)
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
            if (ref.watch(draftEmailUseCaseProvider).isAvailable &&
                emailKindsFor(application.status).isNotEmpty)
              section(l10n.emailDraftsTitle, <Widget>[
                Text(l10n.emailDraftsHint, style: theme.textTheme.bodySmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final EmailDraftKind kind in emailKindsFor(
                      application.status,
                    ))
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
            section(l10n.interviewsTitle, <Widget>[
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
            section(l10n.notesLabel, <Widget>[
              _NotesEditor(
                key: ValueKey<String>(application.id),
                initial: application.notes,
                onSave: (String notes) => _run(
                  context,
                  () => controller.saveNotes(
                    application: application,
                    notes: notes,
                  ),
                  done: l10n.notesSaved,
                ),
              ),
            ]),
            section(l10n.historyTitle, <Widget>[
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
  late final TextEditingController _controller = TextEditingController(
    text: widget.initial,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
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
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final List<ApplicationEvent>? events = ref
        .watch(applicationEventsProvider(applicationId))
        .value;
    if (events == null) return const LinearProgressIndicator();
    final DateFormat format = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).add_Hm();
    return Column(
      children: <Widget>[
        for (final ApplicationEvent event in events.reversed)
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
    final List<Interview> interviews =
        (ref.watch(interviewsControllerProvider).value ?? <Interview>[])
            .where((Interview i) => i.applicationId == applicationId)
            .toList();
    if (interviews.isEmpty) {
      final ThemeData theme = Theme.of(context);
      return Text(
        context.l10n.interviewsEmpty,
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
          children: <Widget>[
            for (final Interview interview in interviews)
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
    final AppLocalizations l10n = context.l10n;
    final JobOffer? offer = ref
        .watch(offersControllerProvider)
        .value
        ?.firstWhereOrNull((JobOffer o) => o.applicationId == applicationId);
    final String? salary = offer == null
        ? null
        : offerSalaryText(context, offer);
    if (offer == null || salary == null) return Text(l10n.offerNoDetails);
    final String period = offer.period == SalaryPeriod.year
        ? l10n.periodYear
        : l10n.periodMonth;
    return Text(
      <String>[
        '$salary · $period',
        if (offer.benefits.isNotEmpty) offer.benefits,
      ].join('\n'),
    );
  }
}

/// Correos que tiene sentido escribir según el estado del proceso.
List<EmailDraftKind> emailKindsFor(ApplicationStatus status) =>
    <EmailDraftKind>[
      if (const <ApplicationStatus>{
        ApplicationStatus.applied,
        ApplicationStatus.inReview,
        ApplicationStatus.technicalTest,
        ApplicationStatus.interview,
        ApplicationStatus.noResponse,
      }.contains(status))
        EmailDraftKind.followUp,
      if (const <ApplicationStatus>{
        ApplicationStatus.technicalTest,
        ApplicationStatus.interview,
        ApplicationStatus.offer,
      }.contains(status))
        EmailDraftKind.thankYou,
      if (status == ApplicationStatus.rejected) EmailDraftKind.rejectionReply,
    ];
