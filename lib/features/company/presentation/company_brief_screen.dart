import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/company_brief_repository.dart';
import '../domain/company_brief.dart';

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
    final repository = ref.read(companyBriefRepositoryProvider);
    if (repository == null) return;
    setState(() {
      _busy = true;
      _failed = false;
    });
    try {
      await repository.generate(widget.jobId);
      ref.invalidate(companyBriefProvider(widget.jobId));
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final brief = ref.watch(companyBriefProvider(widget.jobId));
    final value = brief.value;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.briefTitle)),
      body: brief.isLoading && value == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              children: [
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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final generated = brief.generatedAt;
    Widget list(String title, List<String> items) => items.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.sectionTitle(context)),
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text('•  $item'),
                  ),
              ],
            ),
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(brief.summary, style: theme.textTheme.bodyLarge),
        list(l10n.briefTeam, brief.teamAndStack),
        list(l10n.briefCulture, brief.culture),
        list(l10n.briefQuestions, brief.questionsToAsk),
        list(l10n.briefRedFlags, brief.redFlags),
        if (brief.generalKnowledge.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(l10n.briefGeneral, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 6),
          Text(brief.generalKnowledge),
        ],
        if (generated != null) ...[
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
