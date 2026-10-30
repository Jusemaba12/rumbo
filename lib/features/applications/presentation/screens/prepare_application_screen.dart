import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rumbo/features/applications/application/use_cases/read_as_ats_use_case.dart';
import 'package:rumbo/features/applications/application/use_cases/save_resume_version_use_case.dart';
import 'package:rumbo/features/applications/application/use_cases/tailor_resume_use_case.dart';
import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/failures/application_failures.dart';
import 'package:rumbo/features/applications/domain/repositories/ats_reader.dart';
import 'package:rumbo/features/applications/domain/services/ats_check.dart';
import 'package:rumbo/features/applications/domain/services/keyword_coverage.dart';
import 'package:rumbo/features/applications/infrastructure/services/pdf_services.dart';
import 'package:rumbo/features/applications/infrastructure/services/resume_pdf.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/applications/presentation/widgets/ats_widgets.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/entities/resume_keyword.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/features/profile/presentation/providers/resume_keywords/resume_keywords_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';
import 'package:rumbo/shared/utils/log.dart';

class PrepareApplicationScreen extends ConsumerStatefulWidget {
  const PrepareApplicationScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<PrepareApplicationScreen> createState() =>
      _PrepareApplicationScreenState();
}

class _PrepareApplicationScreenState
    extends ConsumerState<PrepareApplicationScreen> {
  ApplicationDraft? _draft;
  Failure? _failure;
  bool _busy = false;
  bool _saved = false;
  late final TextEditingController _letter = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tailor();
  }

  @override
  void dispose() {
    _letter.dispose();
    super.dispose();
  }

  Future<void> _tailor() async {
    final TailorResumeUseCase tailorResume = ref.read(
      tailorResumeUseCaseProvider,
    );
    if (!tailorResume.isAvailable) return;
    setState(() {
      _failure = null;
      _draft = null;
      _saved = false;
    });
    final Result<ApplicationDraft> result = await tailorResume(widget.jobId);
    if (!mounted) return;
    switch (result) {
      case Ok<ApplicationDraft>(value: final ApplicationDraft draft):
        _letter.text = draft.coverLetter;
        setState(() => _draft = draft);
      case Err<ApplicationDraft>(:final Failure failure):
        setState(() => _failure = failure);
    }
  }

  ApplicationDraft get _currentDraft =>
      _draft!.copyWith(coverLetter: _letter.text.trim());

  /// El PDF que se envía, igual para exportarlo que para probarlo.
  Future<Uint8List> _buildPdf() async {
    final ProfileData profile = await ref.read(
      profileControllerProvider.future,
    );
    final (pw.Font, pw.Font)? fonts = await ref.read(
      resumeFontsProvider.future,
    );
    return buildResumePdf(
      draft: _currentDraft,
      profile: profile.profile,
      education: profile.education,
      regular: fonts?.$1,
      bold: fonts?.$2,
    );
  }

  Future<void> _exportPdf() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final ProfileData profile = await ref.read(
        profileControllerProvider.future,
      );
      final Job? job = ref
          .read(jobsControllerProvider)
          .value
          ?.firstWhereOrNull((SavedJob item) => item.job.id == widget.jobId)
          ?.job;
      final Uint8List bytes = await _buildPdf();
      await ref.read(pdfSharerProvider)(
        bytes,
        resumeFileName(profile: profile.profile, company: job?.company ?? ''),
      );
    } catch (error) {
      Log.w(tag: 'PrepareApplicationScreen', message: 'resume pdf: $error');
      messenger.showSnackBar(SnackBar(content: Text(l10n.pdfError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _save() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    final ApplicationDraft draft = _currentDraft;
    final Result<String> version = await ref.read(
      saveResumeVersionUseCaseProvider,
    )(draft);
    // La oferta pasa al tablero como «Preparando», con esta HV y carta.
    final Result<void> result = await version.andThen(
      (String versionId) => ref
          .read(applicationsControllerProvider.notifier)
          .startForJob(
            draft.jobId,
            resumeVersionId: versionId,
            coverLetter: draft.coverLetter,
          ),
    );
    // El botón pasa a «Guardada»; un aviso taparía los botones de abajo.
    showResultSnackBar(messenger: messenger, l10n: l10n, result: result);
    if (mounted) {
      setState(() {
        _busy = false;
        _saved = result.isOk;
      });
    }
  }

  Future<void> _copyLetter() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: _letter.text));
    messenger.showSnackBar(SnackBar(content: Text(l10n.letterCopied)));
  }

  /// Genera el PDF, lo lee como un ATS y muestra qué reconoce.
  Future<void> _testAts() async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final ReadAsAtsUseCase readAsAts = ref.read(readAsAtsUseCaseProvider);
    if (!readAsAts.isAvailable) return;
    setState(() => _busy = true);
    try {
      final ProfileData profile = await ref.read(
        profileControllerProvider.future,
      );
      final ApplicationDraft draft = _currentDraft;
      final AtsReading reading = (await readAsAts(await _buildPdf()))
          .getOrThrow();
      final ResumeHeadings headings = ResumeHeadings.of(draft.language);
      final List<AtsCheck> checks = checkAtsText(
        text: reading.text,
        pages: reading.pages,
        profile: profile.profile,
        draft: draft,
        education: profile.education,
        headings: (
          summary: headings.summary,
          experience: headings.experience,
          education: headings.education,
          skills: headings.skills,
        ),
      );
      if (!mounted) return;
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        // Por encima de la barra de pestañas.
        useRootNavigator: true,
        builder: (BuildContext context) =>
            AtsResultSheet(checks: checks, text: reading.text),
      );
    } catch (error) {
      Log.w(tag: 'PrepareApplicationScreen', message: 'ats test: $error');
      messenger.showSnackBar(SnackBar(content: Text(l10n.atsError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ApplicationDraft? draft = _draft;
    final Failure? failure = _failure;
    if (failure != null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.prepareTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  failure is EmptyProfileFailure
                      ? l10n.prepareEmptyProfile
                      : failureMessage(
                          l10n: l10n,
                          failure: failure,
                          fallback: l10n.prepareError,
                        ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(onPressed: _tailor, child: Text(l10n.retry)),
              ],
            ),
          ),
        ),
      );
    }
    if (draft == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.prepareTitle)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                l10n.preparing,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(l10n.preparingHint),
            ],
          ),
        ),
      );
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.prepareTitle),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: l10n.tabResumePreview),
              Tab(text: l10n.tabCoverLetter),
              Tab(text: l10n.tabChanges),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  _ResumePreview(
                    draft: draft,
                    onTestAts:
                        !ref.watch(readAsAtsUseCaseProvider).isAvailable ||
                            _busy
                        ? null
                        : _testAts,
                  ),
                  _LetterEditor(controller: _letter, onCopy: _copyLetter),
                  _ChangesList(draft: draft),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _busy || _saved ? null : _save,
                        icon: Icon(_saved ? Icons.check : Icons.save_outlined),
                        label: Text(
                          _saved ? l10n.versionSavedShort : l10n.saveVersion,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _busy ? null : _exportPdf,
                        icon: const Icon(Icons.picture_as_pdf_outlined),
                        label: Text(l10n.exportPdf),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Vista previa con lo mismo que lleva el PDF: nombre y contacto del perfil,
/// cargo, perfil, experiencia, estudios y habilidades.
class _ResumePreview extends ConsumerWidget {
  const _ResumePreview({required this.draft, this.onTestAts});

  final ApplicationDraft draft;

  /// Prueba el PDF como un ATS; nulo si no está disponible.
  final VoidCallback? onTestAts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final TextStyle? muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final DateFormat month = DateFormat.yMMM(draft.language.name);
    String period(DateTime? start, DateTime? end) => <String>[
      if (start != null) month.format(start),
      end == null ? l10n.present : month.format(end),
    ].join(' – ');
    final TailoredResume resume = draft.resume;
    final ProfileData? data = ref.watch(profileControllerProvider).value;
    final Profile? profile = data?.profile;
    final List<Education> education = data?.education ?? const <Education>[];
    final bool missingContact =
        profile != null &&
        (profile.email.trim().isEmpty || profile.phone.trim().isEmpty);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        if (onTestAts != null) ...<Widget>[
          OutlinedButton.icon(
            key: const Key('testAts'),
            onPressed: onTestAts,
            icon: const Icon(Icons.fact_check_outlined),
            label: Text(l10n.atsTest),
          ),
          const SizedBox(height: 16),
        ],
        if (missingContact) ...<Widget>[
          NoticeBanner(
            key: const Key('missingContact'),
            text: l10n.resumeMissingContact,
            icon: Icons.contact_mail_outlined,
            action: TextButton(
              onPressed: () => const ProfileBasicsRoute().push(context),
              child: Text(l10n.edit),
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (profile != null && profile.fullName.isNotEmpty)
          Text(profile.fullName, style: theme.textTheme.headlineSmall),
        if (resume.headline.isNotEmpty)
          Text(resume.headline, style: theme.textTheme.titleMedium),
        if (profile != null &&
            resumeContactLine(profile).isNotEmpty) ...<Widget>[
          const SizedBox(height: 4),
          Text(
            resumeContactLine(profile),
            key: const Key('resumeContact'),
            style: muted,
          ),
        ],
        const SizedBox(height: 12),
        Text(resume.summary),
        for (final TailoredExperience experience
            in resume.experiences) ...<Widget>[
          const SizedBox(height: 20),
          Text(
            '${experience.role} · ${experience.company}',
            style: AppTheme.sectionTitle(context),
          ),
          Text(
            period(experience.startDate, experience.endDate),
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          for (final String bullet in experience.bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('•  $bullet'),
            ),
        ],
        if (education.isNotEmpty) ...<Widget>[
          const SizedBox(height: 20),
          Text(l10n.sectionEducation, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 6),
          for (final Education item in education)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                <String>[
                  <String>[
                    item.degree,
                    item.institution,
                  ].where((String text) => text.isNotEmpty).join(' — '),
                  if (item.startDate != null || item.endDate != null)
                    period(item.startDate, item.endDate),
                ].join(' · '),
              ),
            ),
        ],
        const SizedBox(height: 20),
        Text(l10n.sectionSkills, style: AppTheme.sectionTitle(context)),
        const SizedBox(height: 6),
        Text(resume.skills.join(', ')),
      ],
    );
  }
}

