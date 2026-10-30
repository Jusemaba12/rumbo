import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/presentation/providers/learning/learning_provider.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/features/profile/presentation/providers/resume_keywords/resume_keywords_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/group_card.dart';
import 'package:rumbo/shared/presentation/widgets/pull_to_refresh.dart';
import 'package:rumbo/shared/presentation/widgets/section_label.dart';

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
    final (Color background, Color foreground) = context.colors.soft(
      learningStatusTone(status),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        learningStatusLabel(context.l10n, status),
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
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final List<LearningTopic>? topics = ref
        .watch(learningControllerProvider)
        .value;
    final List<LearningCandidate> candidates = ref.watch(
      learningCandidatesProvider,
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.learningTitle)),
      body: topics == null
          ? const Center(child: CircularProgressIndicator())
          : PullToRefresh(
              providers: <Refreshable<Future<Object?>>>[
                learningControllerProvider.future,
                profileControllerProvider.future,
                jobsControllerProvider.future,
                resumeKeywordsProvider.future,
              ],
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                children: <Widget>[
                  if (topics.isNotEmpty) ...<Widget>[
                    SectionLabel(l10n.learningMine),
                    GroupCard(
                      children: <Widget>[
                        for (final LearningTopic topic in topics)
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
                  if (candidates.isEmpty) ...<Widget>[
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
                      children: <Widget>[
                        for (final LearningCandidate candidate in candidates)
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
                                final ScaffoldMessengerState messenger =
                                    ScaffoldMessenger.of(context);
                                showResultSnackBar(
                                  messenger: messenger,
                                  l10n: l10n,
                                  result: await ref
                                      .read(learningControllerProvider.notifier)
                                      .add(candidate),
                                  success: l10n.learningAdded(candidate.topic),
                                );
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
    final AppLocalizations l10n = context.l10n;
    final List<LearningTopic> topics =
        ref.watch(learningControllerProvider).value ?? const <LearningTopic>[];
    int count(LearningStatus status) =>
        topics.where((LearningTopic t) => t.status == status).length;
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
