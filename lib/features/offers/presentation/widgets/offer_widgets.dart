import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:rumbo/features/offers/domain/entities/job_offer.dart';

/// «USD 4.500» con separadores del idioma del usuario.
String formatMoney(BuildContext context, double amount, String currency) {
  final String locale = Localizations.localeOf(context).toLanguageTag();
  final String formatted = NumberFormat.decimalPattern(locale)
      .format(amount.round());
  return '$currency $formatted';
}

/// Salario tal como se negoció, o nulo si no se indicó.
String? offerSalaryText(BuildContext context, JobOffer offer) {
  final double? salary = offer.salary;
  return salary == null ? null : formatMoney(context, salary, offer.currency);
}
