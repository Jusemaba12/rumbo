import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_contact_section.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';

/// Editar el contacto del reclutador y la forma de postular.
class JobContactScreen extends ConsumerStatefulWidget {
  const JobContactScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<JobContactScreen> createState() => _JobContactScreenState();
}

class _JobContactScreenState extends ConsumerState<JobContactScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _linkedin = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  ApplyMethod? _method;
  bool _asksSalary = false;
  Job? _job;

  @override
  void initState() {
    super.initState();
    final Job? job = ref
        .read(jobsControllerProvider)
        .value
        ?.firstWhereOrNull((SavedJob item) => item.job.id == widget.jobId)
        ?.job;
    if (job == null) return;
    _job = job;
    _name.text = job.recruiterName ?? '';
    _email.text = job.recruiterEmail ?? '';
    _linkedin.text = job.recruiterLinkedin ?? '';
    _subject.text = job.applySubject ?? '';
    _method = job.applyMethod;
    _asksSalary = job.asksSalary;
  }

  @override
  void dispose() {
    for (final TextEditingController controller in <TextEditingController>[
      _name,
      _email,
      _linkedin,
      _subject,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _save() {
    final Job? job = _job;
    if (job == null || !_formKey.currentState!.validate()) return;
    String? text(TextEditingController controller) {
      final String value = controller.text.trim();
      return value.isEmpty ? null : value;
    }

    final Job updated = job.copyWith(
      recruiterName: text(_name),
      recruiterEmail: text(_email),
      recruiterLinkedin: text(_linkedin),
      applySubject: text(_subject),
      applyMethod: _method,
      asksSalary: _asksSalary,
    );
    saveAndClose(
      context,
      () => ref.read(jobsControllerProvider.notifier).updateContact(updated),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    if (_job == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.jobNotFound)),
      );
    }
    return ProfileFormScaffold(
      title: l10n.contactTitle,
      formKey: _formKey,
      onSave: _save,
      children: <Widget>[
        TextFormField(
          key: const Key('recruiterName'),
          controller: _name,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(labelText: l10n.contactNameLabel),
        ),
        TextFormField(
          key: const Key('recruiterEmail'),
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          decoration: InputDecoration(labelText: l10n.contactEmailLabel),
          validator: (String? value) {
            final String text = value?.trim() ?? '';
            return text.isEmpty ||
                    RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)
                ? null
                : l10n.emailInvalid;
          },
        ),
        TextFormField(
          key: const Key('recruiterLinkedin'),
          controller: _linkedin,
          keyboardType: TextInputType.url,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: l10n.contactLinkedinLabel,
            helperText: l10n.contactLinkedinHelper,
          ),
          validator: (String? value) => optionalUrlValidator(context, value),
        ),
        DropdownButtonFormField<ApplyMethod?>(
          key: const Key('applyMethod'),
          isExpanded: true,
          initialValue: _method,
          decoration: InputDecoration(labelText: l10n.applyMethodLabel),
          items: <DropdownMenuItem<ApplyMethod?>>[
            DropdownMenuItem<ApplyMethod?>(child: Text(l10n.applyMethodNone)),
            for (final ApplyMethod method in ApplyMethod.values)
              DropdownMenuItem<ApplyMethod?>(
                value: method,
                child: Text(applyMethodLabel(l10n, method)),
              ),
          ],
          onChanged: (ApplyMethod? method) => setState(() => _method = method),
        ),
        TextFormField(
          key: const Key('applySubject'),
          controller: _subject,
          decoration: InputDecoration(
            labelText: l10n.contactSubjectLabel,
            helperText: l10n.contactSubjectHelper,
            helperMaxLines: 2,
          ),
        ),
        SwitchListTile(
          key: const Key('asksSalary'),
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.contactAsksSalaryLabel),
          value: _asksSalary,
          onChanged: (bool value) => setState(() => _asksSalary = value),
        ),
      ],
    );
  }
}
