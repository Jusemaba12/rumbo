import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/env.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/group_card.dart';
import '../../../shared/widgets/root_app_bar.dart';
import '../../account/data/account_repository.dart';
import '../../auth/data/auth_repository.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    Widget link(IconData icon, String title, GoRouteData route) => ListTile(
      leading: TileIcon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      minTileHeight: 60,
      onTap: () => route.push<void>(context),
    );
    return Scaffold(
      appBar: rootAppBar(context, l10n.moreTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          GroupCard(
            indent: 68,
            children: [
              link(
                Icons.tune,
                l10n.searchPrefsTitle,
                const SearchPreferencesRoute(),
              ),
              link(Icons.mail_outline, l10n.gmailTitle, const GmailRoute()),
              link(
                Icons.notifications_outlined,
                l10n.remindersTitle,
                const RemindersRoute(),
              ),
              link(
                Icons.question_answer_outlined,
                l10n.answersTitle,
                const AnswersRoute(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GroupCard(
            indent: 68,
            children: [
              if (!Env.hasBackend)
                ListTile(
                  leading: TileIcon(
                    Icons.cloud_off_outlined,
                    background: colors.neutralSoft,
                    foreground: colors.onNeutralSoft,
                  ),
                  title: Text(l10n.demoBanner),
                  minTileHeight: 60,
                )
              else ...[
                ListTile(
                  leading: TileIcon(
                    Icons.logout,
                    background: colors.riskSoft,
                    foreground: colors.onRiskSoft,
                  ),
                  title: Text(
                    l10n.signOut,
                    style: TextStyle(color: colors.onRiskSoft),
                  ),
                  minTileHeight: 60,
                  onTap: () => ref.read(authRepositoryProvider).signOut(),
                ),
                ListTile(
                  key: const Key('deleteAccount'),
                  leading: TileIcon(
                    Icons.delete_forever_outlined,
                    background: colors.riskSoft,
                    foreground: colors.onRiskSoft,
                  ),
                  title: Text(
                    l10n.deleteAccount,
                    style: TextStyle(color: colors.onRiskSoft),
                  ),
                  minTileHeight: 60,
                  onTap: () => _deleteAccount(context, ref),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Confirma y borra la cuenta con todos sus datos; luego vuelve al acceso.
Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final colors = context.colors;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.deleteAccountTitle),
      content: Text(l10n.deleteAccountBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          key: const Key('confirmDeleteAccount'),
          style: FilledButton.styleFrom(
            backgroundColor: colors.risk,
            minimumSize: const Size(0, 44),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.deleteAccountConfirm),
        ),
      ],
    ),
  );
  if (confirmed != true) return;
  try {
    await ref.read(accountRepositoryProvider).deleteAccount();
  } catch (_) {
    messenger.showSnackBar(SnackBar(content: Text(l10n.deleteAccountError)));
  }
}
