import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rumbo/features/applications/application/use_cases/get_latest_resume_version_use_case.dart';
import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/infrastructure/services/pdf_services.dart';
import 'package:rumbo/features/applications/infrastructure/services/resume_pdf.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/email/application/use_cases/draft_email_use_case.dart';
import 'package:rumbo/features/email/domain/entities/email_draft.dart';
import 'package:rumbo/features/email/domain/services/mailto.dart';
import 'package:rumbo/features/email/infrastructure/services/mail_services.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';
import 'package:rumbo/shared/utils/log.dart';

/// Postular a una oferta por correo: borrador con IA (asunto que pide la
/// publicación, presentación y expectativa salarial) y la HV adaptada en PDF
/// para adjuntar. Rumbo no envía nada: se abre el correo del usuario.
class ApplyEmailScreen extends ConsumerStatefulWidget {
  const ApplyEmailScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<ApplyEmailScreen> createState() => _ApplyEmailScreenState();
}

class _ApplyEmailScreenState extends ConsumerState<ApplyEmailScreen> {
  final TextEditingController _to = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _body = TextEditingController();
  ApplicationDraft? _resume;
  bool _loading = true;
  bool _busy = false;
  bool _opened = false;
  bool _applied = false;
  Failure? _failure;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _to.dispose();
    _subject.dispose();
    _body.dispose();
    super.dispose();
  }

  Job? get _job => ref
      .read(jobsControllerProvider)
      .value
      ?.firstWhereOrNull((SavedJob item) => item.job.id == widget.jobId)
      ?.job;

  /// Busca la HV adaptada; si la hay, pide el borrador a la IA.
  Future<void> _load() async {
    setState(() {
      _loading = true;
      _failure = null;
    });
    final Result<ApplicationDraft?> result = await ref.read(
      getLatestResumeVersionUseCaseProvider,
    )(widget.jobId);
    if (!mounted) return;
    switch (result) {
      case Ok<ApplicationDraft?>(value: final ApplicationDraft? resume):
        setState(() => _resume = resume);
        if (resume != null) await _draft();
      case Err<ApplicationDraft?>(:final Failure failure):
        setState(() => _failure = failure);
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _draft() async {
    final DraftEmailUseCase draftEmail = ref.read(draftEmailUseCaseProvider);
    if (!draftEmail.isAvailable) return;
    setState(() {
      _loading = true;
      _failure = null;
    });
    final Result<EmailDraft> result = await draftEmail.forJob(widget.jobId);
    if (!mounted) return;
    if (result case Ok<EmailDraft>(value: final EmailDraft draft)) {
      if (_to.text.trim().isEmpty) {
        _to.text = draft.to.isEmpty ? _job?.recruiterEmail ?? '' : draft.to;
      }
      _subject.text = draft.subject;
      _body.text = draft.body;
    }
    setState(() {
      _loading = false;
      _failure = result.failureOrNull;
    });
  }

  Future<(Uint8List, String)> _pdf() async {
    final ProfileData profile = await ref.read(
      profileControllerProvider.future,
    );
    final (pw.Font, pw.Font)? fonts = await ref.read(
      resumeFontsProvider.future,
    );
    final Uint8List bytes = await buildResumePdf(
      draft: _resume!,
      profile: profile.profile,
      education: profile.education,
      regular: fonts?.$1,
      bold: fonts?.$2,
    );
    return (
      bytes,
      resumeFileName(profile: profile.profile, company: _job?.company ?? ''),
    );
  }

  Future<void> _open() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final (Uint8List pdf, String fileName) = await _pdf();
      final String to = _to.text.trim();
      final String subject = _subject.text.trim();
      final String body = _body.text.trim();
      if (kIsWeb) {
        // En la web no se puede adjuntar: se descarga la HV y se abre el
        // correo con el texto; el usuario la adjunta.
        await ref.read(pdfSharerProvider)(pdf, fileName);
        await ref.read(mailLauncherProvider)(
          mailtoUri(to: to, subject: subject, body: body),
        );
        messenger.showSnackBar(SnackBar(content: Text(l10n.applyWebHint)));
      } else {
        // iOS no pasa el destinatario al correo: queda copiado para pegarlo.
        if (to.isNotEmpty && defaultTargetPlatform == TargetPlatform.iOS) {
          await ref.read(clipboardWriterProvider)(to);
          messenger.showSnackBar(
            SnackBar(content: Text(l10n.applyRecipientCopied)),
          );
        }
        await ref.read(mailWithAttachmentProvider)(
          pdf: pdf,
          fileName: fileName,
          to: to,
          subject: subject,
          body: body,
        );
      }
      if (mounted) setState(() => _opened = true);
    } catch (error) {
      Log.w(tag: 'ApplyEmailScreen', message: 'apply email: $error');
      messenger.showSnackBar(SnackBar(content: Text(l10n.pdfError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _copy() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    await ref.read(clipboardWriterProvider)(
      '${_subject.text.trim()}\n\n${_body.text.trim()}',
    );
    messenger.showSnackBar(SnackBar(content: Text(l10n.emailCopied)));
  }

  /// Tras enviarlo: el proceso pasa a «Postulada».
  Future<void> _markApplied() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    final Result<void> result = await ref
        .read(applicationsControllerProvider.notifier)
        .markApplied(widget.jobId);
    final bool done = showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: result,
      success: l10n.applyMarked,
    );
    if (mounted) {
      setState(() {
        _busy = false;
        _applied = done;
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
    final Failure? failure = _failure;
    final bool placeholders = RegExp(r'\[[^\]]+\]').hasMatch(_body.text);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.applyEmailTitle),
        actions: <Widget>[
          if (!_loading && _resume != null && failure == null)
            IconButton(
              key: const Key('regenerateApplyEmail'),
              tooltip: l10n.emailRegenerate,
              onPressed: _draft,
              icon: const Icon(Icons.refresh),
            ),
        ],
      ),
      body: _loading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.emailDraftWriting),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
              children: <Widget>[
                if (job != null) ...<Widget>[
                  Text(job.title, style: theme.textTheme.titleMedium),
                  Text(
                    job.company,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.colors.muted,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (_resume == null) ...<Widget>[
                  NoticeBanner(
                    key: const Key('needsResume'),
                    text: l10n.applyNeedsResume,
                    icon: Icons.description_outlined,
                    tone: Tone.signal,
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    key: const Key('prepareFromApply'),
                    onPressed: () async {
                      await JobPrepareRoute(id: widget.jobId)
                          .push<void>(context);
                      if (mounted) await _load();
                    },
                    icon: const Icon(Icons.auto_awesome_outlined),
                    label: Text(l10n.applyPrepareResume),
                  ),
                ] else if (failure != null) ...<Widget>[
                  NoticeBanner(
                    text: failureMessage(
                      l10n: l10n,
                      failure: failure,
                      fallback: l10n.saveError,
                    ),
                    icon: Icons.error_outline,
                    tone: Tone.risk,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: _draft, child: Text(l10n.retry)),
                ] else ...<Widget>[
                  NoticeBanner(
                    text: l10n.applyReviewHint,
                    icon: Icons.attach_file,
                    tone: Tone.info,
                  ),
                  if (placeholders) ...<Widget>[
                    const SizedBox(height: 12),
                    NoticeBanner(
                      key: const Key('applyPlaceholders'),
                      text: l10n.applyPlaceholders,
                      icon: Icons.edit_note,
                      tone: Tone.signal,
                    ),
                  ],
                  const SizedBox(height: 16),
                  TextField(
                    key: const Key('applyTo'),
                    controller: _to,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: l10n.emailTo),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const Key('applySubject'),
                    controller: _subject,
                    decoration: InputDecoration(labelText: l10n.emailSubject),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const Key('applyBody'),
                    controller: _body,
                    minLines: 10,
                    maxLines: null,
                    onChanged: (_) => setState(() {}),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.emailBody,
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    key: const Key('openApplyEmail'),
                    onPressed: _busy || placeholders ? null : _open,
                    icon: const Icon(Icons.send_outlined),
                    label: Text(l10n.applyOpen),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    key: const Key('copyApplyEmail'),
                    onPressed: _copy,
                    icon: const Icon(Icons.copy_outlined),
                    label: Text(l10n.emailCopy),
                  ),
                  if (_opened) ...<Widget>[
                    const SizedBox(height: 20),
                    Text(
                      l10n.applySentQuestion,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    FilledButton.tonalIcon(
                      key: const Key('markApplied'),
                      onPressed: _busy || _applied ? null : _markApplied,
                      icon: Icon(_applied ? Icons.check : Icons.task_alt),
                      label: Text(
                        _applied ? l10n.applyMarked : l10n.applyMarkApplied,
                      ),
                    ),
                  ],
                ],
              ],
            ),
    );
  }
}
