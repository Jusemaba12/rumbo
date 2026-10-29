import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../../../shared/widgets/section_label.dart';
import '../../jobs/presentation/jobs_controller.dart';
import '../data/achievement_rewriter.dart';
import '../data/resume_keywords.dart';
import '../data/review_history.dart';
import '../domain/keyword_analysis.dart';
import '../domain/profile.dart';
import '../domain/resume_review.dart';
import 'profile_controller.dart';
import 'resume_review_controller.dart';
import 'skill_sheet.dart';

/// Revisión de la HV base: reglas locales con nota por partes y palabras
/// clave de los cargos objetivo (estas con IA, solo cuando se piden).
class ResumeReviewScreen extends ConsumerStatefulWidget {
  const ResumeReviewScreen({super.key});

  @override
  ConsumerState<ResumeReviewScreen> createState() => _ResumeReviewScreenState();
}

class _ResumeReviewScreenState extends ConsumerState<ResumeReviewScreen> {
  /// Nota mostrada antes del último cambio, para avisar si sube o baja.
  int? _shownScore;
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    _shownScore = ref.read(resumeReviewProvider)?.score;
    // Al volver de «Corregir» el perfil se recarga solo: avisar del cambio.
    ref.listenManual(resumeReviewProvider, (_, next) {
      if (next != null && !_refreshing) _announce(next.score);
    });
  }

  void _announce(int score, {bool always = false}) {
    final previous = _shownScore;
    _shownScore = score;
    if (!mounted || previous == null || (previous == score && !always)) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            score > previous
                ? l10n.reviewScoreUp(previous, score)
                : score < previous
                ? l10n.reviewScoreDown(previous, score)
                : l10n.reviewScoreSame(score),
          ),
        ),
      );
  }

  /// Vuelve a leer el perfil del servidor y repite la revisión.
  Future<void> _refresh() async {
    setState(() => _refreshing = true);
    try {
      ref.invalidate(profileControllerProvider);
      await ref.read(profileControllerProvider.future);
      final review = ref.read(resumeReviewProvider);
      if (review != null) _announce(review.score, always: true);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).loadError)),
        );
      }
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final data = ref.watch(profileControllerProvider).value;
    final review = ref.watch(resumeReviewProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reviewTitle),
        actions: [
          IconButton(
            key: const Key('refreshReview'),
            tooltip: l10n.reviewRefresh,
            onPressed: _refreshing ? null : _refresh,
            icon: _refreshing
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
          ),
        ],
      ),
      body: data == null || review == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refresh,
              child: _ReviewBody(data: data, review: review),
            ),
    );
  }
}

String categoryLabel(AppLocalizations l10n, ReviewCategory category) =>
    switch (category) {
      ReviewCategory.contact => l10n.categoryContact,
      ReviewCategory.structure => l10n.categoryStructure,
      ReviewCategory.achievements => l10n.categoryAchievements,
      ReviewCategory.coherence => l10n.categoryCoherence,
      ReviewCategory.format => l10n.categoryFormat,
    };

class _ReviewBody extends ConsumerWidget {
  const _ReviewBody({required this.data, required this.review});

  final ProfileData data;
  final ResumeReview review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final history = ref.watch(reviewHistoryProvider).value ?? const [];
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      children: [
        ReviewScoreCard(score: review.score, history: history),
        const SizedBox(height: 24),
        SectionLabel(l10n.reviewCategoriesTitle),
        _CategoriesCard(review: review),
        const SizedBox(height: 24),
        if (review.issues.isEmpty)
          NoticeBanner(
            text: l10n.reviewAllGood,
            icon: Icons.check_circle_outline,
            tone: Tone.accent,
          )
        else
          for (final category in ReviewCategory.values)
            if (review.issuesIn(category) case final issues
                when issues.isNotEmpty) ...[
              SectionLabel(
                l10n.reviewCategoryIssues(
                  categoryLabel(l10n, category),
                  issues.length,
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    for (final (index, issue) in issues.indexed) ...[
                      if (index > 0) const Divider(indent: 16),
                      _IssueTile(issue: issue),
                    ],
                  ],
                ),
              ),
            ],
        if (ref.watch(resumeKeywordsSourceProvider) != null) ...[
          const SizedBox(height: 8),
          _KeywordsSection(data: data),
        ],
      ],
    );
  }
}

