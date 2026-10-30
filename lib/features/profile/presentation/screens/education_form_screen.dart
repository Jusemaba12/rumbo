import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/features/profile/presentation/screens/experience_form_screen.dart'
    show MonthField;
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';

class EducationFormScreen extends ConsumerStatefulWidget {
  const EducationFormScreen({super.key, this.educationId});

  /// Nulo para crear un registro nuevo.
  final String? educationId;

  @override
  ConsumerState<EducationFormScreen> createState() =>
      _EducationFormScreenState();
}

class _EducationFormScreenState extends ConsumerState<EducationFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        .firstWhereOrNull((Education e) => e.id == widget.educationId);
    final Education? initial = _initial;
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
    final Education education = Education(
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
    final Education initial = _initial!;
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
    final AppLocalizations l10n = context.l10n;
    return ProfileFormScaffold(
      title: _initial == null ? l10n.educationNew : l10n.educationEdit,
      formKey: _formKey,
      onSave: _save,
      onDelete: _initial == null ? null : _delete,
      children: <Widget>[
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
          validator: (String? value) => requiredValidator(context, value),
        ),
        MonthField(
          label: l10n.startDateLabel,
          value: _start,
          onChanged: (DateTime date) => setState(() => _start = date),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.studyingNow),
          value: _current,
          onChanged: (bool value) => setState(() => _current = value),
        ),
        if (!_current)
          MonthField(
            label: l10n.endDateLabel,
            value: _end,
            onChanged: (DateTime date) => setState(() => _end = date),
            validator: (DateTime? date) {
              final DateTime? start = _start;
              return date != null && start != null && date.isBefore(start)
                  ? l10n.endBeforeStart
                  : null;
            },
          ),
      ],
    );
  }
}
