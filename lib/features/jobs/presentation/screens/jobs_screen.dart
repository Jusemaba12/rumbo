import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:intl/intl.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/jobs/application/use_cases/analyze_job_use_case.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/entities/job_filter.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/domain/entities/search_summary.dart';
import 'package:rumbo/features/search/domain/failures/search_failures.dart';
import 'package:rumbo/features/search/presentation/providers/search/search_provider.dart';
import 'package:rumbo/features/search/presentation/providers/search/search_state.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/company_mark.dart';
import 'package:rumbo/shared/presentation/widgets/empty_state.dart';
import 'package:rumbo/shared/presentation/widgets/pull_to_refresh.dart';
import 'package:rumbo/shared/presentation/widgets/root_app_bar.dart';
import 'package:rumbo/shared/presentation/widgets/segmented_tabs.dart';

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
    Future<void>.microtask(
      () => ref.read(jobSearchControllerProvider.notifier).runIfStale(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final bool canAnalyze = ref.watch(analyzeJobUseCaseProvider).isAvailable;
    final AsyncValue<List<SavedJob>> state = ref.watch(jobsControllerProvider);
    ref.listen(jobSearchControllerProvider, (
      SearchState? previous,
      SearchState next,
    ) {
      if (previous is! SearchRunning) return;
      final String? message = _searchMessage(l10n, next);
      if (message != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    });
    return Scaffold(
      appBar: rootAppBar(
        context,
        l10n.tabJobs,
        actions: <Widget>[
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
        AsyncValue<List<SavedJob>>(:final List<SavedJob> value?) => _buildBody(
          context,
          value,
        ),
        AsyncError<List<SavedJob>>() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
    final AppLocalizations l10n = context.l10n;
    final DateTime now = ref.watch(clockProvider)();
    final List<SavedJob> suggested =
        jobs.where((SavedJob s) => s.job.isSuggestion).toList()..sort(
          (SavedJob a, SavedJob b) =>
              (b.match?.score ?? 0).compareTo(a.match?.score ?? 0),
        );
    // Las ofertas con proceso ya enviado (Postulada en adelante) se siguen
    // en Procesos, no aquí.
    final Set<String> sent = <String>{
      for (final ApplicationWithJob item
          in ref.watch(applicationsControllerProvider).value ??
              const <ApplicationWithJob>[])
        if (item.application.status.index >= ApplicationStatus.applied.index)
          item.application.jobId,
    };
    final List<SavedJob> saved = jobs
        .where((SavedJob s) => s.job.isSaved && !sent.contains(s.job.id))
        .toList();
    final bool showSaved = _showSavedChoice ?? suggested.isEmpty;
    final List<SavedJob> tab = showSaved ? saved : suggested;
    final List<SavedJob> visible = _filter.apply(jobs: tab, now: now);
    final List<SavedJob> dismissed = showSaved
        ? const <SavedJob>[]
        : recentlyDismissed(jobs: jobs, now: now);
    return PullToRefresh(
      providers: <Refreshable<Future<Object?>>>[
        jobsControllerProvider.future,
        searchPreferencesProvider.future,
      ],
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: <Widget>[
          SegmentedTabs<bool>(
            segments: <(bool, String)>[
              (false, l10n.jobsTabSuggested(suggested.length)),
              (true, l10n.jobsTabSaved(saved.length)),
            ],
            selected: showSaved,
            onChanged: (bool value) => setState(() => _showSavedChoice = value),
          ),
          const SizedBox(height: 12),
          if (tab.isNotEmpty || _filter.isActive)
            _FilterBar(
              filter: _filter,
              sources: <String>{
                for (final SavedJob item in tab)
                  if (sourceName(item.job.source) != null) item.job.source,
              }.toList()..sort(),
              onChanged: (JobFilter filter) => setState(() => _filter = filter),
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
                children: <Widget>[
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
            for (final SavedJob item in visible)
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
    final AppLocalizations l10n = context.l10n;
    final String? source = filter.source;
    // En varias líneas, para que «Quitar filtros» siempre se vea.
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          FilterChip(
            key: const Key('filterRemote'),
            label: Text(l10n.workModeRemote),
            selected: filter.remoteOnly,
            onSelected: (bool value) =>
                onChanged(filter.copyWith(remoteOnly: value)),
          ),
          FilterChip(
            key: const Key('filterGoodMatch'),
            label: Text(l10n.filterGoodMatch(JobFilter.minScore)),
            selected: filter.goodMatchOnly,
            onSelected: (bool value) =>
                onChanged(filter.copyWith(goodMatchOnly: value)),
          ),
          FilterChip(
            key: const Key('filterRecent'),
            label: Text(l10n.filterRecent(JobFilter.recentDays)),
            selected: filter.recentOnly,
            onSelected: (bool value) =>
                onChanged(filter.copyWith(recentOnly: value)),
          ),
          if (sources.isNotEmpty || source != null) ...<Widget>[
            PopupMenuButton<String?>(
              key: const Key('filterSource'),
              tooltip: l10n.filterSource,
              onSelected: (String? value) =>
                  onChanged(filter.copyWith(source: value)),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String?>>[
                PopupMenuItem<String?>(
                  value: null,
                  child: Text(l10n.filterAllSources),
                ),
                for (final String item in sources)
                  PopupMenuItem<String?>(
                    value: item,
                    child: Text(sourceName(item)!),
                  ),
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
          if (filter.isActive) ...<Widget>[
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
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
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
          children: <Widget>[
            for (final SavedJob item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: <Widget>[
                    if (item.match case final JobMatch match?)
                      ScoreBadge(score: match.score, size: 40)
                    else
                      CompanyMark(company: item.job.company),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                        final ScaffoldMessengerState messenger =
                            ScaffoldMessenger.of(context);
                        final Result<void> result = await ref
                            .read(jobsControllerProvider.notifier)
                            .restoreSuggestion(item.job.id);
                        // Sustituye al aviso de «descartada» si aún se ve.
                        messenger.hideCurrentSnackBar();
                        showResultSnackBar(
                          messenger: messenger,
                          l10n: l10n,
                          result: result,
                          success: l10n.suggestionRestored,
                        );
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
      SearchDone(:final SearchSummary summary) => <String>[
        l10n.searchResult(summary.suggested),
        if (summary.failedSources.isNotEmpty)
          l10n.searchSourcesFailed(
            summary.failedSources
                .map((String s) => sourceName(s) ?? s)
                .join(', '),
          ),
      ].join(' '),
      SearchFailed(:final Failure failure) => switch (failure) {
        NoPreferencesFailure() => l10n.searchNoPreferences,
        TooSoonFailure() => l10n.searchTooSoon,
        _ => failureMessage(
          l10n: l10n,
          failure: failure,
          fallback: l10n.searchError,
        ),
      },
      _ => null,
    };

/// Botón de búsqueda y fecha de la última, o invitación a configurarla.
class _SearchBar extends ConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final AsyncValue<SearchPreferences?> preferencesState = ref.watch(
      searchPreferencesProvider,
    );
    // Mientras cargan no se sabe si están configuradas: no mostrar nada.
    if (!preferencesState.hasValue && !preferencesState.hasError) {
      return const SizedBox(height: 12);
    }
    final SearchPreferences? preferences = preferencesState.value;
    final bool running =
        ref.watch(jobSearchControllerProvider) is SearchRunning;
    if (preferences == null || !preferences.isConfigured) {
      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
    final DateTime? lastRun = preferences.lastRunAt;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: <Widget>[
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
    final bool configured =
        ref.watch(searchPreferencesProvider).value?.isConfigured ?? false;
    if (!configured) return const SizedBox.shrink();
    final ThemeData theme = Theme.of(context);
    return Text(
      context.l10n.searchNoSuggestions,
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
    final AppLocalizations l10n = context.l10n;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: ValueKey<String>(saved.job.id),
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
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final Job job = saved.job;
    final JobMatch? match = saved.match;
    final String? salary = formatSalary(context, job);
    final String? source = sourceName(job.source);
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => JobDetailRoute(id: job.id).push(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (match != null)
                ScoreBadge(score: match.score)
              else
                CompanyMark(company: job.company, size: 52),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
