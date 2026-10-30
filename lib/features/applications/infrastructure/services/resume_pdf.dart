import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';

part 'resume_pdf.freezed.dart';

/// Títulos de sección en el idioma de la HV, no en el de la app.
@freezed
abstract class ResumeHeadings with _$ResumeHeadings {
  const factory ResumeHeadings(
    String locale,
    String summary,
    String experience,
    String education,
    String skills,
    String present,
  ) = _ResumeHeadings;

  static const ResumeHeadings es = ResumeHeadings(
    'es',
    'Perfil profesional',
    'Experiencia',
    'Estudios',
    'Habilidades',
    'Actualidad',
  );

  static ResumeHeadings of(ResumeLanguage language) =>
      language == ResumeLanguage.en ? en : es;

  static const ResumeHeadings en = ResumeHeadings(
    'en',
    'Summary',
    'Experience',
    'Education',
    'Skills',
    'Present',
  );
}

/// Línea de contacto de la HV: ubicación, correo, teléfono y enlaces.
String resumeContactLine(Profile profile) => <String>[
  profile.location,
  profile.email,
  profile.phone,
  ...profile.links.values,
].where((String item) => item.trim().isNotEmpty).join('  |  ');

/// HV de una columna con texto real, para que los ATS la lean bien:
/// sin tablas, columnas, iconos ni imágenes.
Future<Uint8List> buildResumePdf({
  required ApplicationDraft draft,
  required Profile profile,
  required List<Education> education,
  pw.Font? regular,
  pw.Font? bold,

  /// Solo para tests: sin comprimir, el texto se puede buscar en los bytes.
  bool compress = true,
}) {
  final ResumeHeadings h = ResumeHeadings.of(draft.language);
  final DateFormat month = DateFormat.yMMM(h.locale);
  String period(DateTime? start, DateTime? end) => <String>[
    if (start != null) month.format(start),
    end == null ? h.present : month.format(end),
  ].join(' – ');

  final pw.ThemeData theme = pw.ThemeData.withFont(base: regular, bold: bold);
  const PdfColor ink = PdfColor.fromInt(0xFF1A1A1A);
  const PdfColor muted = PdfColor.fromInt(0xFF555555);
  final TailoredResume resume = draft.resume;

  pw.Widget heading(String text) => pw.Padding(
    padding: const pw.EdgeInsets.only(top: 14, bottom: 4),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: <pw.Widget>[
        pw.Text(
          text.toUpperCase(),
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 10.5,
            letterSpacing: 0.8,
            color: ink,
          ),
        ),
        pw.Divider(height: 6, thickness: 0.6, color: muted),
      ],
    ),
  );

  final String contact = resumeContactLine(profile);

  final pw.Document document = pw.Document(
    title: profile.fullName,
    author: profile.fullName,
    theme: theme,
    compress: compress,
  );
  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 48, vertical: 42),
      build: (pw.Context context) => <pw.Widget>[
        pw.Text(
          profile.fullName,
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
            color: ink,
          ),
        ),
        if (resume.headline.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 2),
            child: pw.Text(
              resume.headline,
              style: const pw.TextStyle(fontSize: 12),
            ),
          ),
        if (contact.isNotEmpty)
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 4),
            child: pw.Text(
              contact,
              style: const pw.TextStyle(fontSize: 9, color: muted),
            ),
          ),
        if (resume.summary.isNotEmpty) ...<pw.Widget>[
          heading(h.summary),
          pw.Text(
            resume.summary,
            style: const pw.TextStyle(fontSize: 10, lineSpacing: 2),
          ),
        ],
        if (resume.experiences.isNotEmpty) heading(h.experience),
        for (final TailoredExperience experience in resume.experiences)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Expanded(
                      child: pw.Text(
                        '${experience.role} — ${experience.company}',
                        style: pw.TextStyle(
                          fontSize: 10.5,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Text(
                      period(experience.startDate, experience.endDate),
                      style: const pw.TextStyle(fontSize: 9, color: muted),
                    ),
                  ],
                ),
                for (final String bullet in experience.bullets)
                  pw.Bullet(
                    text: bullet,
                    style: const pw.TextStyle(fontSize: 10, lineSpacing: 1.5),
                    margin: const pw.EdgeInsets.only(top: 3, left: 6),
                    bulletSize: 2.6,
                  ),
              ],
            ),
          ),
        if (education.isNotEmpty) heading(h.education),
        for (final Education item in education)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 4),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Expanded(
                  child: pw.Text(
                    <String>[
                      item.degree,
                      item.institution,
                    ].where((String text) => text.isNotEmpty).join(' — '),
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
                if (item.startDate != null || item.endDate != null)
                  pw.Text(
                    period(item.startDate, item.endDate),
                    style: const pw.TextStyle(fontSize: 9, color: muted),
                  ),
              ],
            ),
          ),
        if (resume.skills.isNotEmpty) ...<pw.Widget>[
          heading(h.skills),
          pw.Text(
            resume.skills.join(', '),
            style: const pw.TextStyle(fontSize: 10),
          ),
        ],
      ],
    ),
  );
  return document.save();
}

/// Nombre de archivo legible: «HV Juan Manzano - Acme.pdf».
/// La HV base del perfil (sin adaptar a ninguna oferta) con el mismo
/// formato que las adaptadas, para descargarla desde la pestaña HV.
ApplicationDraft baseResumeDraft(ProfileData data) => ApplicationDraft(
  jobId: '',
  resume: TailoredResume(
    headline: data.profile.headline,
    summary: data.profile.summary,
    experiences: <TailoredExperience>[
      for (final Experience experience in data.experiences)
        TailoredExperience(
          experienceId: experience.id,
          company: experience.company,
          role: experience.role,
          startDate: experience.startDate,
          endDate: experience.endDate,
          bullets: experience.achievements,
        ),
    ],
    skills: <String>[for (final Skill skill in data.skills) skill.name],
  ),
);

String resumeFileName({required Profile profile, required String company}) {
  final List<String> parts = <String>[
    'HV',
    if (profile.fullName.isNotEmpty) profile.fullName,
    if (company.isNotEmpty) '- $company',
  ];
  return '${parts.join(' ').replaceAll(RegExp(r'[\\/:*?"<>|]'), '')}.pdf';
}
