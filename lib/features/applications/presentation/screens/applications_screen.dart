import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/domain/services/follow_up.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/applications/presentation/widgets/application_widgets.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/company_mark.dart';
import 'package:rumbo/shared/presentation/widgets/empty_state.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';
import 'package:rumbo/shared/presentation/widgets/pull_to_refresh.dart';
import 'package:rumbo/shared/presentation/widgets/root_app_bar.dart';
import 'package:rumbo/shared/presentation/widgets/section_label.dart';
import 'package:rumbo/shared/presentation/widgets/segmented_tabs.dart';

class ApplicationsScreen extends ConsumerStatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  ConsumerState<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends ConsumerState<ApplicationsScreen> {
  bool _showClosed = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final AsyncValue<List<ApplicationWithJob>> state = ref.watch(
      applicationsControllerProvider,
    );
    final DateTime now = ref.watch(clockProvider)();
    return Scaffold(
      appBar: rootAppBar(
        context,
        l10n.applicationsTitle,
        actions: <Widget>[
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
        AsyncValue<List<ApplicationWithJob>>(
          :final List<ApplicationWithJob> value?,
        )
            when value.isEmpty =>
          PullToRefresh(
            providers: <Refreshable<Future<Object?>>>[
              applicationsControllerProvider.future,
            ],
            child: RefreshableFill(
              child: EmptyState(
                icon: Icons.view_kanban_outlined,
                title: l10n.applicationsEmptyTitle,
                body: l10n.applicationsEmptyBody,
              ),
            ),
          ),
        AsyncValue<List<ApplicationWithJob>>(
          :final List<ApplicationWithJob> value?,
        ) =>
          _Board(
            items: value,
            showClosed: _showClosed,
            now: now,
            onToggle: (bool closed) => setState(() => _showClosed = closed),
          ),
        AsyncError<List<ApplicationWithJob>>() => Center(
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
    final AppLocalizations l10n = context.l10n;
    final List<ApplicationWithJob> visible = items
        .where(
          (ApplicationWithJob item) =>
              item.application.status.isClosed == showClosed,
        )
        .toList();
    final int closedCount = items
        .where((ApplicationWithJob i) => i.application.status.isClosed)
        .length;
    // Lo que pide acción va primero y no se repite en su grupo.
    final List<ApplicationWithJob> due = showClosed
        ? <ApplicationWithJob>[]
        : visible
              .where(
                (ApplicationWithJob i) =>
                    isFollowUpDue(application: i.application, now: now),
              )
              .toList();
    final List<ApplicationWithJob> rest = visible
        .where((ApplicationWithJob i) => !due.contains(i))
        .toList();
    return PullToRefresh(
      providers: <Refreshable<Future<Object?>>>[
        applicationsControllerProvider.future,
      ],
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: <Widget>[
          _Funnel(items: items),
          const SizedBox(height: 18),
          SegmentedTabs<bool>(
            segments: <(bool, String)>[
              (false, '${l10n.boardActive} (${items.length - closedCount})'),
              (true, '${l10n.boardClosed} ($closedCount)'),
            ],
            selected: showClosed,
            onChanged: onToggle,
          ),
          if (due.isNotEmpty) ...<Widget>[
            const SizedBox(height: 22),
            SectionLabel(
              '${l10n.applicationsNeedsAction} · ${due.length}',
              color: context.colors.onSignalSoft,
            ),
            for (final ApplicationWithJob item in due)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _ApplicationCard(item: item, now: now, due: true),
              ),
          ],
          for (final ApplicationStatus status in boardOrder)
            if (rest
                    .where(
                      (ApplicationWithJob i) => i.application.status == status,
                    )
                    .toList()
                case final List<ApplicationWithJob> group
                when group.isNotEmpty) ...<Widget>[
              const SizedBox(height: 22),
              SectionLabel('${statusLabel(l10n, status)} · ${group.length}'),
              for (final ApplicationWithJob item in group)
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
    final AppLocalizations l10n = context.l10n;
    final RumboColors colors = context.colors;
    final TextTheme textTheme = Theme.of(context).textTheme;
    int count(Set<ApplicationStatus> statuses) => items
        .where(
          (ApplicationWithJob i) => statuses.contains(i.application.status),
        )
        .length;
    final List<(String, int, Color)> stages = <(String, int, Color)>[
      (
        statusLabel(l10n, ApplicationStatus.preparing),
        count(<ApplicationStatus>{
          ApplicationStatus.saved,
          ApplicationStatus.preparing,
        }),
        colors.muted,
      ),
      (
        statusLabel(l10n, ApplicationStatus.applied),
        count(<ApplicationStatus>{
          ApplicationStatus.applied,
          ApplicationStatus.inReview,
        }),
        colors.info,
      ),
      (
        statusLabel(l10n, ApplicationStatus.interview),
        count(<ApplicationStatus>{
          ApplicationStatus.interview,
          ApplicationStatus.technicalTest,
        }),
        colors.signal,
      ),
      (
        statusLabel(l10n, ApplicationStatus.offer),
        count(<ApplicationStatus>{
          ApplicationStatus.offer,
          ApplicationStatus.accepted,
        }),
        colors.accent,
      ),
    ];
    return Semantics(
      container: true,
      label: stages
          .map(((String, int, Color) s) => '${s.$1}: ${s.$2}')
          .join(', '),
      excludeSemantics: true,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              for (final (int index, (_, int value, Color color))
                  in stages.indexed) ...<Widget>[
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
            children: <Widget>[
              for (final (String label, int value, _) in stages)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final RumboColors colors = context.colors;
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
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CompanyMark(company: item.job.company),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
