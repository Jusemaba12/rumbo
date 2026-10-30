import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/account/presentation/providers/account/account_provider.dart';
import 'package:rumbo/features/auth/application/use_cases/sign_out_use_case.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';

/// Aviso de privacidad que cada cuenta acepta una vez antes de usar Rumbo.
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _busy = false;

  Future<void> _accept() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    final bool done = showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: await ref.read(privacyAcceptedProvider.notifier).accept(),
    );
    if (!done && mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final RumboColors colors = context.colors;
    Widget point(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 22, color: colors.accent),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colors.hero,
                  borderRadius: BorderRadius.circular(AppTheme.radius - 2),
                ),
                child: Icon(
                  Icons.explore_outlined,
                  size: 30,
                  color: colors.heroAccent,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(l10n.welcomeTitle, style: AppTheme.screenTitle(context)),
            const SizedBox(height: 8),
            Text(
              l10n.welcomeIntro,
              style: theme.textTheme.bodyLarge?.copyWith(color: colors.muted),
            ),
            const SizedBox(height: 28),
            Text(l10n.welcomeDataTitle, style: AppTheme.sectionTitle(context)),
            const SizedBox(height: 14),
            point(Icons.lock_outline, l10n.welcomePrivate),
            point(Icons.auto_awesome_outlined, l10n.welcomeAi),
            point(Icons.speed_outlined, l10n.welcomeLimit(aiDailyLimit)),
            point(Icons.delete_outline, l10n.welcomeDelete),
            const SizedBox(height: 20),
            FilledButton(
              key: const Key('acceptPrivacy'),
              onPressed: _busy ? null : _accept,
              child: Text(l10n.welcomeAccept),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _busy
                  ? null
                  : () => ref.read(signOutUseCaseProvider)(),
              child: Text(l10n.welcomeLeave),
            ),
          ],
        ),
      ),
    );
  }
}
