import 'package:flutter/material.dart';
import 'package:rumbo/features/applications/domain/services/ats_check.dart';
import 'package:rumbo/features/applications/domain/services/keyword_coverage.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';

String atsCheckLabel(AppLocalizations l10n, AtsCheck check) =>
    switch (check.kind) {
      AtsCheckKind.name => l10n.atsName,
      AtsCheckKind.email => l10n.atsEmail,
      AtsCheckKind.phone => l10n.atsPhone,
      AtsCheckKind.link => l10n.atsLink,
      AtsCheckKind.location => l10n.atsLocation,
      AtsCheckKind.sections => l10n.atsSections,
      AtsCheckKind.experiences => l10n.atsExperiences,
      AtsCheckKind.dates => l10n.atsDates,
      AtsCheckKind.skills => l10n.atsSkills,
      AtsCheckKind.characters => l10n.atsCharacters,
      AtsCheckKind.completeness => l10n.atsCompleteness(check.detail),
      AtsCheckKind.pages => l10n.atsPages(check.detail),
    };

/// Resultado de leer el PDF como un ATS: qué reconoce y el texto extraído.
class AtsResultSheet extends StatelessWidget {
  const AtsResultSheet({super.key, required this.checks, required this.text});

  final List<AtsCheck> checks;
  final String text;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final RumboColors colors = context.colors;
    final int passed = checks.where((AtsCheck c) => c.passed).length;
    final bool allGood = passed == checks.length;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: <Widget>[
          Text(l10n.atsTestTitle, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 4),
          Text(
            l10n.atsTestSummary(passed, checks.length),
            key: const Key('atsSummary'),
            style: theme.textTheme.titleSmall?.copyWith(
              color: allGood ? colors.accent : colors.onSignalSoft,
            ),
          ),
          const SizedBox(height: 12),
          for (final AtsCheck check in checks)
            ListTile(
              key: Key('ats-${check.kind.name}'),
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                check.passed ? Icons.check_circle : Icons.error_outline,
                color: check.passed ? colors.accent : colors.risk,
              ),
              title: Text(atsCheckLabel(l10n, check)),
              subtitle:
                  !check.passed &&
                      check.detail.isNotEmpty &&
                      check.kind != AtsCheckKind.completeness &&
                      check.kind != AtsCheckKind.pages
                  ? Text(l10n.atsMissing(check.detail))
                  : null,
            ),
          const SizedBox(height: 8),
          Theme(
            data: theme.copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(l10n.atsExtractedText),
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surfaceMuted,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: SelectableText(
                    text,
                    style: TextStyle(
                      fontFamily: AppTheme.monoFont,
                      fontSize: 12,
                      color: colors.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Cobertura de las palabras clave de la oferta: HV base frente a adaptada.
class CoverageCard extends StatelessWidget {
  const CoverageCard({super.key, required this.coverage});

  final KeywordCoverage coverage;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final RumboColors colors = context.colors;
    Widget row(String label, int percent, Color color, Key key) => Padding(
      key: key,
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(label)),
              Text(
                '$percent %',
                style: AppTheme.numbers(theme.textTheme.bodyMedium),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percent / 100,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
            color: color,
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
          ),
        ],
      ),
    );
    final List<String> missing = coverage.missing;
    return Card(
      key: const Key('coverageCard'),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.coverageTitle, style: AppTheme.sectionTitle(context)),
            const SizedBox(height: 2),
            Text(
              l10n.coverageHint(coverage.keywords.length),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 14),
            row(
              l10n.coverageBase,
              coverage.basePercent,
              colors.muted,
              const Key('coverageBase'),
            ),
            row(
              l10n.coverageTailored,
              coverage.tailoredPercent,
              colors.accent,
              const Key('coverageTailored'),
            ),
            if (missing.isNotEmpty) ...<Widget>[
              const SizedBox(height: 4),
              Text(
                l10n.coverageMissing(missing.take(6).join(', ')),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSignalSoft,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
