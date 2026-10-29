import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/profile.dart';
import 'form_helpers.dart';
import 'profile_controller.dart';

class ProjectFormScreen extends ConsumerStatefulWidget {
  const ProjectFormScreen({super.key, this.projectId});

  /// Nulo para crear un proyecto nuevo.
  final String? projectId;

  @override
  ConsumerState<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends ConsumerState<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  Project? _initial;
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _url;
  late final TextEditingController _technologies;

  @override
  void initState() {
    super.initState();
    _initial = ref
        .read(profileControllerProvider)
        .value
        ?.projects
        .firstWhereOrNull((p) => p.id == widget.projectId);
    final initial = _initial;
    _name = TextEditingController(text: initial?.name);
    _description = TextEditingController(text: initial?.description);
    _url = TextEditingController(text: initial?.url);
    _technologies = TextEditingController(
      text: initial?.technologies.join(', '),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _url.dispose();
    _technologies.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final url = _url.text.trim();
    final project = Project(
      id: _initial?.id ?? '',
      name: _name.text.trim(),
      description: _description.text.trim(),
      url: url.isEmpty ? null : url,
      technologies: splitCommas(_technologies.text),
    );
    saveAndClose(
      context,
      () => ref.read(profileControllerProvider.notifier).saveProject(project),
    );
  }

  Future<void> _delete() async {
    final initial = _initial!;
    if (!await confirmDelete(context, initial.name)) return;
    if (!mounted) return;
    await saveAndClose(
      context,
      () => ref
          .read(profileControllerProvider.notifier)
          .deleteProject(initial.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ProfileFormScaffold(
      title: _initial == null ? l10n.projectNew : l10n.projectEdit,
      formKey: _formKey,
      onSave: _save,
      onDelete: _initial == null ? null : _delete,
      children: [
        TextFormField(
          key: const Key('projectName'),
          controller: _name,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: l10n.projectNameLabel),
          validator: (value) => requiredValidator(context, value),
        ),
        TextFormField(
          controller: _description,
          minLines: 3,
          maxLines: 8,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.descriptionLabel,
            alignLabelWithHint: true,
          ),
        ),
        TextFormField(
          controller: _url,
          keyboardType: TextInputType.url,
          autocorrect: false,
          decoration: InputDecoration(labelText: l10n.projectUrlLabel),
          validator: (value) => optionalUrlValidator(context, value),
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
