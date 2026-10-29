import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/company_mark.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/pull_to_refresh.dart';
import '../../../shared/widgets/root_app_bar.dart';
import '../../../shared/widgets/segmented_tabs.dart';
import '../../applications/domain/application_status.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../search/data/search_repository.dart';
import '../../search/presentation/search_controller.dart';
import '../data/job_analyzer.dart';
import '../domain/job.dart';
import '../domain/job_filter.dart';
import 'job_widgets.dart';
import 'jobs_controller.dart';

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({super.key});

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  /// Nulo hasta que el usuario elige: se abre en «Sugeridas» solo si hay.
  bool? _showSavedChoice;
  JobFilter _filter = const JobFilter();

  @override
  void initState() {
    super.initState();
    // Busca sola al abrir la pestaña si la última búsqueda es antigua.
    Future.microtask(
      () => ref.read(jobSearchControllerProvider.notifier).runIfStale(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final canAnalyze = ref.watch(jobAnalyzerProvider) != null;
    final state = ref.watch(jobsControllerProvider);
    ref.listen(jobSearchControllerProvider, (previous, next) {
      if (previous is! SearchRunning) return;
      final message = _searchMessage(l10n, next);
      if (message != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    });
    return Scaffold(
      appBar: rootAppBar(
        context,
        l10n.tabJobs,
        actions: [
          if (canAnalyze)
            BarButton(
              key: const Key('addJob'),
              icon: Icons.add,
              tooltip: l10n.jobAdd,
              filled: true,
              onPressed: () => const JobNewRoute().push(context),
            ),
        ],
      ),
      // Con datos (también mientras se actualizan al deslizar) se muestran.
      body: switch (state) {
        AsyncValue(:final value?) => _buildBody(context, value),
        AsyncError() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.jobsLoadError),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => ref.invalidate(jobsControllerProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Widget _buildBody(BuildContext context, List<SavedJob> jobs) {
    final l10n = AppLocalizations.of(context);
    final now = ref.watch(clockProvider)();
    final suggested = jobs.where((s) => s.job.isSuggestion).toList()
      ..sort((a, b) => (b.match?.score ?? 0).compareTo(a.match?.score ?? 0));
    // Las ofertas con proceso ya enviado (Postulada en adelante) se siguen
    // en Procesos, no aquí.
    final sent = {
      for (final item
          in ref.watch(applicationsControllerProvider).value ?? const [])
        if (item.application.status.index >= ApplicationStatus.applied.index)
          item.application.jobId,
    };
    final saved = jobs
        .where((s) => s.job.isSaved && !sent.contains(s.job.id))
        .toList();
    final showSaved = _showSavedChoice ?? suggested.isEmpty;
    final tab = showSaved ? saved : suggested;
    final visible = _filter.apply(tab, now);
    final dismissed = showSaved
        ? const <SavedJob>[]
        : recentlyDismissed(jobs, now);
    return PullToRefresh(
      providers: [
        jobsControllerProvider.future,
        searchPreferencesProvider.future,
      ],
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          SegmentedTabs<bool>(
            segments: [
              (false, l10n.jobsTabSuggested(suggested.length)),
              (true, l10n.jobsTabSaved(saved.length)),
            ],
            selected: showSaved,
            onChanged: (value) => setState(() => _showSavedChoice = value),
          ),
          const SizedBox(height: 12),
          if (tab.isNotEmpty || _filter.isActive)
            _FilterBar(
              filter: _filter,
              sources: {
                for (final item in tab)
                  if (sourceName(item.job.source) != null) item.job.source,
              }.toList()..sort(),
              onChanged: (filter) => setState(() => _filter = filter),
            ),
          if (!showSaved) const _SearchBar(),
          if (tab.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: showSaved
                  ? EmptyState(
                      icon: Icons.work_outline,
                      title: l10n.jobsEmptyTitle,
                      body: l10n.jobsEmptyBody,
                    )
                  : const _NoSuggestions(),
            )
          else if (visible.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Text(
                    l10n.filterNoResults,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: context.colors.muted),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () =>
                        setState(() => _filter = const JobFilter()),
                    child: Text(l10n.filterClear),
                  ),
                ],
              ),
            )
          else
            for (final item in visible)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: showSaved
                    ? JobCard(saved: item)
                    : _DismissibleSuggestion(saved: item),
              ),
          if (dismissed.isNotEmpty) _DismissedSection(items: dismissed),
        ],
      ),
    );
  }
}

