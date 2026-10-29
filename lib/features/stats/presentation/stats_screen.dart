import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/pull_to_refresh.dart';
import '../../applications/data/applications_repository.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../jobs/domain/job.dart';
import '../../jobs/presentation/jobs_controller.dart';
import '../domain/search_stats.dart';

part 'stats_screen.g.dart';

@Riverpod(keepAlive: true)
Future<SearchStats> searchStats(Ref ref) async {
  final applications = await ref.watch(applicationsControllerProvider.future);
  final jobs = await ref.watch(jobsControllerProvider.future);
  final events = await ref.watch(applicationsRepositoryProvider).allEvents();
  return computeStats(applications: applications, events: events, jobs: jobs);
}

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(searchStatsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.statsTitle)),
      // Con datos (también mientras se actualizan al deslizar) se muestran.
      body: switch (state) {
        AsyncValue(:final value?) => _StatsBody(stats: value),
        AsyncError() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.statsLoadError),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => ref.invalidate(searchStatsProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _StatsBody extends StatelessWidget {
  const _StatsBody({required this.stats});

  final SearchStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final funnel = stats.funnel;
    final rate = funnel.responseRate;
    final days = stats.averageResponseDays;
    final locale = Localizations.localeOf(context).toLanguageTag();

    Widget heading(String text) => Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 12),
      child: Text(text, style: AppTheme.sectionTitle(context)),
    );

    return PullToRefresh(
      providers: [
        applicationsControllerProvider.future,
        jobsControllerProvider.future,
        searchStatsProvider.future,
      ],
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: [
          heading(l10n.statsFunnel),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Column(
                children: [
                  for (final (label, value) in [
                    (l10n.statsFunnelSaved, funnel.saved),
                    (l10n.statsFunnelApplied, funnel.applied),
                    (l10n.statsFunnelResponded, funnel.responded),
                    (l10n.statsFunnelInterviews, funnel.interviews),
                    (l10n.statsFunnelOffers, funnel.offers),
                  ])
                    _Bar(label: label, value: value, max: funnel.saved),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (funnel.applied == 0)
            Text(l10n.statsNoApplications, style: muted)
          else ...[
            if (rate != null) Text(l10n.statsResponseRate(rate)),
            if (days != null)
              Text(
                l10n.statsResponseTime(
                  NumberFormat('0.#', locale).format(days),
                ),
              ),
          ],
          if (stats.bySource.isNotEmpty) ...[
            heading(l10n.statsBySource),
            for (final source in stats.bySource)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  source.source == 'manual'
                      ? l10n.statsSourceManual
                      : sourceName(source.source) ?? source.source,
                ),
                trailing: Text(
                  l10n.statsSourceRow(source.applied, source.responded),
                ),
              ),
          ],
          heading(l10n.statsGaps),
          if (stats.gaps.isEmpty)
            Text(l10n.statsGapsEmpty, style: muted)
          else ...[
            Text(l10n.statsGapsHint(stats.analyzedJobs), style: muted),
            const SizedBox(height: 12),
            for (final gap in stats.gaps)
              _Bar(
                label: gap.label,
                value: gap.count,
                max: stats.analyzedJobs,
                trailing: l10n.statsGapRow(gap.count),
                color: theme.colorScheme.tertiary,
              ),
          ],
        ],
      ),
    );
  }
}

/// Fila con etiqueta, valor y barra proporcional.
class _Bar extends StatelessWidget {
  const _Bar({
    required this.label,
    required this.value,
    required this.max,
    this.trailing,
    this.color,
  });

  final String label;
  final int value;
  final int max;
  final String? trailing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label)),
              Text(
                trailing ?? '$value',
                style: trailing == null
                    ? AppTheme.numbers(theme.textTheme.bodyMedium)
                    : theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: max == 0 ? 0 : value / max,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
            color: color,
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
          ),
        ],
      ),
    );
  }
}
