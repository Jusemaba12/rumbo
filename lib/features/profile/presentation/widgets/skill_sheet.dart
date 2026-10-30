import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';

String skillCategoryLabel(AppLocalizations l10n, SkillCategory category) =>
    switch (category) {
      SkillCategory.language => l10n.categoryLanguage,
      SkillCategory.framework => l10n.categoryFramework,
      SkillCategory.tool => l10n.categoryTool,
      SkillCategory.other => l10n.categoryOther,
    };

/// Abre la hoja para crear una habilidad o editar [skill].
Future<void> showSkillSheet(BuildContext context, {Skill? skill}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) => _SkillSheet(skill: skill),
    );

class _SkillSheet extends ConsumerStatefulWidget {
  const _SkillSheet({this.skill});

  final Skill? skill;

  @override
  ConsumerState<_SkillSheet> createState() => _SkillSheetState();
}

class _SkillSheetState extends ConsumerState<_SkillSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _years;
  late SkillCategory _category;

  @override
  void initState() {
    super.initState();
    final Skill? skill = widget.skill;
    _name = TextEditingController(text: skill?.name);
    _years = TextEditingController(text: skill?.years?.toString());
    _category = skill?.category ?? SkillCategory.framework;
  }

  @override
  void dispose() {
    _name.dispose();
    _years.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final Skill skill = Skill(
      id: widget.skill?.id ?? '',
      name: _name.text.trim(),
      category: _category,
      years: int.tryParse(_years.text),
    );
    saveAndClose(
      context,
      () => ref.read(profileControllerProvider.notifier).saveSkill(skill),
    );
  }

  void _delete() {
    saveAndClose(
      context,
      () => ref
          .read(profileControllerProvider.notifier)
          .deleteSkill(widget.skill!.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    // Una habilidad sin id (p. ej. una palabra clave sugerida) es nueva.
    final bool editing = widget.skill?.id.isNotEmpty ?? false;
    return Padding(
      // Mantiene el formulario por encima del teclado.
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              editing ? l10n.skillEdit : l10n.skillNew,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('skillName'),
              controller: _name,
              autofocus: !editing,
              decoration: InputDecoration(labelText: l10n.skillNameLabel),
              validator: (String? value) => requiredValidator(context, value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<SkillCategory>(
              initialValue: _category,
              decoration: InputDecoration(labelText: l10n.skillCategoryLabel),
              items: <DropdownMenuItem<SkillCategory>>[
                for (final SkillCategory category in SkillCategory.values)
                  DropdownMenuItem<SkillCategory>(
                    value: category,
                    child: Text(skillCategoryLabel(l10n, category)),
                  ),
              ],
              onChanged: (SkillCategory? value) =>
                  setState(() => _category = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('skillYears'),
              controller: _years,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: InputDecoration(labelText: l10n.skillYearsLabel),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: Text(l10n.save)),
            if (editing)
              TextButton(onPressed: _delete, child: Text(l10n.delete)),
          ],
        ),
      ),
    );
  }
}
