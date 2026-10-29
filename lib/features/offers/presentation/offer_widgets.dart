import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/job_offer.dart';

/// «USD 4.500» con separadores del idioma del usuario.
String formatMoney(BuildContext context, double amount, String currency) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return '$currency ${NumberFormat.decimalPattern(locale).format(amount.round())}';
}

/// Salario tal como se negoció, o nulo si no se indicó.
String? offerSalaryText(BuildContext context, JobOffer offer) {
  final salary = offer.salary;
  return salary == null ? null : formatMoney(context, salary, offer.currency);
}
