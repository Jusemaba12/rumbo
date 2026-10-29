import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../data/job_analyzer.dart';
import '../data/jobs_repository.dart';
import '../domain/job.dart';
import '../domain/shared_job.dart';
import 'job_widgets.dart';
import 'jobs_controller.dart';

/// Pegar enlace o descripción → analizar con IA → revisar → guardar.
class AddJobScreen extends ConsumerStatefulWidget {
  const AddJobScreen({super.key, this.shared});

  /// Texto compartido desde otra app (enlace, o título y enlace).
  final String? shared;

  @override
  ConsumerState<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends ConsumerState<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _url = TextEditingController();
  final _text = TextEditingController();
  bool _analyzing = false;
  bool _saving = false;
  SavedJob? _result;
  JobAnalysisFailure? _failure;

  @override
  void initState() {
    super.initState();
    if (widget.shared case final shared?) _fill(shared);
  }

  /// Reparte un texto compartido o copiado entre el enlace y la descripción.
  void _fill(String shared) {
    final (:url, :text) = splitSharedJob(shared);
    if (url != null) _url.text = url;
    if (text != null) _text.text = text;
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
    setState(() => _fill(copied));
  }

  @override
  void dispose() {
    _url.dispose();
    _text.dispose();
    super.dispose();
  }

  Future<void> _analyze() async {
    if (!_formKey.currentState!.validate()) return;
    final analyzer = ref.read(jobAnalyzerProvider);
    if (analyzer == null) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _analyzing = true;
      _failure = null;
    });
    try {
      final url = _url.text.trim();
      final text = _text.text.trim();
      final result = await analyzer.analyze(
        url: url.isEmpty ? null : url,
        text: text.isEmpty ? null : text,
      );
      if (mounted) setState(() => _result = result);
    } on JobAnalysisException catch (error) {
      if (mounted) setState(() => _failure = error.reason);
    } catch (error, stack) {
      debugPrint('analyze-job: $error\n$stack');
      if (mounted) setState(() => _failure = JobAnalysisFailure.other);
    } finally {
      if (mounted) setState(() => _analyzing = false);
    }
  }

  Future<void> _save(SavedJob result) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    setState(() => _saving = true);
    try {
      await ref.read(jobsControllerProvider.notifier).save(result);
      messenger.showSnackBar(SnackBar(content: Text(l10n.jobSaved)));
      navigator.pop();
    } on JobAlreadySavedException {
      messenger.showSnackBar(SnackBar(content: Text(l10n.jobDuplicate)));
      if (mounted) setState(() => _saving = false);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final result = _result;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.jobAddTitle)),
      body: SafeArea(
        child: _analyzing
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      l10n.jobAnalyzing,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(l10n.jobAnalyzingHint),
                  ],
                ),
              )
            : result != null
            ? _Review(
                result: result,
                saving: _saving,
                onSave: () => _save(result),
                onBack: () => setState(() => _result = null),
              )
            : _buildForm(l10n),
      ),
    );
  }

  Widget _buildForm(AppLocalizations l10n) {
    final theme = Theme.of(context);
    final failure = _failure;
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            key: const Key('jobUrl'),
            controller: _url,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: l10n.jobUrlLabel,
              suffixIcon: IconButton(
                key: const Key('pasteJob'),
                tooltip: l10n.pasteFromClipboard,
                icon: const Icon(Icons.content_paste),
                onPressed: _paste,
              ),
            ),
            validator: (value) {
              final url = value?.trim() ?? '';
              if (url.isEmpty) return null;
              final uri = Uri.tryParse(url);
              return uri != null && uri.hasScheme && uri.host.contains('.')
                  ? null
                  : l10n.urlInvalid;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: const Key('jobText'),
            controller: _text,
            minLines: 6,
            maxLines: 14,
            decoration: InputDecoration(
              labelText: l10n.jobDescriptionLabel,
              helperText: l10n.jobDescriptionHelper,
              helperMaxLines: 3,
              alignLabelWithHint: true,
            ),
            validator: (value) =>
                (value?.trim().isEmpty ?? true) && _url.text.trim().isEmpty
                ? l10n.jobFormEmpty
                : null,
          ),
          if (failure != null) ...[
            const SizedBox(height: 16),
            Text(switch (failure) {
              JobAnalysisFailure.noDescription => l10n.jobNoDescription,
              JobAnalysisFailure.dailyLimit => l10n.aiErrorDailyLimit,
              JobAnalysisFailure.rateLimited => l10n.aiErrorRateLimited,
              JobAnalysisFailure.busy => l10n.aiErrorBusy,
              JobAnalysisFailure.other => l10n.jobErrorOther,
            }, style: TextStyle(color: theme.colorScheme.error)),
          ],
          const SizedBox(height: 24),
          FilledButton(onPressed: _analyze, child: Text(l10n.jobAnalyze)),
        ],
      ),
    );
  }
}

class _Review extends StatelessWidget {
  const _Review({
    required this.result,
    required this.saving,
    required this.onSave,
    required this.onBack,
  });

  final SavedJob result;
  final bool saving;
  final VoidCallback onSave;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final match = result.match;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              JobHeader(job: result.job),
              if (match != null) ...[
                const SizedBox(height: 24),
                JobMatchSection(match: match),
              ],
              if (result.job.requirements.isNotEmpty) ...[
                const SizedBox(height: 24),
                JobRequirements(requirements: result.job.requirements),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: saving ? null : onSave,
                child: Text(l10n.jobSave),
              ),
              TextButton(
                onPressed: saving ? null : onBack,
                child: Text(l10n.jobAnalyzeAnother),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