/// Filtros rápidos: remoto, nota mínima, recientes y portal.
class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.filter,
    required this.sources,
    required this.onChanged,
  });

  final JobFilter filter;
  final List<String> sources;
  final ValueChanged<JobFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final source = filter.source;
    // En varias líneas, para que «Quitar filtros» siempre se vea.
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          FilterChip(
            key: const Key('filterRemote'),
            label: Text(l10n.workModeRemote),
            selected: filter.remoteOnly,
            onSelected: (value) =>
                onChanged(filter.copyWith(remoteOnly: value)),
          ),
          FilterChip(
            key: const Key('filterGoodMatch'),
            label: Text(l10n.filterGoodMatch(JobFilter.minScore)),
            selected: filter.goodMatchOnly,
            onSelected: (value) =>
                onChanged(filter.copyWith(goodMatchOnly: value)),
          ),
          FilterChip(
            key: const Key('filterRecent'),
            label: Text(l10n.filterRecent(JobFilter.recentDays)),
            selected: filter.recentOnly,
            onSelected: (value) =>
                onChanged(filter.copyWith(recentOnly: value)),
          ),
          if (sources.isNotEmpty || source != null) ...[
            PopupMenuButton<String?>(
              key: const Key('filterSource'),
              tooltip: l10n.filterSource,
              onSelected: (value) => onChanged(filter.copyWith(source: value)),
              itemBuilder: (context) => [
                PopupMenuItem(value: null, child: Text(l10n.filterAllSources)),
                for (final item in sources)
                  PopupMenuItem(value: item, child: Text(sourceName(item)!)),
              ],
              child: IgnorePointer(
                child: FilterChip(
                  label: Text(
                    source == null
                        ? l10n.filterSource
                        : sourceName(source) ?? source,
                  ),
                  avatar: const Icon(Icons.arrow_drop_down, size: 18),
                  selected: source != null,
                  showCheckmark: false,
                  onSelected: (_) {},
                ),
              ),
            ),
          ],
          if (filter.isActive) ...[
            TextButton(
              key: const Key('filterClear'),
              onPressed: () => onChanged(const JobFilter()),
              child: Text(l10n.filterClear),
            ),
          ],
        ],
      ),
    );
  }
}

/// Sugerencias descartadas hace poco, plegadas al final, para recuperarlas.
class _DismissedSection extends ConsumerWidget {
  const _DismissedSection({required this.items});

