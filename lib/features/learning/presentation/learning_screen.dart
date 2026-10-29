import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/group_card.dart';
import '../../../shared/widgets/pull_to_refresh.dart';
import '../../../shared/widgets/section_label.dart';
import '../../jobs/presentation/jobs_controller.dart';
import '../../profile/data/resume_keywords.dart';
import '../../profile/presentation/profile_controller.dart';
import '../domain/learning.dart';
import 'learning_controller.dart';

String learningStatusLabel(AppLocalizations l10n, LearningStatus status) =>
    switch (status) {
      LearningStatus.pending => l10n.learningStatusPending,
      LearningStatus.learning => l10n.learningStatusLearning,
      LearningStatus.mastered => l10n.learningStatusMastered,
    };

Tone learningStatusTone(LearningStatus status) => switch (status) {
  LearningStatus.pending => Tone.neutral,
  LearningStatus.learning => Tone.signal,
  LearningStatus.mastered => Tone.accent,
};

/// Etiqueta de color con el estado de un tema.
class LearningStatusPill extends StatelessWidget {
  const LearningStatusPill({super.key, required this.status});

  final LearningStatus status;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = context.colors.soft(
      learningStatusTone(status),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        learningStatusLabel(AppLocalizations.of(context), status),
        style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: foreground),
      ),
    );
  }
}

/// Plan de aprendizaje: los temas elegidos y sugerencias de qué aprender.
class LearningScreen extends ConsumerWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final topics = ref.watch(learningControllerProvider).value;
    final candidates = ref.watch(learningCandidatesProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.learningTitle)),
      body: topics == null
          ? const Center(child: CircularProgressIndicator())
          : PullToRefresh(
              providers: [
                learningControllerProvider.future,
                profileControllerProvider.future,
                jobsControllerProvider.future,
                resumeKeywordsProvider.future,
              ],
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                children: [
                  if (topics.isNotEmpty) ...[
                    SectionLabel(l10n.learningMine),
                    GroupCard(
                      children: [
                        for (final topic in topics)
                          ListTile(
                            key: Key('topic-${topic.topic}'),
                            title: Text(
                              topic.topic,
                              style: theme.textTheme.titleSmall,
                            ),
                            subtitle: Text(l10n.learningDemand(topic.demand)),
                            trailing: LearningStatusPill(status: topic.status),
                            onTap: () =>
                                LearningTopicRoute(id: topic.id).push(context),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                  Text(
                    l10n.learningSuggestions,
                    style: AppTheme.sectionTitle(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.learningSuggestionsHint,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  if (candidates.isEmpty) ...[
                    Text(
                      l10n.learningNoSuggestions,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: context.colors.muted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () =>
                            const ProfileReviewRoute().push(context),
                        child: Text(l10n.learningOpenReview),
                      ),
                    ),
                  ] else
                    GroupCard(
                      children: [
                        for (final candidate in candidates)
                          ListTile(
                            key: Key('candidate-${candidate.topic}'),
                            leading: Icon(
                              candidate.important
                                  ? Icons.priority_high
                                  : Icons.school_outlined,
                              color: context.colors.onSignalSoft,
                            ),
                            title: Text(candidate.topic),
                            subtitle: Text(
                              l10n.learningDemand(candidate.demand),
                            ),
                            trailing: IconButton(
                              key: Key('add-${candidate.topic}'),
                              tooltip: l10n.learningAdd,
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () async {
                                final messenger = ScaffoldMessenger.of(context);
                                try {
                                  await ref
                                      .read(learningControllerProvider.notifier)
                                      .add(candidate);
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        l10n.learningAdded(candidate.topic),
                                      ),
                                    ),
                                  );
                                } catch (_) {
                                  messenger.showSnackBar(
                                    SnackBar(content: Text(l10n.saveError)),
                                  );
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}

/// Tarjeta de acceso al plan en la pestaña HV.
class LearningCard extends ConsumerWidget {
  const LearningCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topics = ref.watch(learningControllerProvider).value ?? const [];
    int count(LearningStatus status) =>
        topics.where((t) => t.status == status).length;
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        key: const Key('openLearning'),
        leading: const TileIcon(Icons.school_outlined),
        title: Text(
          l10n.learningTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          topics.isEmpty
              ? l10n.learningCardEmpty
              : l10n.learningCardSummary(
                  topics.length,
                  count(LearningStatus.learning),
                  count(LearningStatus.mastered),
                ),
        ),
        trailing: const Icon(Icons.chevron_right),
        minTileHeight: 64,
        onTap: () => const LearningRoute().push(context),
      ),
    );
  }
}
