import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/env.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../../email/presentation/email_controller.dart';
import '../../profile/domain/profile_completeness.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../search/presentation/search_controller.dart';
import 'account_controller.dart';

/// Aviso de APK nuevo en Inicio (solo Android).
class UpdateBanner extends ConsumerWidget {
  const UpdateBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final release = ref.watch(availableUpdateProvider).value;
    if (release == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: NoticeBanner(
        key: const Key('updateBanner'),
        text: l10n.updateAvailable(release.versionName),
        icon: Icons.system_update_outlined,
        tone: Tone.info,
        action: TextButton(
          onPressed: () => launchUrl(
            Uri.parse(release.downloadUrl),
            mode: LaunchMode.externalApplication,
          ),
          child: Text(l10n.updateDownload),
        ),
      ),
    );
  }
}

/// Lista de primeros pasos para quien empieza; desaparece al completar el
/// perfil y la búsqueda.
class FirstStepsCard extends ConsumerWidget {
  const FirstStepsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider).value;
    final preferences = ref.watch(searchPreferencesProvider);
    if (profile == null || preferences.isLoading) {
      return const SizedBox.shrink();
    }
    final gaps = profileGaps(profile);
    final profileDone =
        !gaps.contains(ProfileGap.name) &&
        !gaps.contains(ProfileGap.experience);
    final searchDone = preferences.value?.isConfigured ?? false;
    if (profileDone && searchDone) return const SizedBox.shrink();
    final gmailDone =
        ref.watch(emailSyncStatusProvider).value?.lastUsedAt != null;
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    Widget step(Key key, bool done, String text, VoidCallback onTap) =>
        ListTile(
          key: key,
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            color: done ? colors.accent : colors.muted,
          ),
          title: Text(
            text,
            style: done
                ? TextStyle(
                    color: colors.muted,
                    decoration: TextDecoration.lineThrough,
                  )
                : null,
          ),
          trailing: done ? null : const Icon(Icons.chevron_right),
          onTap: done ? null : onTap,
        );
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        key: const Key('firstSteps'),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 8, 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.firstStepsTitle, style: AppTheme.sectionTitle(context)),
              const SizedBox(height: 4),
              step(
                const Key('firstStepProfile'),
                profileDone,
                l10n.firstStepsProfile,
                () => const ResumeRoute().go(context),
              ),
              step(
                const Key('firstStepSearch'),
                searchDone,
                l10n.firstStepsSearch,
                () => const SearchPreferencesRoute().push(context),
              ),
              if (Env.hasBackend)
                step(
                  const Key('firstStepGmail'),
                  gmailDone,
                  l10n.firstStepsGmail,
                  () => const GmailRoute().push(context),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
