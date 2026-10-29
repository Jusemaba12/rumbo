import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../data/job_analyzer.dart';
import '../domain/job.dart';
import 'job_widgets.dart';
import 'jobs_controller.dart';

/// Pegar la descripción completa de una oferta que llegó incompleta (alertas
/// de LinkedIn, sugerencias cortas) para analizarla y recalcular la
/// compatibilidad. Conserva cargo, empresa, enlace y proceso.
class CompleteJobScreen extends ConsumerStatefulWidget {
  const CompleteJobScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<CompleteJobScreen> createState() => _CompleteJobScreenState();
}

class _CompleteJobScreenState extends ConsumerState<CompleteJobScreen> {
  final _text = TextEditingController();
  bool _analyzing = false;
  String? _error;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _paste() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final copied = data?.text?.trim() ?? '';
    if (copied.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.clipboardEmpty)));
      return;
    }
    setState(() => _text.text = copied);
  }

  Future<void> _complete() async {
    final l10n = AppLocalizations.of(context);
    final text = _text.text.trim();
    if (text.length < minJobDescriptionChars) {
      setState(() => _error = l10n.jobCompleteTooShort(minJobDescriptionChars));
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    FocusScope.of(context).unfocus();
    setState(() {
      _analyzing = true;
      _error = null;
    });
    try {
      final completed = await ref
          .read(jobsControllerProvider.notifier)
          .complete(widget.jobId, text);
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.jobCompleted(completed.match?.score ?? 0))),
      );
      navigator.pop();
    } on JobAnalysisException catch (error) {
      if (!mounted) return;
      setState(() {
        _analyzing = false;
        _error = switch (error.reason) {
          JobAnalysisFailure.noDescription => l10n.jobCompleteTooShort(
            minJobDescriptionChars,
          ),
          JobAnalysisFailure.dailyLimit => l10n.aiErrorDailyLimit,
          JobAnalysisFailure.rateLimited => l10n.aiErrorRateLimited,
          JobAnalysisFailure.busy => l10n.aiErrorBusy,
          JobAnalysisFailure.other => l10n.jobErrorOther,
        };
      });
    } catch (error) {
      debugPrint('complete job: $error');
      if (!mounted) return;
      setState(() {
        _analyzing = false;
        _error = l10n.saveError;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final job = ref
        .watch(jobsControllerProvider)
        .value
        ?.firstWhereOrNull((item) => item.job.id == widget.jobId)
        ?.job;
    if (job == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.jobNotFound)),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.jobCompleteTitle)),
      body: SafeArea(
        child: _analyzing
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(l10n.jobAnalyzing, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(l10n.jobAnalyzingHint),
                  ],
                ),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                children: [
                  Text(jobTitle(l10n, job), style: theme.textTheme.titleMedium),
                  Text(
                    job.company,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.colors.muted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(l10n.jobCompleteHint, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 16),
                  TextField(
                    key: const Key('completeText'),
                    controller: _text,
                    minLines: 8,
                    maxLines: 16,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.jobCompleteLabel,
                      alignLabelWithHint: true,
                      suffixIcon: IconButton(
                        key: const Key('pasteDescription'),
                        tooltip: l10n.pasteFromClipboard,
                        icon: const Icon(Icons.content_paste),
                        onPressed: _paste,
                      ),
                    ),
                  ),
                  if (_error case final error?) ...[
                    const SizedBox(height: 12),
                    NoticeBanner(
                      text: error,
                      icon: Icons.error_outline,
                      tone: Tone.risk,
                    ),
                  ],
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    key: const Key('completeJob'),
                    onPressed: _complete,
                    icon: const Icon(Icons.auto_awesome_outlined),
                    label: Text(l10n.jobCompleteAction),
                  ),
                ],
              ),
      ),
    );
  }
}
