import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../jobs/domain/job.dart';
import '../../jobs/presentation/job_widgets.dart';
import '../../profile/domain/profile.dart';
import '../../profile/presentation/form_helpers.dart';
import '../../profile/presentation/profile_controller.dart';
import '../data/search_repository.dart';
import '../domain/search_preferences.dart';
import 'search_controller.dart';

class SearchPreferencesScreen extends ConsumerStatefulWidget {
  const SearchPreferencesScreen({super.key});

  @override
  ConsumerState<SearchPreferencesScreen> createState() =>
      _SearchPreferencesScreenState();
}

class _SearchPreferencesScreenState
    extends ConsumerState<SearchPreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _roles = TextEditingController();
  final _technologies = TextEditingController();
  final _countries = TextEditingController();
  final _boardUrl = TextEditingController();
  String? _boardError;
  var _preferences = const SearchPreferences();
  bool _loaded = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// Sin preferencias guardadas, propone valores a partir del perfil.
  Future<void> _load() async {
    final saved = await ref.read(searchPreferencesProvider.future);
    var preferences = saved ?? const SearchPreferences();
    if (saved == null) {
      // Si el perfil aún no se cargó (no se abrió la pestaña HV), se espera.
      final profile = await ref
          .read(profileControllerProvider.future)
          .catchError((Object _) => const ProfileData());
      preferences = preferences.copyWith(
        technologies: [
          for (final skill in profile.skills)
            if (skill.category == SkillCategory.framework ||
                skill.category == SkillCategory.language)
              skill.name,
        ].take(4).toList(),
        countries: [
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
    final l10n = AppLocalizations.of(context);
    final preferences = _preferences.copyWith(
      roles: splitCommas(_roles.text),
      technologies: splitCommas(_technologies.text),
      countries: splitCommas(_countries.text),
    );
    final error = !preferences.isConfigured
        ? l10n.searchNeedsTerms
        : preferences.workModes.isEmpty
        ? l10n.searchNeedsMode
        : preferences.sources.isEmpty
        ? l10n.searchNeedsSource
        : null;
    setState(() => _error = error);
    if (error != null) return;
    final messenger = ScaffoldMessenger.of(context);
    saveAndClose(context, () async {
      await ref.read(searchRepositoryProvider).savePreferences(preferences);
      ref.invalidate(searchPreferencesProvider);
      messenger.showSnackBar(SnackBar(content: Text(l10n.searchSaved)));
      // Con preferencias nuevas, busca enseguida en vez de esperar 6 horas.
      unawaited(ref.read(jobSearchControllerProvider.notifier).run());
    });
  }

  /// Vuelve a leer lo guardado en el servidor; descarta lo no guardado.
  Future<void> _refresh() async {
    ref.invalidate(searchPreferencesProvider);
    try {
      await _load();
    } catch (error) {
      debugPrint('refresh: $error');
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
    final l10n = AppLocalizations.of(context);
    final error = board == null
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
          watchedBoards: [..._preferences.watchedBoards, board!],
        );
      }
    });
    return error == null;
  }

  List<T> _toggle<T>(List<T> list, T value, bool selected) =>
      selected ? [...list, value] : list.where((v) => v != value).toList();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    if (!_loaded) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.searchPrefsTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final suggestions = [
      for (final suggestion in flutterBoardSuggestions)
        if (!_preferences.watchedBoards.contains(suggestion.board)) suggestion,
    ];
    return ProfileFormScaffold(
      title: l10n.searchPrefsTitle,
      formKey: _formKey,
      onSave: _save,
      onRefresh: _refresh,
      children: [
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
          children: [
            Text(l10n.searchWorkModes, style: AppTheme.sectionTitle(context)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final mode in WorkMode.values)
                  FilterChip(
                    label: Text(workModeLabel(l10n, mode)),
                    selected: _preferences.workModes.contains(mode),
                    onSelected: (selected) => setState(
                      () => _preferences = _preferences.copyWith(
                        workModes: _toggle(
                          _preferences.workModes,
                          mode,
                          selected,
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
          children: [
            Text(l10n.searchSources, style: AppTheme.sectionTitle(context)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final source in searchSources)
                  FilterChip(
                    label: Text(sourceName(source) ?? source),
                    selected: _preferences.sources.contains(source),
                    onSelected: (selected) => setState(
                      () => _preferences = _preferences.copyWith(
                        sources: _toggle(
                          _preferences.sources,
                          source,
                          selected,
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
          children: [
            Text(l10n.watchedTitle, style: AppTheme.sectionTitle(context)),
            const SizedBox(height: 8),
            if (_preferences.watchedBoards.isEmpty)
              Text(l10n.watchedEmpty, style: theme.textTheme.bodySmall)
            else
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final board in _preferences.watchedBoards)
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
                              .where((b) => b != board)
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
            if (suggestions.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(l10n.watchedSuggestions, style: theme.textTheme.titleSmall),
              const SizedBox(height: 2),
              Text(
                l10n.watchedSuggestionsHint,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              for (final suggestion in suggestions)
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
          children: [
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
              onChanged: (value) => setState(
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
