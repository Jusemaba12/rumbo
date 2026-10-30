import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rumbo/features/email/application/use_cases/create_email_sync_key_use_case.dart';
import 'package:rumbo/features/email/application/use_cases/disconnect_email_sync_use_case.dart';
import 'package:rumbo/features/email/domain/entities/email_update.dart';
import 'package:rumbo/features/email/domain/services/gmail_script.dart';
import 'package:rumbo/features/email/infrastructure/services/mail_services.dart';
import 'package:rumbo/features/email/presentation/providers/email/email_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';
import 'package:url_launcher/url_launcher.dart';

class GmailConnectScreen extends ConsumerStatefulWidget {
  const GmailConnectScreen({super.key});

  @override
  ConsumerState<GmailConnectScreen> createState() => _GmailConnectScreenState();
}

class _GmailConnectScreenState extends ConsumerState<GmailConnectScreen> {
  bool _busy = false;

  Future<void> _copyNewScript() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    final Result<String> key = await ref.read(
      createEmailSyncKeyUseCaseProvider,
    )();
    if (key case Ok<String>(:final String value)) {
      await ref.read(clipboardWriterProvider)(
        buildGmailScript(functionUrl: emailSyncUrl(), key: value),
      );
      ref.invalidate(emailSyncStatusProvider);
    }
    showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: key,
      success: l10n.gmailCopied,
    );
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _disconnect() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    final Result<void> result = await ref.read(
      disconnectEmailSyncUseCaseProvider,
    )();
    if (result.isOk) ref.invalidate(emailSyncStatusProvider);
    showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: result,
      success: l10n.gmailDisconnected,
    );
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final AsyncValue<EmailSyncStatus?> status = ref.watch(
      emailSyncStatusProvider,
    );
    final DateFormat format = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).add_Hm();
    final EmailSyncStatus? connection = status.value;
    final TextStyle? muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.gmailTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: <Widget>[
          Text(l10n.gmailIntro),
          const SizedBox(height: 12),
          Text(l10n.gmailHow, style: muted),
          const SizedBox(height: 8),
          Text(l10n.gmailPrivacy, style: muted),
          const SizedBox(height: 20),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Icon(
                    connection?.lastUsedAt != null
                        ? Icons.check_circle_outline
                        : Icons.mail_outline,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(switch (connection) {
                      null when status.isLoading => '',
                      null => l10n.gmailNotConnected,
                      EmailSyncStatus(lastUsedAt: final DateTime used?) =>
                        l10n.gmailConnected(format.format(used)),
                      final EmailSyncStatus c => l10n.gmailWaiting(
                        format.format(c.createdAt),
                      ),
                    }),
                  ),
                ],
              ),
            ),
          ),
          if (connection != null &&
              connection.createdAt.isBefore(linkedinScriptSince)) ...<Widget>[
            const SizedBox(height: 12),
            NoticeBanner(
              key: const Key('updateGmailScript'),
              text: l10n.gmailLinkedinUpdate,
              icon: Icons.system_update_alt,
              tone: Tone.signal,
            ),
          ],
          const SizedBox(height: 20),
          Text(l10n.gmailLinkedinTitle, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 4),
          Text(l10n.gmailLinkedinBody, style: muted),
          const SizedBox(height: 20),
          for (final (int index, String step) in <String>[
            l10n.gmailStep1,
            l10n.gmailStep2,
            l10n.gmailStep3,
            l10n.gmailStep4,
          ].indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(radius: 12, child: Text('${index + 1}')),
                  const SizedBox(width: 12),
                  Expanded(child: Text(step)),
                ],
              ),
            ),
          const SizedBox(height: 8),
          FilledButton.icon(
            key: const Key('copyScript'),
            onPressed: _busy ? null : _copyNewScript,
            icon: const Icon(Icons.copy),
            label: Text(
              connection == null ? l10n.gmailCopy : l10n.gmailRegenerate,
            ),
          ),
          if (connection != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(l10n.gmailRegenerateHint, style: theme.textTheme.bodySmall),
          ],
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => launchUrl(
              Uri.parse('https://script.google.com/home/projects/create'),
              mode: LaunchMode.externalApplication,
            ),
            icon: const Icon(Icons.open_in_new),
            label: Text(l10n.gmailOpenScript),
          ),
          if (connection != null) ...<Widget>[
            const SizedBox(height: 8),
            TextButton(
              key: const Key('disconnectGmail'),
              onPressed: _busy ? null : _disconnect,
              child: Text(l10n.gmailDisconnect),
            ),
          ],
        ],
      ),
    );
  }
}
