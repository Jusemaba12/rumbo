import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/failures/job_failures.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';

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
  final TextEditingController _text = TextEditingController();
  bool _analyzing = false;
  String? _error;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _paste() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    final String copied = data?.text?.trim() ?? '';
    if (copied.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.clipboardEmpty)));
      return;
    }
    setState(() => _text.text = copied);
  }

  Future<void> _complete() async {
    final AppLocalizations l10n = context.l10n;
    final String text = _text.text.trim();
    if (text.length < minJobDescriptionChars) {
      setState(() => _error = l10n.jobCompleteTooShort(minJobDescriptionChars));
      return;
    }
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final NavigatorState navigator = Navigator.of(context);
    FocusScope.of(context).unfocus();
    setState(() {
      _analyzing = true;
      _error = null;
    });
    final Result<SavedJob> result = await ref
        .read(jobsControllerProvider.notifier)
        .complete(jobId: widget.jobId, description: text);
    switch (result) {
      case Ok<SavedJob>(value: final SavedJob completed):
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.jobCompleted(completed.match?.score ?? 0)),
          ),
        );
        navigator.pop();
      case Err<SavedJob>(:final Failure failure):
        if (!mounted) return;
        setState(() {
          _analyzing = false;
          _error = failure is NoDescriptionFailure
              ? l10n.jobCompleteTooShort(minJobDescriptionChars)
              : failureMessage(
                  l10n: l10n,
                  failure: failure,
                  fallback: l10n.jobErrorOther,
                );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final Job? job = ref
        .watch(jobsControllerProvider)
        .value
        ?.firstWhereOrNull((SavedJob item) => item.job.id == widget.jobId)
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
                  children: <Widget>[
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
                children: <Widget>[
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
                  if (_error case final String error?) ...<Widget>[
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
