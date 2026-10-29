import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rumbo/features/applications/data/resume_pdf.dart';
import 'package:rumbo/features/applications/data/resume_tailor.dart';
import 'package:rumbo/features/applications/data/resume_versions_repository.dart';
import 'package:rumbo/features/applications/domain/application_draft.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

Map<String, dynamic> _response() => {
  'language': 'en',
  'resume': {
    'headline': 'Flutter Developer',
    'summary': 'Mobile developer with 2 years of Flutter.',
    'experiences': [
      {
        'experience_id': 'e1',
        'company': 'GSE',
        'role': 'Flutter Developer',
        'start_date': '2024-09-01',
        'end_date': null,
        'bullets': ['Cut startup time by 40%'],
      },
    ],
    'skills': ['Dart', 'Riverpod'],
  },
  'cover_letter': 'Dear team…',
  'changes': [
    {
      'section': 'Summary',
      'before': 'Desarrollador',
      'after': 'Mobile developer',
      'reason': 'Matches the job language',
    },
  ],
  'keywords': ['Flutter', 'Riverpod'],
  'validation': {
    'rejected': ['Led a team of 8'],
    'summary_restored': false,
    'headline_restored': false,
  },
  'model': 'gemini-3.8-flash',
  'prompt_version': 'tailor-resume/v1',
};

void main() {
  setUpAll(() => initializeDateFormatting());

  test('convierte la respuesta de tailor-resume', () {
    final draft = applicationDraftFromJson('job-1', _response());
    expect(draft.jobId, 'job-1');
    expect(draft.language, ResumeLanguage.en);
    final experience = draft.resume.experiences.single;
    expect(experience.startDate, DateTime(2024, 9));
    expect(experience.endDate, isNull);
    expect(draft.changes.single.reason, 'Matches the job language');
    expect(draft.rejected, ['Led a team of 8']);
  });

  test('la versión guardada incluye idioma y carta', () {
    final draft = applicationDraftFromJson('job-1', _response());
    final row = resumeVersionToRow(draft.copyWith(coverLetter: 'Editada'));
    expect(row['job_id'], 'job-1');
    final content = row['content'] as Map<String, dynamic>;
    expect(content['cover_letter'], 'Editada');
    expect(content['language'], 'en');
    expect(content['headline'], 'Flutter Developer');
    expect((row['changes'] as List).single, containsPair('section', 'Summary'));
  });

  test('genera un PDF y un nombre de archivo limpio', () async {
    final draft = applicationDraftFromJson('job-1', _response());
    final bytes = await buildResumePdf(
      draft: draft,
      profile: const Profile(
        fullName: 'Juan Manzano',
        email: 'juan@example.com',
        location: 'Bogotá, Colombia',
      ),
      education: [
        Education(
          institution: 'Universidad Francisco de Paula Santander',
          degree: 'Ingeniería de Sistemas',
          endDate: DateTime(2022, 6),
        ),
      ],
    );
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    expect(bytes.length, greaterThan(1000));
    expect(
      resumeFileName(const Profile(fullName: 'Juan Manzano'), 'Acme/Labs'),
      'HV Juan Manzano - AcmeLabs.pdf',
    );
  });
}
