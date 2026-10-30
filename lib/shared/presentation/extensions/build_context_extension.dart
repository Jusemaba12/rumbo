import 'package:flutter/widgets.dart';

import 'package:rumbo/shared/configurations/language/app_localizations.dart';

extension BuildContextL10n on BuildContext {
  /// Textos traducidos de la app.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
