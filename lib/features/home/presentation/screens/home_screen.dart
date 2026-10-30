import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:intl/intl.dart';
import 'package:rumbo/features/account/presentation/widgets/home_cards.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/domain/services/follow_up.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/email/presentation/providers/email/email_provider.dart';
import 'package:rumbo/features/email/presentation/widgets/email_updates_section.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/domain/services/upcoming_interviews.dart';
import 'package:rumbo/features/interviews/presentation/providers/interviews/interviews_provider.dart';
import 'package:rumbo/features/interviews/presentation/widgets/interview_widgets.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/empty_state.dart';
import 'package:rumbo/shared/presentation/widgets/pull_to_refresh.dart';

/// Resumen del día: lo que pide acción primero y cómo va la búsqueda.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final List<ApplicationWithJob>? applications = ref
        .watch(applicationsControllerProvider)
        .value;
    final List<SavedJob>? jobs = ref.watch(jobsControllerProvider).value;
    final DateTime now = ref.watch(clockProvider)();
    final List<Interview> scheduled =
        ref.watch(interviewsControllerProvider).value ?? <Interview>[];
    final String? name = ref
        .watch(profileControllerProvider)
        .value
        ?.profile
        .fullName
        .trim();

    final _Header header = _Header(
      now: now,
      name: name == null || name.isEmpty ? null : name.split(' ').first,
    );
    if (applications == null || jobs == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.tabHome)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (jobs.isEmpty) {
      return Scaffold(
        body: SafeArea(
          child: PullToRefresh(
            providers: <Refreshable<Future<Object?>>>[
              applicationsControllerProvider.future,
              jobsControllerProvider.future,
              interviewsControllerProvider.future,
              emailUpdatesControllerProvider.future,
              profileControllerProvider.future,
            ],
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: <Widget>[
                header,
                const UpdateBanner(),
                const FirstStepsCard(),
                const SizedBox(height: 48),
                EmptyState(
                  icon: Icons.wb_sunny_outlined,
                  title: l10n.homeEmptyTitle,
                  body: l10n.homeStart,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final List<SavedJob> suggestions =
        jobs.where((SavedJob s) => s.job.isSuggestion).toList()..sort(
          (SavedJob a, SavedJob b) =>
              (b.match?.score ?? 0).compareTo(a.match?.score ?? 0),
        );
    final List<ApplicationWithJob> active = applications
        .where((ApplicationWithJob i) => i.application.status.isActive)
        .toList();
    final List<ApplicationWithJob> due = applications
        .where(
          (ApplicationWithJob i) =>
              isFollowUpDue(application: i.application, now: now),
        )
        .toList();
    final int interviews = active
        .where(
          (ApplicationWithJob i) =>
              i.application.status == ApplicationStatus.interview ||
              i.application.status == ApplicationStatus.technicalTest,
        )
        .length;
    final List<(Interview, ApplicationWithJob)> upcoming = upcomingInterviews(
      interviews: scheduled,
      applications: applications,
      now: now,
    );
    // La entrevista de mañana (o de hoy) se prepara hoy.
    final List<(Interview, ApplicationWithJob)> soon = upcoming
        .where(
          ((Interview, ApplicationWithJob) e) =>
              e.$1.scheduledAt.difference(now) < const Duration(hours: 36),
        )
        .toList();

    final List<Widget> tasks = <Widget>[
      if (suggestions.isNotEmpty)
        _TodayItem(
          key: const Key('todaySuggestions'),
          leading: _CountTile(count: suggestions.length),
          title: l10n.homeSuggestions,
          subtitle: suggestions
              .take(2)
              .map(
                (SavedJob s) =>
                    <Object>[s.job.company, ?s.match?.score].join(' '),
              )
              .join(' · '),
          onTap: () => const JobsRoute().go(context),
        ),
      for (final ApplicationWithJob item in due.take(3))
        _TodayItem(
          leading: _IconTile(icon: Icons.schedule, signal: true),
          title: l10n.homeTaskFollowUp(
            item.job.company.isEmpty
                ? jobTitle(l10n, item.job)
                : item.job.company,
          ),
          subtitle: jobTitle(l10n, item.job),
          onTap: () =>
              ApplicationDetailRoute(id: item.application.id).go(context),
        ),
      for (final (Interview interview, ApplicationWithJob process) in soon.take(
        2,
      ))
        _TodayItem(
          leading: const _IconTile(icon: Icons.event_outlined),
          title: l10n.homeTaskInterview,
          subtitle:
              '${interviewWhen(context, interview.scheduledAt)} · '
              '${process.job.company}',
          onTap: () =>
              ApplicationDetailRoute(id: process.application.id).go(context),
        ),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: PullToRefresh(
          providers: <Refreshable<Future<Object?>>>[
            applicationsControllerProvider.future,
            jobsControllerProvider.future,
            interviewsControllerProvider.future,
            emailUpdatesControllerProvider.future,
            profileControllerProvider.future,
          ],
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            children: <Widget>[
              header,
              const UpdateBanner(),
              const FirstStepsCard(),
              const SizedBox(height: 20),
              _TodayCard(tasks: tasks),
              const SizedBox(height: 14),
              _Metrics(
                values: <(int, String)>[
                  (active.length, l10n.homeMetricActive),
                  (interviews, l10n.homeMetricInterviews),
                  (suggestions.length, l10n.homeMetricSuggested),
                ],
              ),
              const SizedBox(height: 24),
              const EmailUpdatesSection(),
              Text(l10n.homeUpcoming, style: AppTheme.sectionTitle(context)),
              const SizedBox(height: 10),
              if (upcoming.isEmpty)
                Text(
                  l10n.homeNoUpcoming,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: context.colors.muted),
                )
              else
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        for (final (
                              Interview interview,
                              ApplicationWithJob process,
                            )
                            in upcoming.take(5))
                          InterviewTile(
                            interview: interview,
                            title:
                                '${jobTitle(l10n, process.job)} · '
                                '${process.job.company}',
                            onTap: () => ApplicationDetailRoute(
                              id: process.application.id,
                            ).go(context),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fecha, saludo y acceso a las estadísticas.
class _Header extends StatelessWidget {
  const _Header({required this.now, required this.name});

  final DateTime now;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final RumboColors colors = context.colors;
    final String date = DateFormat.MMMMEEEEd(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(now);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(date.toUpperCase(), style: AppTheme.overline(context)),
              const SizedBox(height: 2),
              Semantics(
                header: true,
                child: Text(
                  name == null
                      ? l10n.homeGreetingNoName
                      : l10n.homeGreeting(name!),
                  style: AppTheme.screenTitle(context),
                ),
              ),
            ],
          ),
        ),
        IconButton.outlined(
          key: const Key('openStats'),
          tooltip: l10n.statsOpen,
          onPressed: () => const StatsRoute().push(context),
          style: IconButton.styleFrom(
            backgroundColor: colors.surface,
            side: BorderSide(color: colors.line),
            fixedSize: const Size(44, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
          ),
          icon: const Icon(Icons.insights_outlined),
        ),
      ],
    );
  }
}

/// Bloque oscuro «Para hoy»: tareas en orden de urgencia, o «Todo al día».
class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.tasks});

  final List<Widget> tasks;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final RumboColors colors = context.colors;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 12, 10),
      decoration: BoxDecoration(
        color: colors.hero,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Expanded(
                  child: Text(
                    tasks.isEmpty ? l10n.homeAllDoneTitle : l10n.homeToday,
                    style: AppTheme.sectionTitle(context)
                        .copyWith(color: colors.onHero, fontSize: 20),
                  ),
                ),
                if (tasks.isNotEmpty)
                  Text(
                    l10n.homeTaskCount(tasks.length),
                    style: AppTheme.numbers(textTheme.bodySmall).copyWith(
                      color: colors.heroMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          if (tasks.isEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 10),
              child: Text(
                l10n.homeAllDoneBody,
                style: textTheme.bodyMedium?.copyWith(color: colors.heroMuted),
              ),
            )
          else
            ...tasks,
        ],
      ),
    );
  }
}

