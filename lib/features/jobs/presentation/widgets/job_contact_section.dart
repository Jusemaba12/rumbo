import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/email/infrastructure/services/mail_services.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
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
    final String? email = job.recruiterEmail;
    final String? linkedin = job.recruiterLinkedin;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
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
            children: <Widget>[
              if (job.recruiterName case final String name?)
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
                    final ScaffoldMessengerState messenger =
                        ScaffoldMessenger.of(context);
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
              if (job.applyMethod case final ApplyMethod method?)
                ListTile(
                  leading: const Icon(Icons.how_to_reg_outlined),
                  title: Text(applyMethodLabel(l10n, method)),
                ),
              if (job.applySubject case final String subject?)
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
