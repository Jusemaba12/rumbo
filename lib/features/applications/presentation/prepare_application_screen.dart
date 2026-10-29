import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../../jobs/presentation/jobs_controller.dart';
import '../../profile/data/resume_keywords.dart';
import '../../profile/domain/profile.dart';
import '../../profile/presentation/profile_controller.dart';
import '../data/ats_reader.dart';
import '../data/resume_pdf.dart';
import '../data/resume_tailor.dart';
import '../data/resume_versions_repository.dart';
import '../domain/application_draft.dart';
import '../domain/ats_check.dart';
import '../domain/keyword_coverage.dart';
import 'applications_controller.dart';
import 'ats_widgets.dart';

part 'prepare_application_screen.g.dart';

/// Comparte el PDF (guardar en Archivos, enviar por correo, etc.).
typedef PdfSharer = Future<void> Function(List<int> bytes, String fileName);

@Riverpod(keepAlive: true)
PdfSharer pdfSharer(Ref ref) =>
    (bytes, fileName) =>
        Printing.sharePdf(bytes: Uint8List.fromList(bytes), filename: fileName);

/// Fuentes con tildes y eñes; se descargan una vez y quedan en caché.
@Riverpod(keepAlive: true)
Future<(pw.Font, pw.Font)?> resumeFonts(Ref ref) async {
  try {
    return (
      await PdfGoogleFonts.notoSansRegular(),
      await PdfGoogleFonts.notoSansBold(),
    );
  } catch (_) {
    return null;
  }
}

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
  TailorFailure? _failure;
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
    final tailor = ref.read(resumeTailorProvider);
    if (tailor == null) return;
    setState(() {
      _failure = null;
      _draft = null;
      _saved = false;
    });
    try {
      final draft = await tailor.tailor(widget.jobId);
      if (!mounted) return;
      _letter.text = draft.coverLetter;
      setState(() => _draft = draft);
    } on TailorException catch (error) {
      if (mounted) setState(() => _failure = error.reason);
    } catch (error) {
      debugPrint('tailor-resume: $error');
      if (mounted) setState(() => _failure = TailorFailure.other);
    }
  }

  ApplicationDraft get _currentDraft =>
      _draft!.copyWith(coverLetter: _letter.text.trim());

  /// El PDF que se envía, igual para exportarlo que para probarlo.
  Future<Uint8List> _buildPdf() async {
    final profile = await ref.read(profileControllerProvider.future);
    final fonts = await ref.read(resumeFontsProvider.future);
    return buildResumePdf(
      draft: _currentDraft,
      profile: profile.profile,
      education: profile.education,
      regular: fonts?.$1,
      bold: fonts?.$2,
    );
  }

  Future<void> _exportPdf() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final profile = await ref.read(profileControllerProvider.future);
      final job = ref
          .read(jobsControllerProvider)
          .value
          ?.firstWhereOrNull((item) => item.job.id == widget.jobId)
          ?.job;
      final bytes = await _buildPdf();
      await ref.read(pdfSharerProvider)(
        bytes,
        resumeFileName(profile.profile, job?.company ?? ''),
      );
    } catch (error) {
      debugPrint('resume pdf: $error');
      messenger.showSnackBar(SnackBar(content: Text(l10n.pdfError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final draft = _currentDraft;
      final versionId = await ref
          .read(resumeVersionsRepositoryProvider)
          .save(draft);
      // La oferta pasa al tablero como «Preparando», con esta HV y carta.
      await ref
          .read(applicationsControllerProvider.notifier)
          .startForJob(
            draft.jobId,
            resumeVersionId: versionId,
            coverLetter: draft.coverLetter,
          );
      // El botón pasa a «Guardada»; un aviso taparía los botones de abajo.
      if (mounted) setState(() => _saved = true);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _copyLetter() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: _letter.text));
    messenger.showSnackBar(SnackBar(content: Text(l10n.letterCopied)));
  }

  /// Genera el PDF, lo lee como un ATS y muestra qué reconoce.
  Future<void> _testAts() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final reader = ref.read(atsReaderProvider);
    if (reader == null) return;
    setState(() => _busy = true);
    try {
      final profile = await ref.read(profileControllerProvider.future);
      final draft = _currentDraft;
      final reading = await reader.read(await _buildPdf());
      final headings = ResumeHeadings.of(draft.language);
      final checks = checkAtsText(
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
        builder: (context) =>
            AtsResultSheet(checks: checks, text: reading.text),
      );
    } catch (error) {
      debugPrint('ats test: $error');
      messenger.showSnackBar(SnackBar(content: Text(l10n.atsError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final draft = _draft;
    final failure = _failure;
    if (failure != null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.prepareTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(switch (failure) {
                  TailorFailure.emptyProfile => l10n.prepareEmptyProfile,
                  TailorFailure.dailyLimit => l10n.aiErrorDailyLimit,
                  TailorFailure.rateLimited => l10n.aiErrorRateLimited,
                  TailorFailure.busy => l10n.aiErrorBusy,
                  TailorFailure.other => l10n.prepareError,
                }, textAlign: TextAlign.center),
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
            children: [
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
            tabs: [
              Tab(text: l10n.tabResumePreview),
              Tab(text: l10n.tabCoverLetter),
              Tab(text: l10n.tabChanges),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  _ResumePreview(
                    draft: draft,
                    onTestAts: ref.watch(atsReaderProvider) == null || _busy
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
                  children: [
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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final month = DateFormat.yMMM(draft.language.name);
    String period(DateTime? start, DateTime? end) => [
      if (start != null) month.format(start),
      end == null ? l10n.present : month.format(end),
    ].join(' – ');
    final resume = draft.resume;
    final data = ref.watch(profileControllerProvider).value;
    final profile = data?.profile;
    final education = data?.education ?? const <Education>[];
    final missingContact =
        profile != null &&
        (profile.email.trim().isEmpty || profile.phone.trim().isEmpty);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (onTestAts != null) ...[
          OutlinedButton.icon(
            key: const Key('testAts'),
            onPressed: onTestAts,
            icon: const Icon(Icons.fact_check_outlined),
            label: Text(l10n.atsTest),
          ),
          const SizedBox(height: 16),
        ],
        if (missingContact) ...[
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
        if (profile != null && resumeContactLine(profile).isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            resumeContactLine(profile),
            key: const Key('resumeContact'),
            style: muted,
          ),
        ],
        const SizedBox(height: 12),
        Text(resume.summary),
        for (final experience in resume.experiences) ...[
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
          for (final bullet in experience.bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('•  $bullet'),
            ),
        ],
        if (education.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(l10n.sectionEducation, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 6),
          for (final item in education)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                [
                  [
                    item.degree,
                    item.institution,
                  ].where((text) => text.isNotEmpty).join(' — '),
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
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final job = ref
        .watch(jobsControllerProvider)
        .value
        ?.firstWhereOrNull((item) => item.job.id == draft.jobId)
        ?.job;
    final base = ref.watch(profileControllerProvider).value;
    final coverage = job == null || base == null
        ? null
        : keywordCoverage(
            job: job,
            base: base,
            tailored: draft.resume,
            extra: [
              for (final k
                  in ref.watch(resumeKeywordsProvider).value?.keywords ??
                      const <ResumeKeyword>[])
                k.keyword,
            ],
          );
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (coverage != null && coverage.keywords.isNotEmpty) ...[
          CoverageCard(coverage: coverage),
          const SizedBox(height: 20),
        ],
        if (draft.keywords.isNotEmpty) ...[
          Text(l10n.keywordsCovered, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final keyword in draft.keywords) Chip(label: Text(keyword)),
            ],
          ),
          const SizedBox(height: 20),
        ],
        for (final change in draft.changes)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(change.section, style: theme.textTheme.titleSmall),
                  if (change.before.isNotEmpty) ...[
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
                  if (change.reason.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(change.reason, style: theme.textTheme.bodySmall),
                  ],
                ],
              ),
            ),
          ),
        if (draft.rejected.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(l10n.rejectedTitle, style: AppTheme.sectionTitle(context)),
          const SizedBox(height: 4),
          Text(l10n.rejectedBody, style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          for (final text in draft.rejected)
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
      label: Text(AppLocalizations.of(context).prepareApplication),
    );
  }
}
