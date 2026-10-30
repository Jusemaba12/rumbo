import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';

class ProjectFormScreen extends ConsumerStatefulWidget {
  const ProjectFormScreen({super.key, this.projectId});

  /// Nulo para crear un proyecto nuevo.
  final String? projectId;

  @override
  ConsumerState<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends ConsumerState<ProjectFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        .firstWhereOrNull((Project p) => p.id == widget.projectId);
    final Project? initial = _initial;
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
    final String url = _url.text.trim();
    final Project project = Project(
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
    final Project initial = _initial!;
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
    final AppLocalizations l10n = context.l10n;
    return ProfileFormScaffold(
      title: _initial == null ? l10n.projectNew : l10n.projectEdit,
      formKey: _formKey,
      onSave: _save,
      onDelete: _initial == null ? null : _delete,
      children: <Widget>[
        TextFormField(
          key: const Key('projectName'),
          controller: _name,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: l10n.projectNameLabel),
          validator: (String? value) => requiredValidator(context, value),
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
          validator: (String? value) => optionalUrlValidator(context, value),
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
