import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../../../l10n/app_localizations.dart';
import '../data/email_repository.dart';
import '../domain/email_update.dart';
import '../domain/gmail_script.dart';
import 'email_controller.dart';

part 'gmail_connect_screen.g.dart';

/// Copia el texto al portapapeles; se sustituye en los tests.
@Riverpod(keepAlive: true)
Future<void> Function(String) clipboardWriter(Ref ref) =>
    (text) => Clipboard.setData(ClipboardData(text: text));

class GmailConnectScreen extends ConsumerStatefulWidget {
  const GmailConnectScreen({super.key});

  @override
  ConsumerState<GmailConnectScreen> createState() => _GmailConnectScreenState();
}

class _GmailConnectScreenState extends ConsumerState<GmailConnectScreen> {
  bool _busy = false;

  Future<void> _copyNewScript() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final key = await ref.read(emailRepositoryProvider).createKey();
      await ref.read(clipboardWriterProvider)(
        buildGmailScript(functionUrl: emailSyncUrl(), key: key),
      );
      ref.invalidate(emailSyncStatusProvider);
      messenger.showSnackBar(SnackBar(content: Text(l10n.gmailCopied)));
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _disconnect() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      await ref.read(emailRepositoryProvider).disconnect();
      ref.invalidate(emailSyncStatusProvider);
      messenger.showSnackBar(SnackBar(content: Text(l10n.gmailDisconnected)));
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
    final status = ref.watch(emailSyncStatusProvider);
    final format = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).add_Hm();
    final connection = status.value;
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.gmailTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: [
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
                children: [
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
                      EmailSyncStatus(lastUsedAt: final used?) =>
                        l10n.gmailConnected(format.format(used)),
                      final c => l10n.gmailWaiting(format.format(c.createdAt)),
                    }),
                  ),
                ],
              ),
            ),
          ),
          if (connection != null &&
              connection.createdAt.isBefore(linkedinScriptSince)) ...[
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
          for (final (index, step) in [
            l10n.gmailStep1,
            l10n.gmailStep2,
            l10n.gmailStep3,
            l10n.gmailStep4,
          ].indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
          if (connection != null) ...[
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
          if (connection != null) ...[
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
