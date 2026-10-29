import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/profile.dart';
import 'form_helpers.dart';
import 'profile_controller.dart';

class BasicsFormScreen extends ConsumerStatefulWidget {
  const BasicsFormScreen({super.key});

  @override
  ConsumerState<BasicsFormScreen> createState() => _BasicsFormScreenState();
}

class _BasicsFormScreenState extends ConsumerState<BasicsFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final Profile _initial;
  late final TextEditingController _fullName;
  late final TextEditingController _headline;
  late final TextEditingController _location;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _summary;
  late final TextEditingController _linkedin;
  late final TextEditingController _github;
  late final TextEditingController _portfolio;
  late final TextEditingController _copMin;
  late final TextEditingController _copMax;
  late final TextEditingController _usdMin;
  late final TextEditingController _usdMax;
  LanguageLevel? _english;

  @override
  void initState() {
    super.initState();
    _initial =
        ref.read(profileControllerProvider).value?.profile ?? const Profile();
    _fullName = TextEditingController(text: _initial.fullName);
    _headline = TextEditingController(text: _initial.headline);
    _location = TextEditingController(text: _initial.location);
    _email = TextEditingController(text: _initial.email);
    _phone = TextEditingController(text: _initial.phone);
    _summary = TextEditingController(text: _initial.summary);
    _linkedin = TextEditingController(
      text: _initial.links[ProfileLinks.linkedin],
    );
    _github = TextEditingController(text: _initial.links[ProfileLinks.github]);
    _portfolio = TextEditingController(
      text: _initial.links[ProfileLinks.portfolio],
    );
    String amount(int? value) => value == null ? '' : '$value';
    _copMin = TextEditingController(text: amount(_initial.salaryCopMin));
    _copMax = TextEditingController(text: amount(_initial.salaryCopMax));
    _usdMin = TextEditingController(text: amount(_initial.salaryUsdMin));
    _usdMax = TextEditingController(text: amount(_initial.salaryUsdMax));
    _english = _initial.englishLevel;
  }

  @override
  void dispose() {
    for (final controller in [
      _fullName,
      _headline,
      _location,
      _email,
      _phone,
      _summary,
      _linkedin,
      _github,
      _portfolio,
      _copMin,
      _copMax,
      _usdMin,
      _usdMax,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final links = {
      ProfileLinks.linkedin: _linkedin.text.trim(),
      ProfileLinks.github: _github.text.trim(),
      ProfileLinks.portfolio: _portfolio.text.trim(),
    }..removeWhere((key, url) => url.isEmpty);
    final profile = _initial
        .copyWith(
          fullName: _fullName.text.trim(),
          headline: _headline.text.trim(),
          location: _location.text.trim(),
          email: _email.text.trim(),
          phone: _phone.text.trim(),
          summary: _summary.text.trim(),
          links: links,
          salaryCopMin: parseAmount(_copMin.text),
          salaryCopMax: parseAmount(_copMax.text),
          salaryUsdMin: parseAmount(_usdMin.text),
          salaryUsdMax: parseAmount(_usdMax.text),
        )
        .withEnglish(_english);
    saveAndClose(
      context,
      () => ref.read(profileControllerProvider.notifier).saveProfile(profile),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ProfileFormScaffold(
      title: l10n.sectionBasics,
      formKey: _formKey,
      onSave: _save,
      children: [
        TextFormField(
          key: const Key('fullName'),
          controller: _fullName,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(labelText: l10n.fullNameLabel),
          validator: (value) => requiredValidator(context, value),
        ),
        TextFormField(
          key: const Key('headline'),
          controller: _headline,
          decoration: InputDecoration(
            labelText: l10n.headlineLabel,
            hintText: l10n.headlineHint,
          ),
        ),
        TextFormField(
          controller: _location,
          decoration: InputDecoration(
            labelText: l10n.locationLabel,
            hintText: l10n.locationHint,
          ),
        ),
        TextFormField(
          key: const Key('email'),
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          decoration: InputDecoration(labelText: l10n.emailLabel),
          validator: (value) {
            final text = value?.trim() ?? '';
            return text.isEmpty ||
                    RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)
                ? null
                : l10n.emailInvalid;
          },
        ),
        TextFormField(
          controller: _phone,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: l10n.phoneLabel,
            hintText: l10n.phoneHint,
          ),
        ),
        TextFormField(
          controller: _summary,
          minLines: 3,
          maxLines: 8,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.summaryLabel,
            alignLabelWithHint: true,
          ),
        ),
        DropdownButtonFormField<LanguageLevel?>(
          key: const Key('englishLevel'),
          isExpanded: true,
          initialValue: _english,
          decoration: InputDecoration(
            labelText: l10n.englishLevelLabel,
            helperText: l10n.englishLevelHelper,
            helperMaxLines: 2,
          ),
          items: [
            DropdownMenuItem(child: Text(l10n.englishLevelNone)),
            for (final level in LanguageLevel.values)
              DropdownMenuItem(
                value: level,
                child: Text(languageLevelLabel(l10n, level)),
              ),
          ],
          onChanged: (level) => setState(() => _english = level),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.salaryTitle, style: AppTheme.sectionTitle(context)),
            const SizedBox(height: 4),
            Text(
              l10n.salaryHelper,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            _AmountRange(
              currency: 'COP',
              min: _copMin,
              max: _copMax,
              minLabel: l10n.salaryMinLabel('COP'),
              maxLabel: l10n.salaryMaxLabel('COP'),
            ),
            const SizedBox(height: 12),
            _AmountRange(
              currency: 'USD',
              min: _usdMin,
              max: _usdMax,
              minLabel: l10n.salaryMinLabel('USD'),
              maxLabel: l10n.salaryMaxLabel('USD'),
            ),
          ],
        ),
        for (final (key, controller, label) in [
          (const Key('linkedin'), _linkedin, l10n.linkedinLabel),
          (const Key('github'), _github, l10n.githubLabel),
          (const Key('portfolio'), _portfolio, l10n.portfolioLabel),
        ])
          TextFormField(
            key: key,
            controller: controller,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: InputDecoration(labelText: label),
            validator: (value) => optionalUrlValidator(context, value),
          ),
      ],
    );
  }
}