class _LetterEditor extends StatelessWidget {
  const _LetterEditor({required this.controller, required this.onCopy});

  final TextEditingController controller;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        TextField(
          key: const Key('coverLetter'),
          controller: controller,
          minLines: 12,
          maxLines: null,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.tabCoverLetter,
            helperText: l10n.letterHelper,
            helperMaxLines: 2,
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: onCopy,
            icon: const Icon(Icons.copy),
            label: Text(l10n.copyLetter),
          ),
        ),
      ],
    );
  }
}

class _ChangesList extends ConsumerWidget {
  const _ChangesList({required this.draft});

  final ApplicationDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final Job? job = ref
        .watch(jobsControllerProvider)
        .value
        ?.firstWhereOrNull((SavedJob item) => item.job.id == draft.jobId)
        ?.job;
    final ProfileData? base = ref.watch(profileControllerProvider).value;
    final KeywordCoverage? coverage = job == null || base == null
        ? null
        : keywordCoverage(
            job: job,
            base: base,
            tailored: draft.resume,
            extra: <String>[
              for (final ResumeKeyword k
                  in ref.watch(resumeKeywordsProvider).value?.keywords ??
                      const <ResumeKeyword>[])
                k.keyword,
            ],
          );
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        if (coverage != null && coverage.keywords.isNotEmpty) ...<Widget>[
          CoverageCard(coverage: coverage),
          const SizedBox(height: 20),
        ],
        if (draft.keywords.isNotEmpty) ...<Widget>[
          Text(l10n.keywordsCovered, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              for (final String keyword in draft.keywords)
                Chip(label: Text(keyword)),
            ],
          ),
          const SizedBox(height: 20),
        ],
        for (final ResumeChange change in draft.changes)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(change.section, style: theme.textTheme.titleSmall),
                  if (change.before.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 6),
                    Text(
                      change.before,
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    change.after,
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                  if (change.reason.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 6),
                    Text(change.reason, style: theme.textTheme.bodySmall),
                  ],
                ],
              ),
            ),
          ),
        if (draft.rejected.isNotEmpty) ...<Widget>[
          const SizedBox(height: 8),
          Text(l10n.rejectedTitle, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 4),
          Text(l10n.rejectedBody, style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          for (final String text in draft.rejected)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '•  $text',
                style: theme.textTheme.bodySmall?.copyWith(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
        ],
      ],
    );
  }
}

/// Botón de la ficha de la oferta que abre esta pantalla.
class PrepareApplicationButton extends StatelessWidget {
  const PrepareApplicationButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      key: const Key('prepareApplication'),
      onPressed: onPressed,
      icon: const Icon(Icons.auto_awesome_outlined),
      label: Text(context.l10n.prepareApplication),
    );
  }
}
