import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/learning/application/use_cases/generate_learning_plan_use_case.dart';
import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/learning/presentation/providers/learning/learning_provider.dart';
import 'package:rumbo/features/learning/presentation/screens/learning_screen.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/features/profile/presentation/widgets/skill_sheet.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';
import 'package:rumbo/shared/presentation/widgets/segmented_tabs.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Failure? _failure;

  Future<void> _generate() async {
    final GenerateLearningPlanUseCase generatePlan = ref.read(
      generateLearningPlanUseCaseProvider,
    );
    if (!generatePlan.isAvailable) return;
    setState(() {
      _generating = true;
      _failure = null;
    });
    final Result<LearningPlan> result = await generatePlan(widget.topicId);
    if (result case Ok<LearningPlan>(:final LearningPlan value)) {
      ref
          .read(learningControllerProvider.notifier)
          .planGenerated(id: widget.topicId, plan: value);
    }
    if (!mounted) return;
    setState(() {
      _generating = false;
      _failure = result.failureOrNull;
    });
  }

  Future<Result<void>> _run(Future<Result<void>> Function() action) async {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final AppLocalizations l10n = context.l10n;
    final Result<void> result = await action();
    showResultSnackBar(messenger: messenger, l10n: l10n, result: result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final LearningTopic? topic = ref
        .watch(learningControllerProvider)
        .value
        ?.firstWhereOrNull((LearningTopic t) => t.id == widget.topicId);
    if (topic == null) {
      return Scaffold(appBar: AppBar());
    }
    final LearningController controller = ref.read(
      learningControllerProvider.notifier,
    );
    final List<Skill> skills =
        ref.watch(profileControllerProvider).value?.skills ?? const <Skill>[];
    final bool inSkills = skills.any(
      (Skill s) =>
          s.name.trim().toLowerCase() == topic.topic.trim().toLowerCase(),
    );
    final LearningPlan? plan = topic.plan;
    final bool canPlan = ref
        .watch(generateLearningPlanUseCaseProvider)
        .isAvailable;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            key: const Key('deleteTopic'),
            tooltip: l10n.learningDelete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final NavigatorState navigator = Navigator.of(context);
              if (!await confirmDelete(context, topic.topic)) return;
              final Result<void> deleted = await _run(
                () => controller.delete(topic.id),
              );
              if (deleted.isOk) navigator.pop();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: <Widget>[
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
            segments: <(LearningStatus, String)>[
              for (final LearningStatus status in LearningStatus.values)
                (status, learningStatusLabel(l10n, status)),
            ],
            selected: topic.status,
            onChanged: (LearningStatus status) =>
                _run(() => controller.setStatus(id: topic.id, status: status)),
          ),
          if (topic.status == LearningStatus.mastered) ...<Widget>[
            const SizedBox(height: 16),
            Card(
              key: const Key('masteredCard'),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                  children: <Widget>[
                    const CircularProgressIndicator(),
                    const SizedBox(height: 12),
                    Text(l10n.learningGenerating),
                  ],
                ),
              ),
            )
          else if (plan == null) ...<Widget>[
            if (_failure case final Failure failure?) ...<Widget>[
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
            ],
            if (canPlan) ...<Widget>[
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
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final RumboColors colors = context.colors;
    Widget title(String text) => Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(text, style: AppTheme.sectionTitle(context)),
    );
    return Column(
      key: const Key('learningPlan'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (plan.hours > 0)
          Text(
            l10n.learningHours(plan.hours),
            style: AppTheme.numbers(theme.textTheme.bodyMedium)
                .copyWith(color: colors.muted, fontWeight: FontWeight.w500),
          ),
        if (plan.why.isNotEmpty) ...<Widget>[
          title(l10n.learningWhy),
          Text(plan.why),
        ],
        if (plan.steps.isNotEmpty) ...<Widget>[
          title(l10n.learningSteps),
          for (final (int index, ({String detail, String title}) step)
              in plan.steps.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                      children: <Widget>[
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
              children: <Widget>[
                for (final ({String kind, String title, String url}) resource
                    in plan.resources)
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
        if (plan.project.isNotEmpty) ...<Widget>[
          title(l10n.learningProject),
          NoticeBanner(
            text: plan.project,
            icon: Icons.construction_outlined,
            tone: Tone.info,
          ),
        ],
        if (onRegenerate != null) ...<Widget>[
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