  final List<SavedJob> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Theme(
        // Sin las líneas que ExpansionTile pinta al abrirse.
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: const Key('dismissedSection'),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          title: Text(
            l10n.dismissedTitle(items.length),
            style: AppTheme.overline(context),
          ),
          subtitle: Text(l10n.dismissedHint, style: theme.textTheme.bodySmall),
          children: [
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    if (item.match case final match?)
                      ScoreBadge(score: match.score, size: 40)
                    else
                      CompanyMark(company: item.job.company),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobTitle(l10n, item.job),
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            jobSubtitle(context, item.job),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      key: Key('restore-${item.job.id}'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                      ),
                      onPressed: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        try {
                          await ref
                              .read(jobsControllerProvider.notifier)
                              .restoreSuggestion(item.job.id);
                          // Sustituye al aviso de «descartada» si aún se ve.
                          messenger
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(content: Text(l10n.suggestionRestored)),
                            );
                        } catch (_) {
                          messenger.showSnackBar(
                            SnackBar(content: Text(l10n.saveError)),
                          );
                        }
                      },
                      child: Text(l10n.dismissedRestore),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

String? _searchMessage(AppLocalizations l10n, SearchState state) =>
    switch (state) {
      SearchDone(:final summary) => [
        l10n.searchResult(summary.suggested),
        if (summary.failedSources.isNotEmpty)
          l10n.searchSourcesFailed(
            summary.failedSources.map((s) => sourceName(s) ?? s).join(', '),
          ),
      ].join(' '),
      SearchFailed(:final reason) => switch (reason) {
        SearchFailure.noPreferences => l10n.searchNoPreferences,
        SearchFailure.tooSoon => l10n.searchTooSoon,
        SearchFailure.dailyLimit => l10n.aiErrorDailyLimit,
        SearchFailure.rateLimited => l10n.aiErrorRateLimited,
        SearchFailure.busy => l10n.aiErrorBusy,
        SearchFailure.other => l10n.searchError,
      },
      _ => null,
    };

/// Botón de búsqueda y fecha de la última, o invitación a configurarla.
class _SearchBar extends ConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final preferencesState = ref.watch(searchPreferencesProvider);
    // Mientras cargan no se sabe si están configuradas: no mostrar nada.
    if (!preferencesState.hasValue && !preferencesState.hasError) {
      return const SizedBox(height: 12);
    }
    final preferences = preferencesState.value;
    final running = ref.watch(jobSearchControllerProvider) is SearchRunning;
    if (preferences == null || !preferences.isConfigured) {
      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.searchSetupTitle, style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(l10n.searchSetupBody),
              const SizedBox(height: 12),
              FilledButton(
                key: const Key('setupSearch'),
                onPressed: () => const SearchPreferencesRoute().push(context),
                child: Text(l10n.searchSetupButton),
              ),
            ],
          ),
        ),
      );
    }
    final lastRun = preferences.lastRunAt;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              running
                  ? l10n.searchRunning
                  : lastRun == null
                  ? ''
                  : l10n.searchLastRun(
                      DateFormat.MMMd(
                        Localizations.localeOf(context).toLanguageTag(),
                      ).add_Hm().format(lastRun),
                    ),
              style: theme.textTheme.bodySmall,
            ),
          ),
          if (running)
            const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            TextButton.icon(
              key: const Key('searchNow'),
              onPressed: () =>
                  ref.read(jobSearchControllerProvider.notifier).run(),
              icon: const Icon(Icons.travel_explore),
              label: Text(l10n.searchNow),
            ),
          IconButton(
            tooltip: l10n.searchPrefsTitle,
            onPressed: () => const SearchPreferencesRoute().push(context),
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
    );
  }
}

class _NoSuggestions extends ConsumerWidget {
  const _NoSuggestions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configured =
        ref.watch(searchPreferencesProvider).value?.isConfigured ?? false;
    if (!configured) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Text(
      AppLocalizations.of(context).searchNoSuggestions,
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

/// Sugerencia que se descarta deslizando hacia la izquierda.
class _DismissibleSuggestion extends ConsumerWidget {
  const _DismissibleSuggestion({required this.saved});

  final SavedJob saved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: ValueKey(saved.job.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(AppTheme.radius),
        ),
        child: Text(
          l10n.suggestionDismiss,
          style: TextStyle(color: scheme.onErrorContainer),
        ),
      ),
      onDismissed: (_) {
        ref
            .read(jobsControllerProvider.notifier)
            .dismissSuggestion(saved.job.id);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.suggestionDismissed)));
      },
      child: JobCard(saved: saved),
    );
  }
}

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.saved});

  final SavedJob saved;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final job = saved.job;
    final match = saved.match;
    final salary = formatSalary(context, job);
    final source = sourceName(job.source);
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => JobDetailRoute(id: job.id).push(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (match != null)
                ScoreBadge(score: match.score)
              else
                CompanyMark(company: job.company, size: 52),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobTitle(l10n, job),
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      jobSubtitle(context, job),
                      // Algunos portales listan decenas de países.
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (salary != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          salary,
                          style: AppTheme.numbers(theme.textTheme.bodySmall)
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    if (job.discovered && source != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(source, style: theme.textTheme.bodySmall),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
