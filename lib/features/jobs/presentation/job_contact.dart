import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../email/presentation/gmail_connect_screen.dart';
import '../../profile/presentation/form_helpers.dart';
import '../domain/job.dart';
import 'jobs_controller.dart';

String applyMethodLabel(AppLocalizations l10n, ApplyMethod method) =>
    switch (method) {
      ApplyMethod.email => l10n.applyMethodEmail,
      ApplyMethod.directMessage => l10n.applyMethodDirectMessage,
      ApplyMethod.portal => l10n.applyMethodPortal,
    };

/// Contacto del reclutador y forma de postular, en el detalle de la oferta.
class JobContactSection extends ConsumerWidget {
  const JobContactSection({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    void edit() => JobContactRoute(id: job.id).push<void>(context);
    if (!job.hasContact) {
      return Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          key: const Key('addContact'),
          leading: Icon(Icons.person_add_alt, color: context.colors.text),
          title: Text(l10n.contactAdd),
          trailing: const Icon(Icons.chevron_right),
          minTileHeight: 54,
          onTap: edit,
        ),
      );
    }
    final email = job.recruiterEmail;
    final linkedin = job.recruiterLinkedin;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.contactTitle,
                style: AppTheme.sectionTitle(context),
              ),
            ),
            TextButton.icon(
              key: const Key('editContact'),
              onPressed: edit,
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: Text(l10n.edit),
            ),
          ],
        ),
        Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              if (job.recruiterName case final name?)
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text(name),
                ),
              if (email != null)
                ListTile(
                  key: const Key('copyRecruiterEmail'),
                  leading: const Icon(Icons.mail_outline),
                  title: Text(email),
                  trailing: Icon(
                    Icons.copy,
                    size: 18,
                    color: context.colors.muted,
                  ),
                  onTap: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    await ref.read(clipboardWriterProvider)(email);
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.contactEmailCopied)),
                    );
                  },
                ),
              if (linkedin != null)
                ListTile(
                  leading: const Icon(Icons.open_in_new),
                  title: Text(l10n.contactLinkedin),
                  subtitle: Text(
                    linkedin,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => launchUrl(
                    Uri.parse(linkedin),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              if (job.applyMethod case final method?)
                ListTile(
                  leading: const Icon(Icons.how_to_reg_outlined),
                  title: Text(applyMethodLabel(l10n, method)),
                ),
              if (job.applySubject case final subject?)
                ListTile(
                  leading: const Icon(Icons.subject),
                  title: Text(l10n.contactSubject(subject)),
                ),
              if (job.asksSalary)
                ListTile(
                  leading: const Icon(Icons.payments_outlined),
                  title: Text(
                    l10n.contactAsksSalary,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Editar el contacto del reclutador y la forma de postular.
class JobContactScreen extends ConsumerStatefulWidget {
  const JobContactScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<JobContactScreen> createState() => _JobContactScreenState();
}

class _JobContactScreenState extends ConsumerState<JobContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _linkedin = TextEditingController();
  final _subject = TextEditingController();
  ApplyMethod? _method;
  bool _asksSalary = false;
  Job? _job;

  @override
  void initState() {
    super.initState();
    final job = ref
        .read(jobsControllerProvider)
        .value
        ?.firstWhereOrNull((item) => item.job.id == widget.jobId)
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
    for (final controller in [_name, _email, _linkedin, _subject]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _save() {
    final job = _job;
    if (job == null || !_formKey.currentState!.validate()) return;
    String? text(TextEditingController controller) {
      final value = controller.text.trim();
      return value.isEmpty ? null : value;
    }

    final updated = job.copyWith(
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
    final l10n = AppLocalizations.of(context);
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
      children: [
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
          validator: (value) {
            final text = value?.trim() ?? '';
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
          validator: (value) => optionalUrlValidator(context, value),
        ),
        DropdownButtonFormField<ApplyMethod?>(
          key: const Key('applyMethod'),
          isExpanded: true,
          initialValue: _method,
          decoration: InputDecoration(labelText: l10n.applyMethodLabel),
          items: [
            DropdownMenuItem(child: Text(l10n.applyMethodNone)),
            for (final method in ApplyMethod.values)
              DropdownMenuItem(
                value: method,
                child: Text(applyMethodLabel(l10n, method)),
              ),
          ],
          onChanged: (method) => setState(() => _method = method),
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
          onChanged: (value) => setState(() => _asksSalary = value),
        ),
      ],
    );
  }
}
