import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/company_mark.dart';
import '../domain/job.dart';

String workModeLabel(AppLocalizations l10n, WorkMode mode) => switch (mode) {
  WorkMode.remote => l10n.workModeRemote,
  WorkMode.hybrid => l10n.workModeHybrid,
  WorkMode.onsite => l10n.workModeOnsite,
};

/// «USD 4.000 – 5.500», o nulo si la oferta no indica salario.
String? formatSalary(BuildContext context, Job job) {
  final min = job.salaryMin;
  final max = job.salaryMax;
  if (min == null && max == null) return null;
  final format = NumberFormat.decimalPattern(
    Localizations.localeOf(context).toLanguageTag(),
  );
  final range = min != null && max != null && min != max
      ? '${format.format(min)} – ${format.format(max)}'
      : format.format(min ?? max);
  final currency = job.salaryCurrency;
  return currency == null ? range : '$currency $range';
}

/// Empresa · ubicación · modalidad, sin los datos que falten.
String jobSubtitle(BuildContext context, Job job) {
  final l10n = AppLocalizations.of(context);
  final mode = job.workMode;
  return [
    job.company.isEmpty ? l10n.jobUnknownCompany : job.company,
    // «Remote» como ubicación repite la modalidad.
    if (job.location.isNotEmpty &&
        !(mode == WorkMode.remote &&
            const {
              'remote',
              'remoto',
            }.contains(job.location.trim().toLowerCase())))
      job.location,
    if (mode != null) workModeLabel(l10n, mode),
  ].join(' · ');
}

String jobTitle(AppLocalizations l10n, Job job) =>
    job.title.isEmpty ? l10n.jobUntitled : job.title;

/// Nota de compatibilidad: cifra y nivel sobre un cuadro del color del nivel.
class ScoreBadge extends StatelessWidget {
  const ScoreBadge({super.key, required this.score, this.size = 52});

  final int score;
  final double size;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (background, foreground) = context.colors.soft(matchTone(score));
    final showLevel = size >= 48;
    return Semantics(
      label: l10n.matchScoreSemantics(score),
      excludeSemantics: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(size * 0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$score',
              style: AppTheme.numbers(
                TextStyle(color: foreground, fontSize: size * 0.38, height: 1),
              ),
            ),
            if (showLevel) ...[
              const SizedBox(height: 3),
              Text(
                matchLevelLabel(l10n, score).toUpperCase(),
                style: TextStyle(
                  fontFamily: AppTheme.monoFont,
                  fontWeight: FontWeight.w500,
                  fontSize: size * 0.17,
                  letterSpacing: 0.5,
                  height: 1,
                  color: foreground,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Nivel de compatibilidad en palabras («Media»).
String matchLevelLabel(AppLocalizations l10n, int score) =>
    switch (matchLevel(score)) {
      MatchLevel.high => l10n.matchLevelHigh,
      MatchLevel.medium => l10n.matchLevelMedium,
      MatchLevel.low => l10n.matchLevelLow,
    };

Tone matchTone(int score) => switch (matchLevel(score)) {
  MatchLevel.high => Tone.accent,
  MatchLevel.medium => Tone.signal,
  MatchLevel.low => Tone.risk,
};

/// Tarjeta de compatibilidad: nota grande, barra de 10 tramos, explicación
/// y cuadros con lo que cumples y lo que te falta.
class JobMatchSection extends StatelessWidget {
  const JobMatchSection({super.key, required this.match});

  final JobMatch match;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.colors;
    final tone = matchTone(match.score);
    final (_, foreground) = colors.soft(tone);
    final barColor = switch (tone) {
      Tone.accent => colors.accent,
      Tone.risk => colors.risk,
      _ => colors.signal,
    };
    final filled = (match.score / 10).round();
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Semantics(
                  label: l10n.matchScoreSemantics(match.score),
                  excludeSemantics: true,
                  child: Text(
                    '${match.score}',
                    style: AppTheme.numbers(
                      TextStyle(fontSize: 44, height: 1, color: foreground),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.matchTitle, style: theme.textTheme.bodySmall),
                      Text(
                        matchLevelLabel(l10n, match.score),
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      ExcludeSemantics(
                        child: Row(
                          children: [
                            for (var i = 0; i < 10; i++) ...[
                              if (i > 0) const SizedBox(width: 3),
                              Expanded(
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: i < filled
                                        ? barColor
                                        : colors.surfaceMuted,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (match.explanation.isNotEmpty) ...[
              const SizedBox(height: 14),
              Text(match.explanation),
            ],
            if (match.met.isNotEmpty) ...[
              const SizedBox(height: 14),
              _MatchList(
                title: l10n.matchMet,
                items: match.met,
                tone: Tone.accent,
                icon: Icons.check_circle_outline,
              ),
            ],
            if (match.missing.isNotEmpty) ...[
              const SizedBox(height: 10),
              _MatchList(
                title: l10n.matchMissing,
                items: match.missing,
                tone: Tone.signal,
                icon: Icons.add_circle_outline,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MatchList extends StatelessWidget {
  const _MatchList({
    required this.title,
    required this.items,
    required this.tone,
    required this.icon,
  });

  final String title;
  final List<String> items;
  final Tone tone;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = context.colors.soft(tone);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              '$title · ${items.length}',
              style: AppTheme.overline(context, color: foreground),
            ),
          ),
          const SizedBox(height: 8),
          for (final text in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(icon, size: 16, color: foreground),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(text)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Cabecera de la oferta: iniciales, cargo, empresa, ubicación, modalidad y
/// salario.
class JobHeader extends StatelessWidget {
  const JobHeader({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.colors;
    final salary = formatSalary(context, job);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompanyMark(company: job.company, size: 48),
        const SizedBox(height: 12),
        Text(jobTitle(l10n, job), style: theme.textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(
          jobSubtitle(context, job),
          style: theme.textTheme.bodyLarge?.copyWith(color: colors.muted),
        ),
        if (salary != null) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.line),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              salary,
              style: AppTheme.numbers(theme.textTheme.bodySmall)
                  .copyWith(fontWeight: FontWeight.w500, color: colors.text),
            ),
          ),
        ],
      ],
    );
  }
}

/// Lista de requisitos con viñetas.
class JobRequirements extends StatelessWidget {
  const JobRequirements({super.key, required this.requirements});

  final List<String> requirements;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.jobRequirements, style: AppTheme.sectionTitle(context)),
        const SizedBox(height: 8),
        for (final requirement in requirements)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text('•  $requirement'),
          ),
      ],
    );
  }
}
