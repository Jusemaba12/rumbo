import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rumbo/features/account/application/use_cases/delete_account_use_case.dart';
import 'package:rumbo/features/auth/application/use_cases/sign_out_use_case.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/group_card.dart';
import 'package:rumbo/shared/presentation/widgets/root_app_bar.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final RumboColors colors = context.colors;
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
        children: <Widget>[
          GroupCard(
            indent: 68,
            children: <Widget>[
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
            children: <Widget>[
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
              else ...<Widget>[
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
                  onTap: () => ref.read(signOutUseCaseProvider)(),
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
  final AppLocalizations l10n = context.l10n;
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  final RumboColors colors = context.colors;
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(l10n.deleteAccountTitle),
      content: Text(l10n.deleteAccountBody),
      actions: <Widget>[
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
  showResultSnackBar(
    messenger: messenger,
    l10n: l10n,
    result: await ref.read(deleteAccountUseCaseProvider)(),
    fallback: l10n.deleteAccountError,
  );
}
