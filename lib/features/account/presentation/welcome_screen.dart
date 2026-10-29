import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/auth_repository.dart';
import 'account_controller.dart';

/// Aviso de privacidad que cada cuenta acepta una vez antes de usar Rumbo.
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _busy = false;

  Future<void> _accept() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      await ref.read(privacyAcceptedProvider.notifier).accept();
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = context.colors;
    Widget point(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          children: [
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
                  : () => ref.read(authRepositoryProvider).signOut(),
              child: Text(l10n.welcomeLeave),
            ),
          ],
        ),
      ),
    );
  }
}
