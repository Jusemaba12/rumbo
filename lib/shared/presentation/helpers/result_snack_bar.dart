import 'package:flutter/material.dart';

import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';

/// Avisa en un SnackBar cómo terminó una acción: [success] si salió bien
/// (nada si es nulo) o el mensaje del fallo, con [fallback] para los no
/// comunes (por defecto, «No se pudo guardar»). Devuelve si salió bien.
///
/// Recibe el [ScaffoldMessengerState] y no el contexto para poder usarse
/// después de un `await`.
bool showResultSnackBar({
  required ScaffoldMessengerState messenger,
  required AppLocalizations l10n,
  required Result<Object?> result,
  String? success,
  String? fallback,
}) {
  switch (result) {
    case Ok<Object?>():
      if (success != null) {
        messenger.showSnackBar(SnackBar(content: Text(success)));
      }
      return true;
    case Err<Object?>(:final Failure failure):
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            failureMessage(
              l10n: l10n,
              failure: failure,
              fallback: fallback ?? l10n.saveError,
            ),
          ),
        ),
      );
      return false;
  }
}
