import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/profile/application/use_cases/suggest_achievements_use_case.dart';
import 'package:rumbo/features/profile/domain/entities/achievement_suggestion.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/achievement_suggestions.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/widgets/empty_state.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';

/// Propuestas de la IA para los logros de una experiencia: la persona
/// completa los huecos, elige cuáles usar y las guarda.
class ImproveAchievementsScreen extends ConsumerStatefulWidget {
  const ImproveAchievementsScreen({super.key, required this.experienceId});

  final String experienceId;

  @override
  ConsumerState<ImproveAchievementsScreen> createState() =>
      _ImproveAchievementsScreenState();
}

class _Draft {
  _Draft(this.suggestion)
    : controller = TextEditingController(text: suggestion.rewritten);

  final AchievementSuggestion suggestion;
  final TextEditingController controller;
  bool use = true;
}

class _ImproveAchievementsScreenState
    extends ConsumerState<ImproveAchievementsScreen> {
  List<_Draft>? _drafts;
  Failure? _failure;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final _Draft draft in _drafts ?? const <_Draft>[]) {
      draft.controller.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final SuggestAchievementsUseCase suggestAchievements = ref.read(
      suggestAchievementsUseCaseProvider,
    );
    if (!suggestAchievements.isAvailable) return;
    setState(() {
      _failure = null;
      _drafts = null;
    });
    final Result<List<AchievementSuggestion>> result =
        await suggestAchievements(widget.experienceId);
    if (!mounted) return;
    setState(() {
      _failure = result.failureOrNull;
      _drafts = result.valueOrNull
          ?.map((AchievementSuggestion s) => _Draft(s))
          .toList();
    });
  }

  Experience? get _experience => ref
      .read(profileControllerProvider)
      .value
      ?.experiences
      .firstWhereOrNull((Experience e) => e.id == widget.experienceId);

  Future<void> _save() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final Experience? experience = _experience;
    if (experience == null) return;
    setState(() => _saving = true);
    final Result<void> result = await ref
        .read(profileControllerProvider.notifier)
        .saveExperience(
          experience.copyWith(
            achievements: applySuggestions(
              achievements: experience.achievements,
              chosen: <({int? index, String text})>[
                for (final _Draft draft in _drafts!)
                  if (draft.use)
                    (
                      index: draft.suggestion.index,
                      text: draft.controller.text,
                    ),
              ],
            ),
          ),
        );
    if (showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: result,
      success: l10n.improveSaved,
    )) {
      navigator.pop();
    } else if (mounted) {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final List<_Draft>? drafts = _drafts;
    final bool pending =
        drafts?.any(
          (_Draft d) => d.use && placeholderPattern.hasMatch(d.controller.text),
        ) ??
        false;
    final bool anyChosen = drafts?.any((_Draft d) => d.use) ?? false;
    final Experience? experience = _experience;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.improveTitle)),
      bottomNavigationBar: drafts == null || drafts.isEmpty
          ? null
          : DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border(top: BorderSide(color: context.colors.line)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: FilledButton(
                    key: const Key('saveImproved'),
                    onPressed: _saving || pending || !anyChosen ? null : _save,
                    child: Text(l10n.improveSave),
                  ),
                ),
              ),
            ),
      body: switch ((drafts, _failure)) {
        (_, final Failure failure?) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              NoticeBanner(
                text: failureMessage(
                  l10n: l10n,
                  failure: failure,
                  fallback: l10n.saveError,
                ),
                icon: Icons.error_outline,
                tone: Tone.risk,
              ),
              const SizedBox(height: 12),
              OutlinedButton(onPressed: _load, child: Text(l10n.retry)),
            ],
          ),
        ),
        (null, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(l10n.improveLoading),
            ],
          ),
        ),
        (final List<_Draft> list?, _) when list.isEmpty => EmptyState(
          icon: Icons.check_circle_outline,
          title: l10n.improveTitle,
          body: l10n.improveEmpty,
        ),
        (final List<_Draft> list?, _) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: <Widget>[
            if (experience != null)
              Text(
                '${experience.role} · ${experience.company}',
                style: AppTheme.sectionTitle(context),
              ),
            const SizedBox(height: 6),
            Text(
              l10n.improveHint,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (pending) ...<Widget>[
              const SizedBox(height: 12),
              NoticeBanner(
                key: const Key('fillPlaceholders'),
                text: l10n.improveFill,
                icon: Icons.edit_note,
              ),
            ],
            const SizedBox(height: 16),
            for (final (int index, _Draft draft) in list.indexed)
              _SuggestionCard(
                key: Key('suggestion-$index'),
                draft: draft,
                onChanged: () => setState(() {}),
              ),
          ],
        ),
      },
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({
    super.key,
    required this.draft,
    required this.onChanged,
  });

  final _Draft draft;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final RumboColors colors = context.colors;
    final AchievementSuggestion suggestion = draft.suggestion;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    suggestion.original.isEmpty
                        ? l10n.improveNew
                        : l10n.improveBefore,
                    style: AppTheme.overline(context),
                  ),
                ),
                Text(l10n.improveUse),
                Checkbox(
                  value: draft.use,
                  onChanged: (bool? value) {
                    draft.use = value ?? false;
                    onChanged();
                  },
                ),
              ],
            ),
            if (suggestion.original.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 10),
                child: Text(
                  suggestion.original,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.muted,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextField(
                controller: draft.controller,
                enabled: draft.use,
                minLines: 2,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (_) => onChanged(),
              ),
            ),
            if (suggestion.reason.isNotEmpty) ...<Widget>[
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  suggestion.reason,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