/// «COP 6.000.000 – 8.000.000 · USD 1.500 – 2.000»; solo las monedas con
/// algún valor.
String salaryExpectationText(Profile profile, String locale) {
  final format = NumberFormat.decimalPattern(locale);
  String? range(String currency, int? min, int? max) {
    if (min == null && max == null) return null;
    final values = [min, max].nonNulls.toSet().map(format.format).join(' – ');
    return '$currency $values';
  }

  return [
    range('COP', profile.salaryCopMin, profile.salaryCopMax),
    range('USD', profile.salaryUsdMin, profile.salaryUsdMax),
  ].nonNulls.join(' · ');
}

/// Cifra escrita a mano («4.500.000», «4500000»); nula si está vacía.
int? parseAmount(String text) {
  final digits = text.replaceAll(RegExp(r'[^0-9]'), '');
  return digits.isEmpty ? null : int.tryParse(digits);
}

String languageLevelLabel(AppLocalizations l10n, LanguageLevel level) =>
    switch (level) {
      LanguageLevel.a1 => l10n.englishLevelA1,
      LanguageLevel.a2 => l10n.englishLevelA2,
      LanguageLevel.b1 => l10n.englishLevelB1,
      LanguageLevel.b2 => l10n.englishLevelB2,
      LanguageLevel.c1 => l10n.englishLevelC1,
      LanguageLevel.c2 => l10n.englishLevelC2,
      LanguageLevel.native => l10n.englishLevelNative,
    };

/// Mínimo y máximo de una moneda; el máximo no puede ser menor.
class _AmountRange extends StatelessWidget {
  const _AmountRange({
    required this.currency,
    required this.min,
    required this.max,
    required this.minLabel,
    required this.maxLabel,
  });

  final String currency;
  final TextEditingController min;
  final TextEditingController max;
  final String minLabel;
  final String maxLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget field(TextEditingController controller, String label, Key key) =>
        Expanded(
          child: TextFormField(
            key: key,
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: label),
            validator: controller == max
                ? (_) {
                    final low = parseAmount(min.text);
                    final high = parseAmount(max.text);
                    return low != null && high != null && high < low
                        ? l10n.salaryRangeInvalid
                        : null;
                  }
                : null,
          ),
        );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        field(min, minLabel, Key('salary-$currency-min')),
        const SizedBox(width: 12),
        field(max, maxLabel, Key('salary-$currency-max')),
      ],
    );
  }
}
