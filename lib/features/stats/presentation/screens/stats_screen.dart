import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:intl/intl.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/stats/domain/services/search_stats.dart';
import 'package:rumbo/features/stats/presentation/providers/search_stats/search_stats_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/widgets/pull_to_refresh.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final AsyncValue<SearchStats> state = ref.watch(searchStatsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.statsTitle)),
      // Con datos (también mientras se actualizan al deslizar) se muestran.
      body: switch (state) {
        AsyncValue<SearchStats>(:final SearchStats value?) => _StatsBody(
          stats: value,
        ),
        AsyncError<SearchStats>() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final TextStyle? muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final Funnel funnel = stats.funnel;
    final int? rate = funnel.responseRate;
    final double? days = stats.averageResponseDays;
    final String locale = Localizations.localeOf(context).toLanguageTag();

    Widget heading(String text) => Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 12),
      child: Text(text, style: AppTheme.sectionTitle(context)),
    );

    return PullToRefresh(
      providers: <Refreshable<Future<Object?>>>[
        applicationsControllerProvider.future,
        jobsControllerProvider.future,
        searchStatsProvider.future,
      ],
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: <Widget>[
          heading(l10n.statsFunnel),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Column(
                children: <Widget>[
                  for (final (String label, int value) in <(String, int)>[
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
          else ...<Widget>[
            if (rate != null) Text(l10n.statsResponseRate(rate)),
            if (days != null)
              Text(
                l10n.statsResponseTime(
                  NumberFormat('0.#', locale).format(days),
                ),
              ),
          ],
          if (stats.bySource.isNotEmpty) ...<Widget>[
            heading(l10n.statsBySource),
            for (final SourceStats source in stats.bySource)
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
          else ...<Widget>[
            Text(l10n.statsGapsHint(stats.analyzedJobs), style: muted),
            const SizedBox(height: 12),
            for (final SkillGap gap in stats.gaps)
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
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
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
