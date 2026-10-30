import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/email/application/use_cases/draft_email_use_case.dart';
import 'package:rumbo/features/email/domain/entities/email_draft.dart';
import 'package:rumbo/features/email/domain/services/mailto.dart';
import 'package:rumbo/features/email/infrastructure/services/mail_services.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';

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
  final TextEditingController _to = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _body = TextEditingController();
  bool _loading = true;
  Failure? _failure;

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
    final DraftEmailUseCase draftEmail = ref.read(draftEmailUseCaseProvider);
    if (!draftEmail.isAvailable) return;
    setState(() {
      _loading = true;
      _failure = null;
    });
    final Result<EmailDraft> result = await draftEmail(
      applicationId: widget.applicationId,
      kind: widget.kind,
    );
    if (!mounted) return;
    if (result case Ok<EmailDraft>(value: final EmailDraft draft)) {
      // Un destinatario escrito a mano no se pisa al pedir otra versión.
      if (_to.text.trim().isEmpty) _to.text = draft.to;
      _subject.text = draft.subject;
      _body.text = draft.body;
    }
    setState(() {
      _loading = false;
      _failure = result.failureOrNull;
    });
  }

  Future<void> _copy() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    await ref.read(clipboardWriterProvider)(
      '${_subject.text.trim()}\n\n${_body.text.trim()}',
    );
    messenger.showSnackBar(SnackBar(content: Text(l10n.emailCopied)));
  }

  Future<void> _open() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final bool opened = await ref.read(mailLauncherProvider)(
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
    final AppLocalizations l10n = context.l10n;
    final Failure? failure = _failure;
    return Scaffold(
      appBar: AppBar(
        title: Text(emailKindLabel(l10n, widget.kind)),
        actions: <Widget>[
          if (!_loading)
            IconButton(
              key: const Key('regenerateEmail'),
              tooltip: l10n.emailRegenerate,
              onPressed: _generate,
              icon: const Icon(Icons.refresh),
            ),
        ],
      ),
      bottomNavigationBar: _loading || failure != null
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
                    children: <Widget>[
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
                children: <Widget>[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.emailDraftWriting),
                ],
              ),
            )
          : failure != null
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
                  OutlinedButton(onPressed: _generate, child: Text(l10n.retry)),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              children: <Widget>[
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
