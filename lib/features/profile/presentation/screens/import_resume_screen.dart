import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/profile/application/use_cases/import_resume_use_case.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/failures/profile_failures.dart';
import 'package:rumbo/features/profile/domain/services/profile_import.dart';
import 'package:rumbo/features/profile/infrastructure/services/pdf_picker.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';

class ImportResumeScreen extends ConsumerStatefulWidget {
  const ImportResumeScreen({super.key});

  @override
  ConsumerState<ImportResumeScreen> createState() => _ImportResumeScreenState();
}

sealed class _Step {
  const _Step();
}

class _Idle extends _Step {
  const _Idle();
}

class _Reading extends _Step {
  const _Reading();
}

class _Review extends _Step {
  const _Review(this.plan);
  final ProfileImport plan;
}

class _Failed extends _Step {
  const _Failed(this.failure);
  final Failure failure;
}

class _ImportResumeScreenState extends ConsumerState<ImportResumeScreen> {
  _Step _step = const _Idle();
  bool _saving = false;

  Future<void> _pickAndRead() async {
    final ImportResumeUseCase importResume = ref.read(
      importResumeUseCaseProvider,
    );
    final Uint8List? pdf = await ref.read(pdfPickerProvider)();
    if (pdf == null || !importResume.isAvailable || !mounted) return;
    setState(() => _step = const _Reading());
    final Result<ProfileData> result = await importResume(pdf);
    switch (result) {
      case Ok<ProfileData>(value: final ProfileData imported):
        final ProfileData current = await ref.read(
          profileControllerProvider.future,
        );
        if (!mounted) return;
        setState(
          () => _step = _Review(
            planProfileImport(current: current, imported: imported),
          ),
        );
      case Err<ProfileData>(:final Failure failure):
        if (mounted) setState(() => _step = _Failed(failure));
    }
  }

  Future<void> _apply(ProfileImport plan) async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final NavigatorState navigator = Navigator.of(context);
    setState(() => _saving = true);
    final bool done = showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: await ref
          .read(profileControllerProvider.notifier)
          .applyImport(plan),
      success: l10n.importDone,
    );
    if (done) {
      navigator.pop();
    } else if (mounted) {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.importTitle)),
      body: SafeArea(
        child: switch (_step) {
          _Idle() => _Message(
            icon: Icons.upload_file,
            title: l10n.importIntro,
            body: l10n.importRules,
            action: FilledButton(
              onPressed: _pickAndRead,
              child: Text(l10n.importPick),
            ),
          ),
          _Reading() => _Message(
            icon: null,
            title: l10n.importReading,
            body: l10n.importReadingHint,
          ),
          _Failed(:final Failure failure) => _Message(
            icon: Icons.error_outline,
            title: switch (failure) {
              FileTooLargeFailure() => l10n.importErrorTooLarge,
              UnreadableFileFailure() => l10n.importErrorUnreadable,
              RateLimitedFailure() => l10n.importErrorRateLimited,
              _ => failureMessage(
                l10n: l10n,
                failure: failure,
                fallback: l10n.importErrorOther,
              ),
            },
            action: FilledButton(
              onPressed: _pickAndRead,
              child: Text(l10n.importPickAnother),
            ),
          ),
          _Review(:final ProfileImport plan) => _ReviewList(
            plan: plan,
            saving: _saving,
            onApply: () => _apply(plan),
            onPickAnother: _pickAndRead,
          ),
        },
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    required this.icon,
    required this.title,
    this.body,
    this.action,
  });

  /// Nulo muestra un indicador de progreso.
  final IconData? icon;
  final String title;
  final String? body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: icon == null
                  ? const CircularProgressIndicator()
                  : Icon(icon, size: 48, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (body != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                body!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...<Widget>[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class _ReviewList extends StatelessWidget {
  const _ReviewList({
    required this.plan,
    required this.saving,
    required this.onApply,
    required this.onPickAnother,
  });

  final ProfileImport plan;
  final bool saving;
  final VoidCallback onApply;
  final VoidCallback onPickAnother;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    if (plan.isEmpty) {
      return _Message(
        icon: Icons.check_circle_outline,
        title: l10n.importNothingNew,
        action: OutlinedButton(
          onPressed: onPickAnother,
          child: Text(l10n.importPickAnother),
        ),
      );
    }

    final Profile profile = plan.profile;
    final List<String> fieldLines = <String>[
      for (final ProfileField field in plan.filledFields)
        switch (field) {
          ProfileField.fullName => '${l10n.fullNameLabel}: ${profile.fullName}',
          ProfileField.headline => '${l10n.headlineLabel}: ${profile.headline}',
          ProfileField.location => '${l10n.locationLabel}: ${profile.location}',
          ProfileField.email => '${l10n.emailLabel}: ${profile.email}',
          ProfileField.phone => '${l10n.phoneLabel}: ${profile.phone}',
          ProfileField.summary => l10n.summaryLabel,
          ProfileField.links => profile.links.values.join('\n'),
        },
    ];

    Widget section(String title, List<String> lines) => Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 6),
          for (final String line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line),
            ),
        ],
      ),
    );

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Text(l10n.importReviewTitle, style: theme.textTheme.titleLarge),
              if (fieldLines.isNotEmpty) section(l10n.importFields, fieldLines),
              if (plan.experiences.isNotEmpty)
                section(l10n.sectionExperience, <String>[
                  for (final Experience e in plan.experiences)
                    '${e.role} · ${e.company}',
                ]),
              if (plan.projects.isNotEmpty)
                section(l10n.sectionProjects, <String>[
                  for (final Project p in plan.projects) p.name,
                ]),
              if (plan.education.isNotEmpty)
                section(l10n.sectionEducation, <String>[
                  for (final Education e in plan.education)
                    <String>[
                      e.degree,
                      e.institution,
                    ].where((String t) => t.isNotEmpty).join(' · '),
                ]),
              if (plan.skills.isNotEmpty)
                section(l10n.sectionSkills, <String>[
                  plan.skills.map((Skill s) => s.name).join(', '),
                ]),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FilledButton(
                onPressed: saving ? null : onApply,
                child: Text(l10n.importApply),
              ),
              TextButton(
                onPressed: saving ? null : onPickAnother,
                child: Text(l10n.importPickAnother),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
