import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../../applications/data/resume_pdf.dart';
import '../../applications/data/resume_versions_repository.dart';
import '../../applications/domain/application_draft.dart';
import '../../applications/domain/application_status.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../applications/presentation/prepare_application_screen.dart';
import '../../email/data/email_drafter.dart';
import '../../email/presentation/email_draft_screen.dart';
import '../../email/presentation/gmail_connect_screen.dart';
import '../../profile/presentation/profile_controller.dart';
import '../domain/job.dart';
import 'jobs_controller.dart';

part 'apply_email_screen.g.dart';

/// Abre la app de correo con el PDF adjunto y el borrador. En iOS el menú
/// de compartir no rellena el destinatario (se copia antes); en Android sí.
typedef MailWithAttachment = Future<void> Function({
  required Uint8List pdf,
  required String fileName,
  required String to,
  required String subject,
  required String body,
});

@Riverpod(keepAlive: true)
MailWithAttachment mailWithAttachment(Ref ref) =>
    ({
      required pdf,
      required fileName,
      required to,
      required subject,
      required body,
    }) => Printing.sharePdf(
      bytes: pdf,
      filename: fileName,
      subject: subject,
      body: body,
      emails: [if (to.isNotEmpty) to],
    );

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
  final _to = TextEditingController();
  final _subject = TextEditingController();
  final _body = TextEditingController();
  ApplicationDraft? _resume;
  bool _loading = true;
  bool _busy = false;
  bool _opened = false;
  bool _applied = false;
  Object? _error;

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
      ?.firstWhereOrNull((item) => item.job.id == widget.jobId)
      ?.job;

  /// Busca la HV adaptada; si la hay, pide el borrador a la IA.
  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final resume = await ref
          .read(resumeVersionsRepositoryProvider)
          .latestForJob(widget.jobId);
      if (!mounted) return;
      setState(() => _resume = resume);
      if (resume != null) await _draft();
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _draft() async {
    final drafter = ref.read(emailDrafterProvider);
    if (drafter == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final draft = await drafter.draftApplication(widget.jobId);
      if (!mounted) return;
      if (_to.text.trim().isEmpty) {
        _to.text = draft.to.isEmpty ? _job?.recruiterEmail ?? '' : draft.to;
      }
      _subject.text = draft.subject;
      _body.text = draft.body;
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<(Uint8List, String)> _pdf() async {
    final profile = await ref.read(profileControllerProvider.future);
    final fonts = await ref.read(resumeFontsProvider.future);
    final bytes = await buildResumePdf(
      draft: _resume!,
      profile: profile.profile,
      education: profile.education,
      regular: fonts?.$1,
      bold: fonts?.$2,
    );
    return (bytes, resumeFileName(profile.profile, _job?.company ?? ''));
  }

  Future<void> _open() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final (pdf, fileName) = await _pdf();
      final to = _to.text.trim();
      final subject = _subject.text.trim();
      final body = _body.text.trim();
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
      debugPrint('apply email: $error');
      messenger.showSnackBar(SnackBar(content: Text(l10n.pdfError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _copy() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await ref.read(clipboardWriterProvider)(
      '${_subject.text.trim()}\n\n${_body.text.trim()}',
    );
    messenger.showSnackBar(SnackBar(content: Text(l10n.emailCopied)));
  }

  /// Tras enviarlo: el proceso pasa a «Postulada».
  Future<void> _markApplied() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final controller = ref.read(applicationsControllerProvider.notifier);
      var application = await controller.startForJob(widget.jobId);
      // Ya tiene la HV adaptada: «Guardada» pasa por «Preparando» para que el
      // historial siga el orden normal.
      if (application.status == ApplicationStatus.saved) {
        await controller.changeStatus(application, ApplicationStatus.preparing);
        application = controller.forJob(widget.jobId) ?? application;
      }
      if (application.status.canMoveTo(ApplicationStatus.applied)) {
        await controller.changeStatus(application, ApplicationStatus.applied);
      }
      if (mounted) setState(() => _applied = true);
      messenger.showSnackBar(SnackBar(content: Text(l10n.applyMarked)));
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
    } finally {
      if (mounted) setState(() => _busy = false);
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
    final error = _error;
    final placeholders = RegExp(r'\[[^\]]+\]').hasMatch(_body.text);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.applyEmailTitle),
        actions: [
          if (!_loading && _resume != null && error == null)
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
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.emailDraftWriting),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
              children: [
                if (job != null) ...[
                  Text(job.title, style: theme.textTheme.titleMedium),
                  Text(
                    job.company,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.colors.muted,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (_resume == null) ...[
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
                ] else if (error != null) ...[
                  NoticeBanner(
                    text: switch (error) {
                      EmailDraftException(
                        reason: EmailDraftFailure.dailyLimit,
                      ) =>
                        l10n.aiErrorDailyLimit,
                      EmailDraftException(reason: EmailDraftFailure.busy) =>
                        l10n.aiErrorBusy,
                      EmailDraftException(
                        reason: EmailDraftFailure.rateLimited,
                      ) =>
                        l10n.aiErrorRateLimited,
                      _ => l10n.saveError,
                    },
                    icon: Icons.error_outline,
                    tone: Tone.risk,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: _draft, child: Text(l10n.retry)),
                ] else ...[
                  NoticeBanner(
                    text: l10n.applyReviewHint,
                    icon: Icons.attach_file,
                    tone: Tone.info,
                  ),
                  if (placeholders) ...[
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
                  if (_opened) ...[
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
