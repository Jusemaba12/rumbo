import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rumbo/features/company/application/use_cases/generate_company_brief_use_case.dart';
import 'package:rumbo/features/company/domain/entities/company_brief.dart';
import 'package:rumbo/features/company/presentation/providers/company_brief/company_brief_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';

class CompanyBriefScreen extends ConsumerStatefulWidget {
  const CompanyBriefScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<CompanyBriefScreen> createState() => _CompanyBriefScreenState();
}

class _CompanyBriefScreenState extends ConsumerState<CompanyBriefScreen> {
  bool _busy = false;
  bool _failed = false;

  Future<void> _generate() async {
    if (!ref.read(generateCompanyBriefUseCaseProvider).isAvailable) return;
    setState(() {
      _busy = true;
      _failed = false;
    });
    final Result<CompanyBrief> result = await ref
        .read(companyBriefControllerProvider(widget.jobId).notifier)
        .generate();
    if (!mounted) return;
    setState(() {
      _busy = false;
      _failed = !result.isOk;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final AsyncValue<CompanyBrief?> brief = ref.watch(
      companyBriefControllerProvider(widget.jobId),
    );
    final CompanyBrief? value = brief.value;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.briefTitle)),
      body: brief.isLoading && value == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              children: <Widget>[
                if (value == null)
                  Text(l10n.briefIntro)
                else
                  _Brief(brief: value),
                const SizedBox(height: 20),
                if (_failed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      l10n.briefError,
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                (value == null ? FilledButton.new : OutlinedButton.new)(
                  key: const Key('generateBrief'),
                  onPressed: _busy ? null : _generate,
                  child: Text(
                    _busy
                        ? l10n.briefGenerating
                        : value == null
                        ? l10n.briefGenerate
                        : l10n.briefRegenerate,
                  ),
                ),
              ],
            ),
    );
  }
}

class _Brief extends StatelessWidget {
  const _Brief({required this.brief});

  final CompanyBrief brief;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final DateTime? generated = brief.generatedAt;
    Widget list(String title, List<String> items) => items.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: AppTheme.sectionTitle(context)),
                for (final String item in items)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text('•  $item'),
                  ),
              ],
            ),
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(brief.summary, style: theme.textTheme.bodyLarge),
        list(l10n.briefTeam, brief.teamAndStack),
        list(l10n.briefCulture, brief.culture),
        list(l10n.briefQuestions, brief.questionsToAsk),
        list(l10n.briefRedFlags, brief.redFlags),
        if (brief.generalKnowledge.isNotEmpty) ...<Widget>[
          const SizedBox(height: 20),
          Text(l10n.briefGeneral, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 6),
          Text(brief.generalKnowledge),
        ],
        if (generated != null) ...<Widget>[
          const SizedBox(height: 16),
          Text(
            l10n.briefGeneratedAt(
              DateFormat.yMMMd(Localizations.localeOf(context).toLanguageTag())
                  .format(generated),
            ),
            style: theme.textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
