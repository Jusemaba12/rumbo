import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rumbo/features/applications/data/resume_pdf.dart';
import 'package:rumbo/features/applications/domain/application_draft.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  const profile = Profile(
    fullName: 'Juan Manzano',
    location: 'Bogotá, Colombia',
    email: 'juan@correo.com',
    phone: '320 000 0000',
    links: {'linkedin': 'https://linkedin.com/in/juan'},
  );

  test('la línea de contacto une los datos que hay', () {
    expect(
      resumeContactLine(profile),
      'Bogotá, Colombia  |  juan@correo.com  |  320 000 0000  |  '
      'https://linkedin.com/in/juan',
    );
    expect(
      resumeContactLine(const Profile(email: 'a@b.co', phone: ' ')),
      'a@b.co',
    );
  });

  test('el PDF lleva el nombre, el correo y el teléfono', () async {
    final bytes = await buildResumePdf(
      draft: ApplicationDraft(
        jobId: 'job-1',
        resume: TailoredResume(
          headline: 'Flutter Developer',
          summary: 'Apps con Flutter.',
          experiences: [
            TailoredExperience(
              experienceId: 'e1',
              company: 'GSE',
              role: 'Flutter Developer',
              startDate: DateTime(2024, 9),
              bullets: const ['Reduje el arranque'],
            ),
          ],
          skills: const ['Dart'],
        ),
        coverLetter: '',
      ),
      profile: profile,
      education: const [],
      compress: false,
    );
    // El PDF escribe cada palabra por separado: «(Juan)», «(Manzano)»…
    final text = latin1.decode(bytes);
    for (final word in ['Juan', 'Manzano', 'juan@correo.com', '320', '0000']) {
      expect(text, contains('($word)'));
    }
  });
}
