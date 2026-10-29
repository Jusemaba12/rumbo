import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/pull_to_refresh.dart';
import '../../account/presentation/home_cards.dart';
import '../../applications/domain/application_status.dart';
import '../../applications/domain/follow_up.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../email/presentation/email_controller.dart';
import '../../email/presentation/email_updates_section.dart';
import '../../interviews/presentation/interview_widgets.dart';
import '../../interviews/presentation/interviews_controller.dart';
import '../../jobs/presentation/job_widgets.dart';
import '../../jobs/presentation/jobs_controller.dart';
import '../../profile/presentation/profile_controller.dart';

/// Resumen del día: lo que pide acción primero y cómo va la búsqueda.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final applications = ref.watch(applicationsControllerProvider).value;
    final jobs = ref.watch(jobsControllerProvider).value;
    final now = ref.watch(clockProvider)();
    final scheduled = ref.watch(interviewsControllerProvider).value ?? [];
    final name = ref
        .watch(profileControllerProvider)
        .value
        ?.profile
        .fullName
        .trim();

    final header = _Header(
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
            providers: [
              applicationsControllerProvider.future,
              jobsControllerProvider.future,
              interviewsControllerProvider.future,
              emailUpdatesControllerProvider.future,
              profileControllerProvider.future,
            ],
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
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

    final suggestions = jobs.where((s) => s.job.isSuggestion).toList()
      ..sort((a, b) => (b.match?.score ?? 0).compareTo(a.match?.score ?? 0));
    final active = applications
        .where((i) => i.application.status.isActive)
        .toList();
    final due = applications
        .where((i) => isFollowUpDue(i.application, now))
        .toList();
    final interviews = active
        .where(
          (i) =>
              i.application.status == ApplicationStatus.interview ||
              i.application.status == ApplicationStatus.technicalTest,
        )
        .length;
    final upcoming = upcomingInterviews(scheduled, applications, now);
    // La entrevista de mañana (o de hoy) se prepara hoy.
    final soon = upcoming
        .where(
          (e) => e.$1.scheduledAt.difference(now) < const Duration(hours: 36),
        )
        .toList();

    final tasks = <Widget>[
      if (suggestions.isNotEmpty)
        _TodayItem(
          key: const Key('todaySuggestions'),
          leading: _CountTile(count: suggestions.length),
          title: l10n.homeSuggestions,
          subtitle: suggestions
              .take(2)
              .map((s) => [s.job.company, ?s.match?.score].join(' '))
              .join(' · '),
          onTap: () => const JobsRoute().go(context),
        ),
      for (final item in due.take(3))
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
      for (final (interview, process) in soon.take(2))
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
          providers: [
            applicationsControllerProvider.future,
            jobsControllerProvider.future,
            interviewsControllerProvider.future,
            emailUpdatesControllerProvider.future,
            profileControllerProvider.future,
          ],
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            children: [
              header,
              const UpdateBanner(),
              const FirstStepsCard(),
              const SizedBox(height: 20),
              _TodayCard(tasks: tasks),
              const SizedBox(height: 14),
              _Metrics(
                values: [
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
                      children: [
                        for (final (interview, process) in upcoming.take(5))
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
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final date = DateFormat.MMMMEEEEd(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(now);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 12, 10),
      decoration: BoxDecoration(
        color: colors.hero,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
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
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
    final colors = context.colors;
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
    final colors = context.colors;
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
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: IntrinsicHeight(
          child: Row(
            children: [
              for (final (index, (value, label)) in values.indexed) ...[
                if (index > 0) VerticalDivider(color: colors.line, width: 1),
                Expanded(
                  child: Semantics(
                    label: '$label: $value',
                    excludeSemantics: true,
                    child: Column(
                      children: [
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
