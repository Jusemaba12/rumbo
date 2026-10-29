import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../data/email_drafter.dart';
import 'gmail_connect_screen.dart';

part 'email_draft_screen.g.dart';

/// Abre la app de correo con un enlace mailto; falso si no se pudo.
@Riverpod(keepAlive: true)
Future<bool> Function(Uri) mailLauncher(Ref ref) =>
    (uri) => launchUrl(uri, mode: LaunchMode.externalApplication);

String emailKindLabel(AppLocalizations l10n, EmailDraftKind kind) =>
    switch (kind) {
      EmailDraftKind.followUp => l10n.emailKindFollowUp,
      EmailDraftKind.thankYou => l10n.emailKindThankYou,
      EmailDraftKind.rejectionReply => l10n.emailKindRejection,
    };

/// Borrador de correo con IA para un proceso: se edita, se copia o se abre
/// en la app de correo. Nunca se envía desde Rumbo.
class EmailDraftScreen extends ConsumerStatefulWidget {
  const EmailDraftScreen({
    super.key,
    required this.applicationId,
    required this.kind,
  });

  final String applicationId;
  final EmailDraftKind kind;

  @override
  ConsumerState<EmailDraftScreen> createState() => _EmailDraftScreenState();
}

class _EmailDraftScreenState extends ConsumerState<EmailDraftScreen> {
  final _to = TextEditingController();
  final _subject = TextEditingController();
  final _body = TextEditingController();
  bool _loading = true;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _generate();
  }

  @override
  void dispose() {
    _to.dispose();
    _subject.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final drafter = ref.read(emailDrafterProvider);
    if (drafter == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final draft = await drafter.draft(widget.applicationId, widget.kind);
      if (!mounted) return;
      // Un destinatario escrito a mano no se pisa al pedir otra versión.
      if (_to.text.trim().isEmpty) _to.text = draft.to;
      _subject.text = draft.subject;
      _body.text = draft.body;
      setState(() => _loading = false);
    } catch (error) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = error;
        });
      }
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

  Future<void> _open() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final opened = await ref.read(mailLauncherProvider)(
      mailtoUri(
        to: _to.text.trim(),
        subject: _subject.text.trim(),
        body: _body.text.trim(),
      ),
    );
    if (!opened) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.emailOpenError)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final error = _error;
    return Scaffold(
      appBar: AppBar(
        title: Text(emailKindLabel(l10n, widget.kind)),
        actions: [
          if (!_loading)
            IconButton(
              key: const Key('regenerateEmail'),
              tooltip: l10n.emailRegenerate,
              onPressed: _generate,
              icon: const Icon(Icons.refresh),
            ),
        ],
      ),
      bottomNavigationBar: _loading || error != null
          ? null
          : DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border(top: BorderSide(color: context.colors.line)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          key: const Key('copyEmail'),
                          onPressed: _copy,
                          icon: const Icon(Icons.copy_outlined),
                          label: Text(l10n.emailCopy),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          key: const Key('openEmail'),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(0, 48),
                          ),
                          onPressed: _open,
                          icon: const Icon(Icons.send_outlined),
                          label: Text(l10n.emailOpen),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
          : error != null
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                  OutlinedButton(onPressed: _generate, child: Text(l10n.retry)),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              children: [
                NoticeBanner(
                  text: l10n.emailReviewHint,
                  icon: Icons.visibility_outlined,
                  tone: Tone.info,
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('emailTo'),
                  controller: _to,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(labelText: l10n.emailTo),
                ),
                const SizedBox(height: 12),
                TextField(
                  key: const Key('emailSubject'),
                  controller: _subject,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.emailSubject),
                ),
                const SizedBox(height: 12),
                TextField(
                  key: const Key('emailBody'),
                  controller: _body,
                  minLines: 10,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: l10n.emailBody,
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
    );
  }
}