class _TodayItem extends StatelessWidget {
  const _TodayItem({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final RumboColors colors = context.colors;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: <Widget>[
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      color: colors.onHero,
                      fontSize: 15,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.heroMuted,
                      ),
                    ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colors.heroMuted),
          ],
        ),
      ),
    );
  }
}

class _CountTile extends StatelessWidget {
  const _CountTile({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final RumboColors colors = context.colors;
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.heroTile,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: AppTheme.numbers(const TextStyle(fontSize: 16))
            .copyWith(color: colors.heroAccent),
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.icon, this.signal = false});

  final IconData icon;

  /// Ámbar para lo que se ha retrasado (seguimientos).
  final bool signal;

  @override
  Widget build(BuildContext context) {
    final RumboColors colors = context.colors;
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: signal ? colors.heroSignalTile : colors.heroTile,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 20,
        color: signal ? colors.heroSignal : colors.heroAccent,
      ),
    );
  }
}

/// Franja con tres cifras separadas por líneas finas.
class _Metrics extends StatelessWidget {
  const _Metrics({required this.values});

  final List<(int, String)> values;

  @override
  Widget build(BuildContext context) {
    final RumboColors colors = context.colors;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              for (final (int index, (int value, String label))
                  in values.indexed) ...<Widget>[
                if (index > 0) VerticalDivider(color: colors.line, width: 1),
                Expanded(
                  child: Semantics(
                    label: '$label: $value',
                    excludeSemantics: true,
                    child: Column(
                      children: <Widget>[
                        Text(
                          '$value',
                          style: AppTheme.numbers(textTheme.headlineSmall)
                              .copyWith(fontSize: 24, color: colors.text),
                        ),
                        Text(label, style: textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
