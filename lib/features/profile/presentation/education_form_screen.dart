import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/profile.dart';
import 'experience_form_screen.dart' show MonthField;
import 'form_helpers.dart';
import 'profile_controller.dart';

class EducationFormScreen extends ConsumerStatefulWidget {
  const EducationFormScreen({super.key, this.educationId});

  /// Nulo para crear un registro nuevo.
  final String? educationId;

  @override
  ConsumerState<EducationFormScreen> createState() =>
      _EducationFormScreenState();
}

class _EducationFormScreenState extends ConsumerState<EducationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  Education? _initial;
  late final TextEditingController _institution;
  late final TextEditingController _degree;
  DateTime? _start;
  DateTime? _end;
  bool _current = false;

  @override
  void initState() {
    super.initState();
    _initial = ref
        .read(profileControllerProvider)
        .value
        ?.education
        .firstWhereOrNull((e) => e.id == widget.educationId);
    final initial = _initial;
    _institution = TextEditingController(text: initial?.institution);
    _degree = TextEditingController(text: initial?.degree);
    _start = initial?.startDate;
    _end = initial?.endDate;
    _current = initial != null && initial.endDate == null;
  }

  @override
  void dispose() {
    _institution.dispose();
    _degree.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final education = Education(
      id: _initial?.id ?? '',
      institution: _institution.text.trim(),
      degree: _degree.text.trim(),
      startDate: _start,
      endDate: _current ? null : _end,
    );
    saveAndClose(
      context,
      () =>
          ref.read(profileControllerProvider.notifier).saveEducation(education),
    );
  }

  Future<void> _delete() async {
    final initial = _initial!;
    if (!await confirmDelete(context, initial.institution)) return;
    if (!mounted) return;
    await saveAndClose(
      context,
      () => ref
          .read(profileControllerProvider.notifier)
          .deleteEducation(initial.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ProfileFormScaffold(
      title: _initial == null ? l10n.educationNew : l10n.educationEdit,
      formKey: _formKey,
      onSave: _save,
      onDelete: _initial == null ? null : _delete,
      children: [
        TextFormField(
          key: const Key('degree'),
          controller: _degree,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: l10n.degreeLabel),
        ),
        TextFormField(
          key: const Key('institution'),
          controller: _institution,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(labelText: l10n.institutionLabel),
          validator: (value) => requiredValidator(context, value),
        ),
        MonthField(
          label: l10n.startDateLabel,
          value: _start,
          onChanged: (date) => setState(() => _start = date),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.studyingNow),
          value: _current,
          onChanged: (value) => setState(() => _current = value),
        ),
        if (!_current)
          MonthField(
            label: l10n.endDateLabel,
            value: _end,
            onChanged: (date) => setState(() => _end = date),
            validator: (date) {
              final start = _start;
              return date != null && start != null && date.isBefore(start)
                  ? l10n.endBeforeStart
                  : null;
            },
          ),
      ],
    );
  }
}
