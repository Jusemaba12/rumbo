import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';

/// Mensaje para los fallos comunes. Cada pantalla resuelve antes los fallos
/// propios de su funcionalidad y pasa en [fallback] el texto para los demás.
String failureMessage({
  required AppLocalizations l10n,
  required Failure failure,
  required String fallback,
}) => switch (failure) {
  DailyLimitFailure() => l10n.aiErrorDailyLimit,
  RateLimitedFailure() => l10n.aiErrorRateLimited,
  AiBusyFailure() => l10n.aiErrorBusy,
  _ => fallback,
};
