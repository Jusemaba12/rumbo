import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/company_mark.dart';
import '../../../shared/widgets/group_card.dart';
import '../../../shared/widgets/pull_to_refresh.dart';
import '../../../shared/widgets/root_app_bar.dart';
import '../../learning/presentation/learning_controller.dart';
import '../../learning/presentation/learning_screen.dart';
import '../../search/presentation/search_controller.dart';
import '../../applications/data/resume_pdf.dart';
import '../../applications/presentation/prepare_application_screen.dart';
import '../data/resume_importer.dart';
import '../domain/profile.dart';
import '../domain/profile_completeness.dart';
import 'basics_form_screen.dart';
import 'profile_controller.dart';
import 'resume_review_controller.dart';
import 'resume_review_screen.dart';
import 'skill_sheet.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(profileControllerProvider);
    return Scaffold(
      appBar: rootAppBar(
        context,
        l10n.profileTitle,
        actions: [
          if (state.value case final data?
              when data.profile.fullName.isNotEmpty)
            BarButton(
              key: const Key('downloadResume'),
              icon: Icons.download_outlined,
              tooltip: l10n.downloadResume,
              onPressed: () => _downloadResume(context, ref, data),
            ),
        ],
      ),
      // Con datos (también mientras se actualizan al deslizar) se muestran.
      body: switch (state) {
        AsyncValue(:final value?) => _ProfileBody(data: value),
        AsyncError() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.loadError),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => ref.invalidate(profileControllerProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final profile = data.profile;
    final hasBasics = profile != const Profile();
    final monthFormat = DateFormat.yMMM(
      Localizations.localeOf(context).toLanguageTag(),
    );

    final experiences = [
      for (final experience in data.experiences)
        ListTile(
          title: Text(experience.role, style: theme.textTheme.titleSmall),
          subtitle: Text(
            '${experience.company} · '
            '${monthFormat.format(experience.startDate)} – '
            '${experience.endDate == null ? l10n.present : monthFormat.format(experience.endDate!)}',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => ExperienceEditRoute(id: experience.id).push(context),
        ),
    ];
    final education = [
      for (final education in data.education)
        ListTile(
          title: Text(
            education.degree.isEmpty ? education.institution : education.degree,
            style: theme.textTheme.titleSmall,
          ),
          subtitle: Text(
            [
              if (education.degree.isNotEmpty) education.institution,
              if (education.startDate != null || education.endDate != null)
                '${education.startDate == null ? '' : monthFormat.format(education.startDate!)} – '
                    '${education.endDate == null ? l10n.present : monthFormat.format(education.endDate!)}',
            ].join(' · '),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => EducationEditRoute(id: education.id).push(context),
        ),
    ];
    final projects = [
      for (final project in data.projects)
        ListTile(
          title: Text(project.name, style: theme.textTheme.titleSmall),
          subtitle: project.technologies.isEmpty
              ? null
              : Text(project.technologies.join(', ')),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => ProjectEditRoute(id: project.id).push(context),
        ),
    ];

    return PullToRefresh(
      providers: [
        profileControllerProvider.future,
        searchPreferencesProvider.future,
        learningControllerProvider.future,
      ],
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          _CompletenessCard(data: data),
          const SizedBox(height: 12),
          Consumer(
            builder: (context, ref, _) => ReviewScoreCard(
              key: const Key('openReview'),
              score: ref.watch(resumeReviewProvider)?.score ?? 0,
              onTap: () => const ProfileReviewRoute().push(context),
            ),
          ),
          const SizedBox(height: 12),
          const LearningCard(),
          _SectionHeader(
            title: l10n.sectionBasics,
            actionKey: const Key('editBasics'),
            actionIcon: Icons.edit_outlined,
            actionLabel: l10n.edit,
            onAction: () => const ProfileBasicsRoute().push(context),
          ),
          if (hasBasics)
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CompanyMark(company: profile.fullName, size: 52),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (profile.fullName.isNotEmpty)
                                Text(
                                  profile.fullName,
                                  style: theme.textTheme.titleLarge,
                                ),
                              if (profile.headline.isNotEmpty)
                                Text(profile.headline),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    for (final line in [
                      profile.location,
                      profile.email,
                      profile.phone,
                      ...profile.links.values,
                      if (profile.englishLevel case final level?)
                        l10n.profileEnglish(languageLevelLabel(l10n, level)),
                      if (profile.hasSalaryExpectation)
                        l10n.profileSalary(
                          salaryExpectationText(
                            profile,
                            Localizations.localeOf(context).toLanguageTag(),
                          ),
                        ),
                    ])
                      if (line.isNotEmpty) Text(line, style: muted),
                    if (profile.summary.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        profile.summary,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            )
          else
            _EmptyLine(l10n.basicsEmpty),
          _SectionHeader(
            title: l10n.sectionExperience,
            actionKey: const Key('addExperience'),
            actionIcon: Icons.add,
            actionLabel: l10n.add,
            onAction: () => const ExperienceNewRoute().push(context),
          ),
          if (experiences.isEmpty)
            _EmptyLine(l10n.experienceEmpty)
          else
            GroupCard(children: experiences),
          _SectionHeader(
            title: l10n.sectionEducation,
            actionKey: const Key('addEducation'),
            actionIcon: Icons.add,
            actionLabel: l10n.add,
            onAction: () => const EducationNewRoute().push(context),
          ),
          if (education.isEmpty)
            _EmptyLine(l10n.educationEmpty)
          else
            GroupCard(children: education),
          _SectionHeader(
            title: l10n.sectionProjects,
            actionKey: const Key('addProject'),
            actionIcon: Icons.add,
            actionLabel: l10n.add,
            onAction: () => const ProjectNewRoute().push(context),
          ),
          if (projects.isEmpty)
            _EmptyLine(l10n.projectsEmpty)
          else
            GroupCard(children: projects),
          _SectionHeader(
            title: l10n.sectionSkills,
            actionKey: const Key('addSkill'),
            actionIcon: Icons.add,
            actionLabel: l10n.add,
            onAction: () => showSkillSheet(context),
          ),
          if (data.skills.isEmpty)
            _EmptyLine(l10n.skillsEmpty)
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final skill in data.skills)
                  ActionChip(
                    label: Text(
                      skill.years == null
                          ? skill.name
                          : '${skill.name} · ${l10n.skillYears(skill.years!)}',
                    ),
                    onPressed: () => showSkillSheet(context, skill: skill),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _CompletenessCard extends ConsumerWidget {
  const _CompletenessCard({required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final canImport = ref.watch(resumeImporterProvider) != null;
    final percent = profileCompletenessPercent(data);
    final gaps = profileGaps(data);
    final hint = gaps.isEmpty
        ? l10n.profileCompleteHint
        : switch (gaps.first) {
            ProfileGap.name => l10n.gapName,
            ProfileGap.headline => l10n.gapHeadline,
            ProfileGap.experience => l10n.gapExperience,
            ProfileGap.achievements => l10n.gapAchievements,
            ProfileGap.skills => l10n.gapSkills(minSkillsForCompleteProfile),
            ProfileGap.summary => l10n.gapSummary,
            ProfileGap.link => l10n.gapLink,
          };
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$percent%',
                  style: AppTheme.numbers(theme.textTheme.headlineMedium)
                      .copyWith(color: theme.colorScheme.primary, height: 1),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Semantics(
                    label: l10n.profileCompleteness(percent),
                    excludeSemantics: true,
                    child: Text(
                      l10n.profileCompleteLabel,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: percent / 100,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
              backgroundColor: theme.colorScheme.surfaceContainerHigh,
            ),
            const SizedBox(height: 10),
            Text(hint),
            if (canImport) ...[
              const SizedBox(height: 14),
              OutlinedButton.icon(
                key: const Key('importResume'),
                onPressed: () => const ProfileImportRoute().push(context),
                icon: const Icon(Icons.upload_file),
                label: Text(l10n.importResume),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionKey,
    required this.actionIcon,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final Key actionKey;
  final IconData actionIcon;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 6),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(title, style: AppTheme.sectionTitle(context)),
            ),
          ),
          TextButton.icon(
            key: actionKey,
            onPressed: onAction,
            icon: Icon(actionIcon, size: 18),
            label: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}

class _EmptyLine extends StatelessWidget {
  const _EmptyLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Genera el PDF de la HV base y lo comparte (en la web, lo descarga).
Future<void> _downloadResume(
  BuildContext context,
  WidgetRef ref,
  ProfileData data,
) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  try {
    final fonts = await ref.read(resumeFontsProvider.future);
    final bytes = await buildResumePdf(
      draft: baseResumeDraft(data),
      profile: data.profile,
      education: data.education,
      regular: fonts?.$1,
      bold: fonts?.$2,
    );
    await ref.read(pdfSharerProvider)(bytes, resumeFileName(data.profile, ''));
  } catch (error) {
    debugPrint('base resume pdf: $error');
    messenger.showSnackBar(SnackBar(content: Text(l10n.pdfError)));
  }
}
