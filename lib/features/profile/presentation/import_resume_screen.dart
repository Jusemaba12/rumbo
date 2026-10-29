import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/resume_importer.dart';
import '../domain/profile_import.dart';
import 'profile_controller.dart';

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
  const _Failed(this.reason);
  final ResumeImportFailure reason;
}

class _ImportResumeScreenState extends ConsumerState<ImportResumeScreen> {
  _Step _step = const _Idle();
  bool _saving = false;

  Future<void> _pickAndRead() async {
    final importer = ref.read(resumeImporterProvider);
    final pdf = await ref.read(pdfPickerProvider)();
    if (pdf == null || importer == null || !mounted) return;
    setState(() => _step = const _Reading());
    try {
      final imported = await importer.extract(pdf);
      final current = await ref.read(profileControllerProvider.future);
      if (!mounted) return;
      setState(() => _step = _Review(planProfileImport(current, imported)));
    } on ResumeImportException catch (error) {
      if (mounted) setState(() => _step = _Failed(error.reason));
    } catch (_) {
      if (mounted) {
        setState(() => _step = const _Failed(ResumeImportFailure.other));
      }
    }
  }

  Future<void> _apply(ProfileImport plan) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    setState(() => _saving = true);
    try {
      await ref.read(profileControllerProvider.notifier).applyImport(plan);
      messenger.showSnackBar(SnackBar(content: Text(l10n.importDone)));
      navigator.pop();
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
          _Failed(:final reason) => _Message(
            icon: Icons.error_outline,
            title: switch (reason) {
              ResumeImportFailure.tooLarge => l10n.importErrorTooLarge,
              ResumeImportFailure.unreadable => l10n.importErrorUnreadable,
              ResumeImportFailure.dailyLimit => l10n.aiErrorDailyLimit,
              ResumeImportFailure.rateLimited => l10n.importErrorRateLimited,
              ResumeImportFailure.busy => l10n.aiErrorBusy,
              ResumeImportFailure.other => l10n.importErrorOther,
            },
            action: FilledButton(
              onPressed: _pickAndRead,
              child: Text(l10n.importPickAnother),
            ),
          ),
          _Review(:final plan) => _ReviewList(
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
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            if (body != null) ...[
              const SizedBox(height: 8),
              Text(
                body!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[const SizedBox(height: 24), action!],
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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
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

    final profile = plan.profile;
    final fieldLines = [
      for (final field in plan.filledFields)
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
        children: [
          Text(title, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 6),
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line),
            ),
        ],
      ),
    );

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(l10n.importReviewTitle, style: theme.textTheme.titleLarge),
              if (fieldLines.isNotEmpty) section(l10n.importFields, fieldLines),
              if (plan.experiences.isNotEmpty)
                section(l10n.sectionExperience, [
                  for (final e in plan.experiences) '${e.role} · ${e.company}',
                ]),
              if (plan.projects.isNotEmpty)
                section(l10n.sectionProjects, [
                  for (final p in plan.projects) p.name,
                ]),
              if (plan.education.isNotEmpty)
                section(l10n.sectionEducation, [
                  for (final e in plan.education)
                    [
                      e.degree,
                      e.institution,
                    ].where((t) => t.isNotEmpty).join(' · '),
                ]),
              if (plan.skills.isNotEmpty)
                section(l10n.sectionSkills, [
                  plan.skills.map((s) => s.name).join(', '),
                ]),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
