import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../data/achievement_rewriter.dart';
import '../domain/profile.dart';
import 'profile_controller.dart';

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
  Object? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final draft in _drafts ?? const <_Draft>[]) {
      draft.controller.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final rewriter = ref.read(achievementRewriterProvider);
    if (rewriter == null) return;
    setState(() {
      _error = null;
      _drafts = null;
    });
    try {
      final suggestions = await rewriter.suggest(widget.experienceId);
      if (mounted) {
        setState(() => _drafts = [for (final s in suggestions) _Draft(s)]);
      }
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  Experience? get _experience => ref
      .read(profileControllerProvider)
      .value
      ?.experiences
      .firstWhereOrNull((e) => e.id == widget.experienceId);

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final experience = _experience;
    if (experience == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(profileControllerProvider.notifier)
          .saveExperience(
            experience.copyWith(
              achievements: applySuggestions(experience.achievements, [
                for (final draft in _drafts!)
                  if (draft.use)
                    (
                      index: draft.suggestion.index,
                      text: draft.controller.text,
                    ),
              ]),
            ),
          );
      messenger.showSnackBar(SnackBar(content: Text(l10n.improveSaved)));
      navigator.pop();
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final drafts = _drafts;
    final pending =
        drafts?.any(
          (d) => d.use && placeholderPattern.hasMatch(d.controller.text),
        ) ??
        false;
    final anyChosen = drafts?.any((d) => d.use) ?? false;
    final experience = _experience;
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
      body: switch ((drafts, _error)) {
        (_, final error?) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NoticeBanner(
                text: switch (error) {
                  RewriteException(reason: RewriteFailure.dailyLimit) =>
                    l10n.aiErrorDailyLimit,
                  RewriteException(reason: RewriteFailure.busy) =>
                    l10n.aiErrorBusy,
                  RewriteException(reason: RewriteFailure.rateLimited) =>
                    l10n.aiErrorRateLimited,
                  _ => l10n.saveError,
                },
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
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(l10n.improveLoading),
            ],
          ),
        ),
        (final list?, _) when list.isEmpty => EmptyState(
          icon: Icons.check_circle_outline,
          title: l10n.improveTitle,
          body: l10n.improveEmpty,
        ),
        (final list?, _) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
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
            if (pending) ...[
              const SizedBox(height: 12),
              NoticeBanner(
                key: const Key('fillPlaceholders'),
                text: l10n.improveFill,
                icon: Icons.edit_note,
              ),
            ],
            const SizedBox(height: 16),
            for (final (index, draft) in list.indexed)
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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.colors;
    final suggestion = draft.suggestion;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
                  onChanged: (value) {
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
            if (suggestion.reason.isNotEmpty) ...[
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
