import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/features/search/application/use_cases/save_search_preferences_use_case.dart';
import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/presentation/providers/search/search_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';
import 'package:rumbo/shared/utils/log.dart';

class SearchPreferencesScreen extends ConsumerStatefulWidget {
  const SearchPreferencesScreen({super.key});

  @override
  ConsumerState<SearchPreferencesScreen> createState() =>
      _SearchPreferencesScreenState();
}

class _SearchPreferencesScreenState
    extends ConsumerState<SearchPreferencesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _roles = TextEditingController();
  final TextEditingController _technologies = TextEditingController();
  final TextEditingController _countries = TextEditingController();
  final TextEditingController _boardUrl = TextEditingController();
  String? _boardError;
  SearchPreferences _preferences = const SearchPreferences();
  bool _loaded = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// Sin preferencias guardadas, propone valores a partir del perfil.
  Future<void> _load() async {
    final SearchPreferences? saved = await ref.read(
      searchPreferencesProvider.future,
    );
    SearchPreferences preferences = saved ?? const SearchPreferences();
    if (saved == null) {
      // Si el perfil aún no se cargó (no se abrió la pestaña HV), se espera.
      final ProfileData profile = await ref
          .read(profileControllerProvider.future)
          .catchError((Object _) => const ProfileData());
      preferences = preferences.copyWith(
        technologies: <String>[
          for (final Skill skill in profile.skills)
            if (skill.category == SkillCategory.framework ||
                skill.category == SkillCategory.language)
              skill.name,
        ].take(4).toList(),
        countries: <String>[
          if (profile.profile.location.contains(','))
            profile.profile.location.split(',').last.trim(),
        ],
      );
    }
    if (!mounted) return;
    _roles.text = preferences.roles.join(', ');
    _technologies.text = preferences.technologies.join(', ');
    _countries.text = preferences.countries.join(', ');
    setState(() {
      _preferences = preferences;
      _loaded = true;
    });
  }

  @override
  void dispose() {
    _roles.dispose();
    _technologies.dispose();
    _countries.dispose();
    _boardUrl.dispose();
    super.dispose();
  }

  void _save() {
    final AppLocalizations l10n = context.l10n;
    final SearchPreferences preferences = _preferences.copyWith(
      roles: splitCommas(_roles.text),
      technologies: splitCommas(_technologies.text),
      countries: splitCommas(_countries.text),
    );
    final String? error = !preferences.isConfigured
        ? l10n.searchNeedsTerms
        : preferences.workModes.isEmpty
        ? l10n.searchNeedsMode
        : preferences.sources.isEmpty
        ? l10n.searchNeedsSource
        : null;
    setState(() => _error = error);
    if (error != null) return;
    saveAndClose(context, () async {
      final Result<void> saved = await ref.read(
        saveSearchPreferencesUseCaseProvider,
      )(preferences);
      if (saved.isOk) {
        ref.invalidate(searchPreferencesProvider);
        // Con preferencias nuevas, busca enseguida en vez de esperar 6 horas.
        unawaited(ref.read(jobSearchControllerProvider.notifier).run());
      }
      return saved;
    }, success: l10n.searchSaved);
  }

  /// Vuelve a leer lo guardado en el servidor; descarta lo no guardado.
  Future<void> _refresh() async {
    ref.invalidate(searchPreferencesProvider);
    try {
      await _load();
    } catch (error) {
      Log.w(tag: 'SearchPreferencesScreen', message: 'refresh: $error');
      return;
    }
    if (!mounted) return;
    _boardUrl.clear();
    setState(() {
      _boardError = null;
      _error = null;
    });
  }

  void _addBoard() {
    if (_add(parseBoardUrl(_boardUrl.text))) _boardUrl.clear();
  }

  /// Añade [board] a las vigiladas; falso si no se pudo (y muestra el error).
  bool _add(WatchedBoard? board) {
    final AppLocalizations l10n = context.l10n;
    final String? error = board == null
        ? l10n.watchedInvalid
        : _preferences.watchedBoards.contains(board)
        ? l10n.watchedDuplicate
        : _preferences.watchedBoards.length >= maxWatchedBoards
        ? l10n.watchedLimit(maxWatchedBoards)
        : null;
    setState(() {
      _boardError = error;
      if (error == null) {
        _preferences = _preferences.copyWith(
          watchedBoards: <WatchedBoard>[..._preferences.watchedBoards, board!],
        );
      }
    });
    return error == null;
  }

  List<T> _toggle<T>({
    required List<T> list,
    required T value,
    required bool selected,
  }) =>
      selected ? <T>[...list, value] : list.where((T v) => v != value).toList();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    if (!_loaded) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.searchPrefsTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final List<({WatchedBoard board, String name})> suggestions =
        <({WatchedBoard board, String name})>[
          for (final ({WatchedBoard board, String name}) suggestion
              in flutterBoardSuggestions)
            if (!_preferences.watchedBoards.contains(suggestion.board))
              suggestion,
        ];
    return ProfileFormScaffold(
      title: l10n.searchPrefsTitle,
      formKey: _formKey,
      onSave: _save,
      onRefresh: _refresh,
      children: <Widget>[
        Text(l10n.searchPrefsIntro),
        TextFormField(
          key: const Key('searchRoles'),
          controller: _roles,
          decoration: InputDecoration(
            labelText: l10n.searchRolesLabel,
            helperText: l10n.searchRolesHelper,
            helperMaxLines: 2,
          ),
        ),
        TextFormField(
          key: const Key('searchTechnologies'),
          controller: _technologies,
          decoration: InputDecoration(
            labelText: l10n.searchTechLabel,
            helperText: l10n.searchTechHelper,
            helperMaxLines: 2,
          ),
        ),
        TextFormField(
          key: const Key('searchCountries'),
          controller: _countries,
          decoration: InputDecoration(
            labelText: l10n.searchCountriesLabel,
            helperText: l10n.searchCountriesHelper,
            helperMaxLines: 3,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.searchWorkModes, style: AppTheme.sectionTitle(context)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: <Widget>[
                for (final WorkMode mode in WorkMode.values)
                  FilterChip(
                    label: Text(workModeLabel(l10n, mode)),
                    selected: _preferences.workModes.contains(mode),
                    onSelected: (bool selected) => setState(
                      () => _preferences = _preferences.copyWith(
                        workModes: _toggle(
                          list: _preferences.workModes,
                          value: mode,
                          selected: selected,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.searchSources, style: AppTheme.sectionTitle(context)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: <Widget>[
                for (final String source in searchSources)
                  FilterChip(
                    label: Text(sourceName(source) ?? source),
                    selected: _preferences.sources.contains(source),
                    onSelected: (bool selected) => setState(
                      () => _preferences = _preferences.copyWith(
                        sources: _toggle(
                          list: _preferences.sources,
                          value: source,
                          selected: selected,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.watchedTitle, style: AppTheme.sectionTitle(context)),
            const SizedBox(height: 8),
            if (_preferences.watchedBoards.isEmpty)
              Text(l10n.watchedEmpty, style: theme.textTheme.bodySmall)
            else
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: <Widget>[
                  for (final WatchedBoard board in _preferences.watchedBoards)
                    InputChip(
                      label: Text(
                        '${boardDisplayName(board)} · '
                        '${sourceName(board.provider.name)}',
                      ),
                      deleteButtonTooltipMessage: l10n.watchedRemove(
                        boardDisplayName(board),
                      ),
                      onDeleted: () => setState(
                        () => _preferences = _preferences.copyWith(
                          watchedBoards: _preferences.watchedBoards
                              .where((WatchedBoard b) => b != board)
                              .toList(),
                        ),
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('boardUrl'),
              controller: _boardUrl,
              keyboardType: TextInputType.url,
              autocorrect: false,
              onSubmitted: (_) => _addBoard(),
              decoration: InputDecoration(
                labelText: l10n.watchedLabel,
                helperText: l10n.watchedHelper,
                helperMaxLines: 3,
                errorText: _boardError,
                errorMaxLines: 2,
                suffixIcon: IconButton(
                  key: const Key('addBoard'),
                  tooltip: l10n.watchedAdd,
                  icon: const Icon(Icons.add),
                  onPressed: _addBoard,
                ),
              ),
            ),
            if (suggestions.isNotEmpty) ...<Widget>[
              const SizedBox(height: 16),
              Text(l10n.watchedSuggestions, style: theme.textTheme.titleSmall),
              const SizedBox(height: 2),
              Text(
                l10n.watchedSuggestionsHint,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              for (final ({WatchedBoard board, String name}) suggestion
                  in suggestions)
                ListTile(
                  key: Key('suggest-${suggestion.board.token}'),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${suggestion.name} · '
                    '${sourceName(suggestion.board.provider.name)}',
                  ),
                  subtitle: Text(
                    l10n.watchedSuggestionNote(suggestion.board.token),
                  ),
                  trailing: IconButton(
                    tooltip: l10n.watchedAdd,
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => _add(suggestion.board),
                  ),
                ),
            ],
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.searchMinScore(_preferences.minScore),
              style: theme.textTheme.titleSmall,
            ),
            Slider(
              value: _preferences.minScore.toDouble(),
              min: 40,
              max: 90,
              divisions: 10,
              label: '${_preferences.minScore}',
              onChanged: (double value) => setState(
                () => _preferences = _preferences.copyWith(
                  minScore: value.round(),
                ),
              ),
            ),
          ],
        ),
        if (_error != null)
          Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
      ],
    );
  }
}
