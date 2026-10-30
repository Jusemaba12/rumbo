import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/jobs/application/use_cases/analyze_job_use_case.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/failures/job_failures.dart';
import 'package:rumbo/features/jobs/domain/services/shared_job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';

/// Pegar enlace o descripción → analizar con IA → revisar → guardar.
class AddJobScreen extends ConsumerStatefulWidget {
  const AddJobScreen({super.key, this.shared});

  /// Texto compartido desde otra app (enlace, o título y enlace).
  final String? shared;

  @override
  ConsumerState<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends ConsumerState<AddJobScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _url = TextEditingController();
  final TextEditingController _text = TextEditingController();
  bool _analyzing = false;
  bool _saving = false;
  SavedJob? _result;
  Failure? _failure;

  @override
  void initState() {
    super.initState();
    if (widget.shared case final String shared?) _fill(shared);
  }

  /// Reparte un texto compartido o copiado entre el enlace y la descripción.
  void _fill(String shared) {
    final (:String? url, :String? text) = splitSharedJob(shared);
    if (url != null) _url.text = url;
    if (text != null) _text.text = text;
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
    final AnalyzeJobUseCase analyzeJob = ref.read(analyzeJobUseCaseProvider);
    if (!analyzeJob.isAvailable) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _analyzing = true;
      _failure = null;
    });
    final Result<SavedJob> result = await analyzeJob(
      url: _url.text,
      text: _text.text,
    );
    if (!mounted) return;
    setState(() {
      _analyzing = false;
      _result = result.valueOrNull;
      _failure = result.failureOrNull;
    });
  }

  Future<void> _save(SavedJob result) async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final NavigatorState navigator = Navigator.of(context);
    setState(() => _saving = true);
    final Result<void> saved = await ref
        .read(jobsControllerProvider.notifier)
        .save(result);
    final bool done = showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: saved,
      success: l10n.jobSaved,
      fallback: saved.failureOrNull is DuplicateFailure
          ? l10n.jobDuplicate
          : l10n.saveError,
    );
    if (done) {
      navigator.pop();
    } else if (mounted) {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final SavedJob? result = _result;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.jobAddTitle)),
      body: SafeArea(
        child: _analyzing
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
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
    final ThemeData theme = Theme.of(context);
    final Failure? failure = _failure;
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
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
            validator: (String? value) {
              final String url = value?.trim() ?? '';
              if (url.isEmpty) return null;
              final Uri? uri = Uri.tryParse(url);
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
            validator: (String? value) =>
                (value?.trim().isEmpty ?? true) && _url.text.trim().isEmpty
                ? l10n.jobFormEmpty
                : null,
          ),
          if (failure != null) ...<Widget>[
            const SizedBox(height: 16),
            Text(
              failure is NoDescriptionFailure
                  ? l10n.jobNoDescription
                  : failureMessage(
                      l10n: l10n,
                      failure: failure,
                      fallback: l10n.jobErrorOther,
                    ),
              style: TextStyle(color: theme.colorScheme.error),
            ),
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
    final AppLocalizations l10n = context.l10n;
    final JobMatch? match = result.match;
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              JobHeader(job: result.job),
              if (match != null) ...<Widget>[
                const SizedBox(height: 24),
                JobMatchSection(match: match),
              ],
              if (result.job.requirements.isNotEmpty) ...<Widget>[
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
            children: <Widget>[
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
