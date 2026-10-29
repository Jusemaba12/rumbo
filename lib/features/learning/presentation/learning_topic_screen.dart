import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../../../shared/widgets/segmented_tabs.dart';
import '../../profile/domain/profile.dart';
import '../../profile/presentation/form_helpers.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../profile/presentation/skill_sheet.dart';
import '../data/learning_repository.dart';
import '../domain/learning.dart';
import 'learning_controller.dart';
import 'learning_screen.dart';

/// Un tema del plan: estado, plan con IA y, al dominarlo, añadirlo a la HV.
class LearningTopicScreen extends ConsumerStatefulWidget {
  const LearningTopicScreen({super.key, required this.topicId});

  final String topicId;

  @override
  ConsumerState<LearningTopicScreen> createState() =>
      _LearningTopicScreenState();
}

class _LearningTopicScreenState extends ConsumerState<LearningTopicScreen> {
  bool _generating = false;
  Object? _error;

  Future<void> _generate() async {
    final planner = ref.read(learningPlannerProvider);
    if (planner == null) return;
    setState(() {
      _generating = true;
      _error = null;
    });
    try {
      final plan = await planner.generate(widget.topicId);
      ref
          .read(learningControllerProvider.notifier)
          .planGenerated(widget.topicId, plan);
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  Future<void> _run(Future<void> Function() action) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    try {
      await action();
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final topic = ref
        .watch(learningControllerProvider)
        .value
        ?.firstWhereOrNull((t) => t.id == widget.topicId);
    if (topic == null) {
      return Scaffold(appBar: AppBar());
    }
    final controller = ref.read(learningControllerProvider.notifier);
    final skills =
        ref.watch(profileControllerProvider).value?.skills ?? const <Skill>[];
    final inSkills = skills.any(
      (s) => s.name.trim().toLowerCase() == topic.topic.trim().toLowerCase(),
    );
    final plan = topic.plan;
    final canPlan = ref.watch(learningPlannerProvider) != null;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            key: const Key('deleteTopic'),
            tooltip: l10n.learningDelete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final navigator = Navigator.of(context);
              if (!await confirmDelete(context, topic.topic)) return;
              await _run(() => controller.delete(topic.id));
              navigator.pop();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: [
          Text(topic.topic, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            l10n.learningDemand(topic.demand),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.colors.muted,
            ),
          ),
          const SizedBox(height: 16),
          SegmentedTabs<LearningStatus>(
            segments: [
              for (final status in LearningStatus.values)
                (status, learningStatusLabel(l10n, status)),
            ],
            selected: topic.status,
            onChanged: (status) =>
                _run(() => controller.setStatus(topic.id, status)),
          ),
          if (topic.status == LearningStatus.mastered) ...[
            const SizedBox(height: 16),
            Card(
              key: const Key('masteredCard'),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.learningMasteredTitle,
                      style: AppTheme.sectionTitle(context),
                    ),
                    const SizedBox(height: 4),
                    Text(l10n.learningMasteredBody),
                    const SizedBox(height: 12),
                    if (inSkills)
                      Text(
                        l10n.learningAlreadySkill,
                        style: theme.textTheme.bodySmall,
                      )
                    else
                      FilledButton.icon(
                        key: const Key('addTopicSkill'),
                        onPressed: () => showSkillSheet(
                          context,
                          skill: Skill(name: topic.topic),
                        ),
                        icon: const Icon(Icons.add),
                        label: Text(l10n.learningAddSkill),
                      ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          if (_generating)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 12),
                    Text(l10n.learningGenerating),
                  ],
                ),
              ),
            )
          else if (plan == null) ...[
            if (_error != null) ...[
              NoticeBanner(
                text: switch (_error) {
                  LearningPlanException(
                    reason: LearningPlanFailure.dailyLimit,
                  ) =>
                    l10n.aiErrorDailyLimit,
                  LearningPlanException(reason: LearningPlanFailure.busy) =>
                    l10n.aiErrorBusy,
                  LearningPlanException(
                    reason: LearningPlanFailure.rateLimited,
                  ) =>
                    l10n.aiErrorRateLimited,
                  _ => l10n.saveError,
                },
                icon: Icons.error_outline,
                tone: Tone.risk,
              ),
              const SizedBox(height: 12),
            ],
            if (canPlan) ...[
              Text(l10n.learningPlanHint, style: theme.textTheme.bodySmall),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                key: const Key('generatePlan'),
                onPressed: _generate,
                icon: const Icon(Icons.auto_awesome_outlined),
                label: Text(l10n.learningGenerate),
              ),
            ],
          ] else
            _PlanView(plan: plan, onRegenerate: canPlan ? _generate : null),
        ],
      ),
    );
  }
}

class _PlanView extends StatelessWidget {
  const _PlanView({required this.plan, this.onRegenerate});

  final LearningPlan plan;
  final VoidCallback? onRegenerate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.colors;
    Widget title(String text) => Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(text, style: AppTheme.sectionTitle(context)),
    );
    return Column(
      key: const Key('learningPlan'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (plan.hours > 0)
          Text(
            l10n.learningHours(plan.hours),
            style: AppTheme.numbers(theme.textTheme.bodyMedium)
                .copyWith(color: colors.muted, fontWeight: FontWeight.w500),
          ),
        if (plan.why.isNotEmpty) ...[title(l10n.learningWhy), Text(plan.why)],
        if (plan.steps.isNotEmpty) ...[
          title(l10n.learningSteps),
          for (final (index, step) in plan.steps.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colors.accentSoft,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: AppTheme.numbers(theme.textTheme.labelMedium)
                          .copyWith(color: colors.onAccentSoft),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(step.title, style: theme.textTheme.titleSmall),
                        if (step.detail.isNotEmpty) Text(step.detail),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
        title(l10n.learningResources),
        if (plan.resources.isEmpty)
          Text(l10n.learningNoResources, style: theme.textTheme.bodySmall)
        else
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (final resource in plan.resources)
                  ListTile(
                    leading: Icon(switch (resource.kind) {
                      'course' => Icons.school_outlined,
                      'video' => Icons.play_circle_outline,
                      'article' => Icons.article_outlined,
                      _ => Icons.menu_book_outlined,
                    }),
                    title: Text(resource.title),
                    subtitle: Text(
                      Uri.tryParse(resource.url)?.host ?? resource.url,
                    ),
                    trailing: const Icon(Icons.open_in_new, size: 18),
                    onTap: () => launchUrl(
                      Uri.parse(resource.url),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
              ],
            ),
          ),
        if (plan.project.isNotEmpty) ...[
          title(l10n.learningProject),
          NoticeBanner(
            text: plan.project,
            icon: Icons.construction_outlined,
            tone: Tone.info,
          ),
        ],
        if (onRegenerate != null) ...[
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              key: const Key('regeneratePlan'),
              onPressed: onRegenerate,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.learningRegenerate),
            ),
          ),
        ],
      ],
    );
  }
}
