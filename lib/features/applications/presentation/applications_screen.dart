import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_router.dart';
import '../../../core/time/clock.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/company_mark.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../../../shared/widgets/root_app_bar.dart';
import '../../../shared/widgets/section_label.dart';
import '../../../shared/widgets/segmented_tabs.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../jobs/presentation/job_widgets.dart';
import '../domain/application.dart';
import '../domain/application_status.dart';
import '../domain/follow_up.dart';
import 'application_widgets.dart';
import 'applications_controller.dart';
import '../../../shared/widgets/pull_to_refresh.dart';

class ApplicationsScreen extends ConsumerStatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  ConsumerState<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends ConsumerState<ApplicationsScreen> {
  bool _showClosed = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(applicationsControllerProvider);
    final now = ref.watch(clockProvider)();
    return Scaffold(
      appBar: rootAppBar(
        context,
        l10n.applicationsTitle,
        actions: [
          BarButton(
            key: const Key('compareOffers'),
            icon: Icons.compare_arrows,
            tooltip: l10n.offerCompare,
            onPressed: () => const CompareOffersRoute().push(context),
          ),
        ],
      ),
      // Con datos (también mientras se actualizan al deslizar) se muestran.
      body: switch (state) {
        AsyncValue(:final value?) when value.isEmpty => PullToRefresh(
          providers: [applicationsControllerProvider.future],
          child: RefreshableFill(
            child: EmptyState(
              icon: Icons.view_kanban_outlined,
              title: l10n.applicationsEmptyTitle,
              body: l10n.applicationsEmptyBody,
            ),
          ),
        ),
        AsyncValue(:final value?) => _Board(
          items: value,
          showClosed: _showClosed,
          now: now,
          onToggle: (closed) => setState(() => _showClosed = closed),
        ),
        AsyncError() => Center(
          child: OutlinedButton(
            onPressed: () => ref.invalidate(applicationsControllerProvider),
            child: Text(l10n.retry),
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({
    required this.items,
    required this.showClosed,
    required this.now,
    required this.onToggle,
  });

  final List<ApplicationWithJob> items;
  final bool showClosed;
  final DateTime now;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final visible = items
        .where((item) => item.application.status.isClosed == showClosed)
        .toList();
    final closedCount = items
        .where((i) => i.application.status.isClosed)
        .length;
    // Lo que pide acción va primero y no se repite en su grupo.
    final due = showClosed
        ? <ApplicationWithJob>[]
        : visible.where((i) => isFollowUpDue(i.application, now)).toList();
    final rest = visible.where((i) => !due.contains(i)).toList();
    return PullToRefresh(
      providers: [applicationsControllerProvider.future],
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          _Funnel(items: items),
          const SizedBox(height: 18),
          SegmentedTabs<bool>(
            segments: [
              (false, '${l10n.boardActive} (${items.length - closedCount})'),
              (true, '${l10n.boardClosed} ($closedCount)'),
            ],
            selected: showClosed,
            onChanged: onToggle,
          ),
          if (due.isNotEmpty) ...[
            const SizedBox(height: 22),
            SectionLabel(
              '${l10n.applicationsNeedsAction} · ${due.length}',
              color: context.colors.onSignalSoft,
            ),
            for (final item in due)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _ApplicationCard(item: item, now: now, due: true),
              ),
          ],
          for (final status in boardOrder)
            if (rest.where((i) => i.application.status == status).toList()
                case final group when group.isNotEmpty) ...[
              const SizedBox(height: 22),
              SectionLabel('${statusLabel(l10n, status)} · ${group.length}'),
              for (final item in group)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ApplicationCard(item: item, now: now),
                ),
            ],
        ],
      ),
    );
  }
}

/// Cuántos procesos hay en cada etapa, con una barra proporcional.
class _Funnel extends StatelessWidget {
  const _Funnel({required this.items});

  final List<ApplicationWithJob> items;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    int count(Set<ApplicationStatus> statuses) =>
        items.where((i) => statuses.contains(i.application.status)).length;
    final stages = [
      (
        statusLabel(l10n, ApplicationStatus.preparing),
        count({ApplicationStatus.saved, ApplicationStatus.preparing}),
        colors.muted,
      ),
      (
        statusLabel(l10n, ApplicationStatus.applied),
        count({ApplicationStatus.applied, ApplicationStatus.inReview}),
        colors.info,
      ),
      (
        statusLabel(l10n, ApplicationStatus.interview),
        count({ApplicationStatus.interview, ApplicationStatus.technicalTest}),
        colors.signal,
      ),
      (
        statusLabel(l10n, ApplicationStatus.offer),
        count({ApplicationStatus.offer, ApplicationStatus.accepted}),
        colors.accent,
      ),
    ];
    return Semantics(
      container: true,
      label: stages.map((s) => '${s.$1}: ${s.$2}').join(', '),
      excludeSemantics: true,
      child: Column(
        children: [
          Row(
            children: [
              for (final (index, (_, value, color)) in stages.indexed) ...[
                if (index > 0) const SizedBox(width: 4),
                Expanded(
                  // Las etapas vacías conservan un trozo para no desaparecer.
                  flex: value == 0 ? 1 : value * 3,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: value == 0 ? colors.surfaceMuted : color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final (label, value, _) in stages)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$value',
                        style: AppTheme.numbers(textTheme.titleMedium).copyWith(
                          color: value == 0 ? colors.muted : colors.text,
                        ),
                      ),
                      Text(
                        label,
                        style: textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({
    required this.item,
    required this.now,
    this.due = false,
  });

  final ApplicationWithJob item;
  final DateTime now;

  /// Toca seguimiento: borde ámbar y aviso en lugar de la línea de fechas.
  final bool due;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.colors;
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: due
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius),
              side: BorderSide(color: colors.signal.withValues(alpha: 0.5)),
            )
          : null,
      child: InkWell(
        onTap: () =>
            ApplicationDetailRoute(id: item.application.id).push(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CompanyMark(company: item.job.company),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobTitle(l10n, item.job),
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          jobSubtitle(context, item.job),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  StatusPill(status: item.application.status),
                ],
              ),
              const SizedBox(height: 10),
              if (due)
                NoticeBanner(text: l10n.followUpDue)
              else
                Padding(
                  padding: const EdgeInsets.only(left: 52),
                  child: FollowUpLine(application: item.application, now: now),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
