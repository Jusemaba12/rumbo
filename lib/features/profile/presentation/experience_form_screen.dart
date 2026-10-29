import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/profile.dart';
import 'form_helpers.dart';
import 'profile_controller.dart';

class ExperienceFormScreen extends ConsumerStatefulWidget {
  const ExperienceFormScreen({super.key, this.experienceId});

  /// Nulo para crear una experiencia nueva.
  final String? experienceId;

  @override
  ConsumerState<ExperienceFormScreen> createState() =>
      _ExperienceFormScreenState();
}

class _ExperienceFormScreenState extends ConsumerState<ExperienceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  Experience? _initial;
  late final TextEditingController _company;
  late final TextEditingController _role;
  late final TextEditingController _achievements;
  late final TextEditingController _technologies;
  DateTime? _start;
  DateTime? _end;
  bool _current = true;

  @override
  void initState() {
    super.initState();
    _initial = ref
        .read(profileControllerProvider)
        .value
        ?.experiences
        .firstWhereOrNull((e) => e.id == widget.experienceId);
    final initial = _initial;
    _company = TextEditingController(text: initial?.company);
    _role = TextEditingController(text: initial?.role);
    _achievements = TextEditingController(
      text: initial?.achievements.join('\n'),
    );
    _technologies = TextEditingController(
      text: initial?.technologies.join(', '),
    );
    _start = initial?.startDate;
    _end = initial?.endDate;
    _current = initial?.isCurrent ?? true;
  }

  @override
  void dispose() {
    _company.dispose();
    _role.dispose();
    _achievements.dispose();
    _technologies.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final experience = Experience(
      id: _initial?.id ?? '',
      company: _company.text.trim(),
      role: _role.text.trim(),
      startDate: _start!,
      endDate: _current ? null : _end,
      achievements: splitLines(_achievements.text),
      technologies: splitCommas(_technologies.text),
    );
    saveAndClose(
      context,
      () => ref
          .read(profileControllerProvider.notifier)
          .saveExperience(experience),
    );
  }

  Future<void> _delete() async {
    final initial = _initial!;
    if (!await confirmDelete(context, initial.role)) return;
    if (!mounted) return;
    await saveAndClose(
      context,
      () => ref
          .read(profileControllerProvider.notifier)
          .deleteExperience(initial.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ProfileFormScaffold(
      title: _initial == null ? l10n.experienceNew : l10n.experienceEdit,
      formKey: _formKey,
      onSave: _save,
      onDelete: _initial == null ? null : _delete,
      children: [
        TextFormField(
          key: const Key('role'),
          controller: _role,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: l10n.roleLabel),
          validator: (value) => requiredValidator(context, value),
        ),
        TextFormField(
          key: const Key('company'),
          controller: _company,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(labelText: l10n.companyLabel),
          validator: (value) => requiredValidator(context, value),
        ),
        MonthField(
          key: const Key('startDate'),
          label: l10n.startDateLabel,
          value: _start,
          onChanged: (date) => setState(() => _start = date),
          validator: (date) => date == null ? l10n.requiredField : null,
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.currentJob),
          value: _current,
          onChanged: (value) => setState(() => _current = value),
        ),
        if (!_current)
          MonthField(
            key: const Key('endDate'),
            label: l10n.endDateLabel,
            value: _end,
            onChanged: (date) => setState(() => _end = date),
            validator: (date) {
              if (date == null) return l10n.requiredField;
              final start = _start;
              if (start != null && date.isBefore(start)) {
                return l10n.endBeforeStart;
              }
              return null;
            },
          ),
        TextFormField(
          key: const Key('achievements'),
          controller: _achievements,
          minLines: 3,
          maxLines: 10,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.achievementsLabel,
            helperText: l10n.achievementsHelper,
            helperMaxLines: 2,
            alignLabelWithHint: true,
          ),
        ),
        TextFormField(
          controller: _technologies,
          decoration: InputDecoration(
            labelText: l10n.technologiesLabel,
            helperText: l10n.technologiesHelper,
            helperMaxLines: 2,
          ),
        ),
      ],
    );
  }
}

/// Campo de fecha que solo muestra mes y año, como en una HV.
class MonthField extends FormField<DateTime> {
  MonthField({
    super.key,
    required String label,
    required DateTime? value,
    required ValueChanged<DateTime> onChanged,
    super.validator,
  }) : super(
         initialValue: value,
         builder: (field) {
           final context = field.context;
           final locale = Localizations.localeOf(context).toLanguageTag();
           final selected = field.value;
           return InkWell(
             onTap: () async {
               final now = DateTime.now();
               final picked = await showDatePicker(
                 context: context,
                 initialDate: selected ?? now,
                 firstDate: DateTime(1970),
                 lastDate: now,
                 initialDatePickerMode: DatePickerMode.year,
               );
               if (picked == null) return;
               final month = DateTime(picked.year, picked.month);
               field.didChange(month);
               onChanged(month);
             },
             child: InputDecorator(
               isEmpty: selected == null,
               decoration: InputDecoration(
                 labelText: label,
                 errorText: field.errorText,
                 suffixIcon: const Icon(Icons.calendar_month_outlined),
               ),
               child: selected == null
                   ? null
                   : Text(DateFormat.yMMM(locale).format(selected)),
             ),
           );
         },
       );
}
