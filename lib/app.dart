import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/navigation/app_router.dart';

class RumboApp extends ConsumerWidget {
  const RumboApp({super.key, this.locale});

  /// Fuerza un idioma; por defecto se usa el del sistema.
  final Locale? locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) => context.l10n.appName,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      locale: locale,
      routerConfig: ref.watch(appRouterProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