/// Puntos de cada categoría sobre su máximo, con una barra.
class _CategoriesCard extends StatelessWidget {
  const _CategoriesCard({required this.review});

  final ResumeReview review;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.colors;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
        child: Column(
          children: [
            for (final category in ReviewCategory.values)
              Padding(
                key: Key('category-${category.name}'),
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(categoryLabel(l10n, category))),
                        Text(
                          '${review.categories[category]}/${category.points}',
                          style: AppTheme.numbers(theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: review.categories[category]! / category.points,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                      color: _barColor(
                        colors,
                        review.categories[category]! / category.points,
                      ),
                      backgroundColor: theme.colorScheme.surfaceContainerHigh,
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

Color _barColor(RumboColors colors, double ratio) => ratio >= 0.8
    ? colors.accent
    : ratio >= 0.55
    ? colors.signal
    : colors.risk;

/// Nota grande con barra y su evolución, coloreada como la compatibilidad.
class ReviewScoreCard extends StatelessWidget {
  const ReviewScoreCard({
    super.key,
    required this.score,
    this.onTap,
    this.history = const [],
  });

  final int score;
  final VoidCallback? onTap;

  /// Notas de días anteriores; con dos o más se dibuja la evolución.
  final List<ScorePoint> history;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.colors;
    final tone = score >= 80
        ? Tone.accent
        : score >= 55
        ? Tone.signal
        : Tone.risk;
    final bar = _barColor(colors, score / 100);
    final (_, foreground) = colors.soft(tone);
    final showTrend = history.length >= 2;
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // La cifra cuenta hasta la nota nueva cuando cambia.
                  TweenAnimationBuilder<int>(
                    tween: IntTween(end: score),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    builder: (context, value, _) => Text(
                      '$value',
                      style: AppTheme.numbers(
                        TextStyle(fontSize: 40, height: 1, color: foreground),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          onTap == null
                              ? l10n.reviewScoreCaption
                              : l10n.reviewTitle,
                          style: theme.textTheme.titleSmall,
                        ),
                        if (onTap != null)
                          Text(
                            l10n.reviewCardBody,
                            style: theme.textTheme.bodySmall,
                          ),
                        const SizedBox(height: 8),
                        TweenAnimationBuilder<double>(
                          tween: Tween(end: score / 100),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOut,
                          builder: (context, value, _) =>
                              LinearProgressIndicator(
                                value: value,
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(4),
                                color: bar,
                                backgroundColor:
                                    theme.colorScheme.surfaceContainerHigh,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (onTap != null) ...[
                    const SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: colors.muted),
                  ],
                ],
              ),
              if (showTrend) ...[
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 32,
                        child: CustomPaint(
                          key: const Key('scoreTrend'),
                          painter: _TrendPainter(
                            [for (final point in history) point.score],
                            colors.accent,
                            colors.line,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n.reviewHistoryStart(history.first.score),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Línea de la evolución de la nota (0-100 de abajo arriba).
class _TrendPainter extends CustomPainter {
  _TrendPainter(this.scores, this.color, this.baseline);

  final List<int> scores;
  final Color color;
  final Color baseline;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      Paint()..color = baseline,
    );
    final low = scores.reduce((a, b) => a < b ? a : b) - 5;
    final high = scores.reduce((a, b) => a > b ? a : b) + 5;
    final span = (high - low).clamp(1, 100);
    Offset at(int index) => Offset(
      size.width * index / (scores.length - 1),
      size.height * (1 - (scores[index] - low) / span),
    );
    final path = Path()..moveTo(at(0).dx, at(0).dy);
    for (var i = 1; i < scores.length; i++) {
      path.lineTo(at(i).dx, at(i).dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(at(scores.length - 1), 3.5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_TrendPainter old) =>
      old.scores != scores || old.color != color;
}

class _IssueTile extends ConsumerWidget {
  const _IssueTile({required this.issue});

  final ReviewIssue issue;

  /// Problemas de logros que la IA puede proponer cómo reescribir.
  static const _improvable = {
    ReviewIssueKind.noAchievements,
    ReviewIssueKind.fewNumbers,
    ReviewIssueKind.weakStart,
    ReviewIssueKind.firstPerson,
    ReviewIssueKind.longBullets,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final improvable =
        _improvable.contains(issue.kind) &&
        ref.watch(achievementRewriterProvider) != null;
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final (background, foreground) = context.colors.soft(
      switch (issue.severity) {
        ReviewSeverity.high => Tone.risk,
        ReviewSeverity.medium => Tone.signal,
        ReviewSeverity.low => Tone.neutral,
      },
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  switch (issue.severity) {
                    ReviewSeverity.high => l10n.severityHigh,
                    ReviewSeverity.medium => l10n.severityMedium,
                    ReviewSeverity.low => l10n.severityLow,
                  },
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: foreground,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '−${issue.kind.penalty}',
                style: AppTheme.numbers(theme.textTheme.labelSmall)
                    .copyWith(color: context.colors.muted),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: Text(issueText(l10n, issue))),
              TextButton(
                key: Key(
                  'fix-${issue.kind.name}-${issue.experience?.id ?? ''}',
                ),
                onPressed: () => _fix(context, issue),
                child: Text(l10n.reviewFix),
              ),
            ],
          ),
          if (issue.experience?.id case final id? when improvable)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                key: Key('improve-${issue.kind.name}-$id'),
                onPressed: () => ImproveAchievementsRoute(id: id).push(context),
                icon: const Icon(Icons.auto_awesome_outlined, size: 18),
                label: Text(l10n.improveWithAi),
              ),
            ),
        ],
      ),
    );
  }
}

/// Lleva al formulario donde se corrige el problema.
void _fix(BuildContext context, ReviewIssue issue) {
  final experienceId = issue.experience?.id;
  switch (issue.kind) {
    case ReviewIssueKind.noName ||
        ReviewIssueKind.noEmail ||
        ReviewIssueKind.invalidEmail ||
        ReviewIssueKind.noPhone ||
        ReviewIssueKind.phoneNoCountryCode ||
        ReviewIssueKind.noLocation ||
        ReviewIssueKind.noLink ||
        ReviewIssueKind.invalidLink ||
        ReviewIssueKind.noHeadline ||
        ReviewIssueKind.noSummary ||
        ReviewIssueKind.shortSummary ||
        ReviewIssueKind.longSummary ||
        ReviewIssueKind.headlineNoRole ||
        ReviewIssueKind.summaryNoTech ||
        ReviewIssueKind.summaryNoYears:
      const ProfileBasicsRoute().push(context);
    case ReviewIssueKind.noExperience:
      const ExperienceNewRoute().push(context);
    case ReviewIssueKind.noAchievements ||
            ReviewIssueKind.fewNumbers ||
            ReviewIssueKind.weakStart ||
            ReviewIssueKind.firstPerson ||
            ReviewIssueKind.longBullets ||
            ReviewIssueKind.endBeforeStart ||
            ReviewIssueKind.futureDate ||
            ReviewIssueKind.dateGap
        when experienceId != null:
      ExperienceEditRoute(id: experienceId).push(context);
    case ReviewIssueKind.fewSkills:
      showSkillSheet(context);
    case ReviewIssueKind.noEducation:
      const EducationNewRoute().push(context);
    // Lo que afecta a varias partes se corrige desde la HV completa.
    case _:
      const ResumeRoute().go(context);
  }
}

String issueText(AppLocalizations l10n, ReviewIssue issue) {
  final role = issue.experience?.role ?? '';
  final company = issue.experience?.company ?? '';
  final count = issue.count;
  final detail = issue.detail ?? '';
  return switch (issue.kind) {
    ReviewIssueKind.noName => l10n.issueNoName,
    ReviewIssueKind.noEmail => l10n.issueNoEmail,
    ReviewIssueKind.invalidEmail => l10n.issueInvalidEmail,
    ReviewIssueKind.noPhone => l10n.issueNoPhone,
    ReviewIssueKind.phoneNoCountryCode => l10n.issuePhoneNoCountryCode,
    ReviewIssueKind.noLocation => l10n.issueNoLocation,
    ReviewIssueKind.noLink => l10n.issueNoLink,
    ReviewIssueKind.invalidLink => l10n.issueInvalidLink(count),
    ReviewIssueKind.noHeadline => l10n.issueNoHeadline,
    ReviewIssueKind.noSummary => l10n.issueNoSummary,
    ReviewIssueKind.shortSummary => l10n.issueShortSummary(count),
    ReviewIssueKind.longSummary => l10n.issueLongSummary(count),
    ReviewIssueKind.noExperience => l10n.issueNoExperience,
    ReviewIssueKind.noEducation => l10n.issueNoEducation,
    ReviewIssueKind.endBeforeStart => l10n.issueEndBeforeStart(role, company),
    ReviewIssueKind.futureDate => l10n.issueFutureDate(role, company),
    ReviewIssueKind.dateGap => l10n.issueDateGap(count, role, company),
    ReviewIssueKind.severalCurrent => l10n.issueSeveralCurrent(count),
    ReviewIssueKind.noAchievements => l10n.issueNoAchievements(role, company),
    ReviewIssueKind.fewNumbers => l10n.issueFewNumbers(role, company, count),
    ReviewIssueKind.weakStart => l10n.issueWeakStart(role, company, count),
    ReviewIssueKind.firstPerson => l10n.issueFirstPerson(role, company, count),
    ReviewIssueKind.duplicates => l10n.issueDuplicates(count),
    ReviewIssueKind.longBullets => l10n.issueLongBullets(role, company, count),
    ReviewIssueKind.buzzwords => l10n.issueBuzzwords(detail),
    ReviewIssueKind.fewSkills => l10n.issueFewSkills(count),
    ReviewIssueKind.techNotInSkills => l10n.issueTechNotInSkills(detail, count),
    ReviewIssueKind.headlineNoRole => l10n.issueHeadlineNoRole(detail),
    ReviewIssueKind.summaryNoTech => l10n.issueSummaryNoTech,
    ReviewIssueKind.summaryNoYears => l10n.issueSummaryNoYears,
    ReviewIssueKind.specialCharacters => l10n.issueSpecialCharacters(count),
    ReviewIssueKind.allCaps => l10n.issueAllCaps(count),
    ReviewIssueKind.mixedLanguages => l10n.issueMixedLanguages,
    ReviewIssueKind.tooLong => l10n.issueTooLong(count),
    ReviewIssueKind.tooShort => l10n.issueTooShort(count),
  };
}

/// Una palabra clave con dónde aparece en la HV y en cuántas ofertas.
typedef _KeywordRow = ({
  ResumeKeyword keyword,
  KeywordPresence presence,
  int offers,
});

class _KeywordsSection extends ConsumerWidget {
  const _KeywordsSection({required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.colors;
    final state = ref.watch(resumeKeywordsProvider);
    final result = state.value;
    final market = marketJobs(ref.watch(jobsControllerProvider).value ?? []);
    // Con menos de 3 ofertas la frecuencia no dice nada.
    final showMarket = market.length >= 3;
    final sections = ResumeSections(data);
    final rows = <_KeywordRow>[
      for (final keyword in result?.keywords ?? const <ResumeKeyword>[])
        () {
          final terms = keywordTerms(keyword.keyword, keyword.aliases);
          return (
            keyword: keyword,
            presence: sections.presenceOf(terms),
            offers: showMarket ? offersMentioning(market, terms) : 0,
          );
        }(),
    ];
    int byDemand(_KeywordRow a, _KeywordRow b) =>
        b.offers.compareTo(a.offers) != 0
        ? b.offers.compareTo(a.offers)
        : (b.keyword.important ? 1 : 0) - (a.keyword.important ? 1 : 0);
    final missing = rows.where((r) => !r.presence.found).toList()
      ..sort(byDemand);
    final onlySkills = rows.where((r) => r.presence.onlyInSkills).toList()
      ..sort(byDemand);
    final strong = rows
        .where((r) => r.presence.found && !r.presence.onlyInSkills)
        .toList();
    final load = ref.read(resumeKeywordsProvider.notifier).load;
    final locale = Localizations.localeOf(context).toLanguageTag();

    String label(_KeywordRow row) => showMarket && row.offers > 0
        ? '${row.keyword.keyword} · ${row.offers}'
        : row.keyword.keyword;

    Widget chips(List<_KeywordRow> list, Tone tone, {bool addable = false}) {
      final (background, foreground) = colors.soft(tone);
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final row in list)
            Tooltip(
              message: row.keyword.reason,
              child: addable
                  ? ActionChip(
                      key: Key('missing-${row.keyword.keyword}'),
                      avatar: Icon(
                        row.keyword.important ? Icons.priority_high : Icons.add,
                        size: 16,
                        color: foreground,
                      ),
                      label: Text(label(row)),
                      backgroundColor: background,
                      side: BorderSide.none,
                      onPressed: () => showSkillSheet(
                        context,
                        skill: Skill(name: row.keyword.keyword),
                      ),
                    )
                  : Chip(
                      key: Key('keyword-${row.keyword.keyword}'),
                      label: Text(label(row)),
                      backgroundColor: background,
                      side: BorderSide.none,
                    ),
            ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            l10n.keywordsTitle,
            style: AppTheme.sectionTitle(context),
          ),
        ),
        const SizedBox(height: 4),
        Text(l10n.keywordsHint, style: theme.textTheme.bodySmall),
        const SizedBox(height: 12),
        if (state.isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          )
        else if (state.error case final error?) ...[
          NoticeBanner(
            text: switch (error) {
              KeywordsException(reason: KeywordsFailure.noRoles) =>
                l10n.keywordsNoRoles,
              KeywordsException(reason: KeywordsFailure.dailyLimit) =>
                l10n.aiErrorDailyLimit,
              KeywordsException(reason: KeywordsFailure.busy) =>
                l10n.aiErrorBusy,
              KeywordsException(reason: KeywordsFailure.rateLimited) =>
                l10n.aiErrorRateLimited,
              _ => l10n.keywordsError,
            },
            icon: Icons.error_outline,
            tone: Tone.risk,
          ),
          const SizedBox(height: 8),
          OutlinedButton(onPressed: load, child: Text(l10n.retry)),
        ] else if (result == null)
          OutlinedButton.icon(
            key: const Key('loadKeywords'),
            onPressed: load,
            icon: const Icon(Icons.auto_awesome_outlined),
            label: Text(l10n.keywordsLoad),
          )
        else ...[
          if (showMarket) ...[
            Text(
              l10n.keywordsMarketHint(market.length),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
          ],
          if (missing.isNotEmpty) ...[
            SectionLabel(
              l10n.keywordsMissing(missing.length),
              color: colors.onSignalSoft,
            ),
            Text(l10n.keywordsMissingHint, style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            chips(missing, Tone.signal, addable: true),
            const SizedBox(height: 18),
          ],
          if (onlySkills.isNotEmpty) ...[
            SectionLabel(
              l10n.keywordsOnlySkills(onlySkills.length),
              color: colors.onInfoSoft,
            ),
            Text(l10n.keywordsOnlySkillsHint, style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            chips(onlySkills, Tone.info),
            const SizedBox(height: 18),
          ],
          if (strong.isNotEmpty) ...[
            SectionLabel(
              l10n.keywordsInExperience(strong.length),
              color: colors.onAccentSoft,
            ),
            chips(strong, Tone.accent),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              if (result.updatedAt case final updated?)
                Expanded(
                  child: Text(
                    l10n.keywordsUpdated(
                      DateFormat.yMMMd(locale).format(updated.toLocal()),
                    ),
                    style: theme.textTheme.bodySmall,
                  ),
                )
              else
                const Spacer(),
              TextButton.icon(
                key: const Key('reloadKeywords'),
                onPressed: () => load(force: true),
                icon: const Icon(Icons.refresh),
                label: Text(l10n.keywordsReload),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
