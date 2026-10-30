import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/account/domain/entities/app_release.dart';
import 'package:rumbo/features/account/presentation/providers/account/account_provider.dart';
import 'package:rumbo/features/email/presentation/providers/email/email_provider.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/profile_completeness.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/features/search/domain/entities/search_preferences.dart';
import 'package:rumbo/features/search/presentation/providers/search/search_provider.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';
import 'package:url_launcher/url_launcher.dart';

/// Aviso de APK nuevo en Inicio (solo Android).
class UpdateBanner extends ConsumerWidget {
  const UpdateBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppRelease? release = ref.watch(availableUpdateProvider).value;
    if (release == null) return const SizedBox.shrink();
    final AppLocalizations l10n = context.l10n;
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
    final ProfileData? profile = ref.watch(profileControllerProvider).value;
    final AsyncValue<SearchPreferences?> preferences = ref.watch(
      searchPreferencesProvider,
    );
    if (profile == null || preferences.isLoading) {
      return const SizedBox.shrink();
    }
    final List<ProfileGap> gaps = profileGaps(profile);
    final bool profileDone =
        !gaps.contains(ProfileGap.name) &&
        !gaps.contains(ProfileGap.experience);
    final bool searchDone = preferences.value?.isConfigured ?? false;
    if (profileDone && searchDone) return const SizedBox.shrink();
    final bool gmailDone =
        ref.watch(emailSyncStatusProvider).value?.lastUsedAt != null;
    final AppLocalizations l10n = context.l10n;
    final RumboColors colors = context.colors;
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
            children: <Widget>[
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
