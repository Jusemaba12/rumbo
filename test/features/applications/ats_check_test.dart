import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/applications/domain/application_draft.dart';
import 'package:rumbo/features/applications/domain/ats_check.dart';
import 'package:rumbo/features/applications/domain/keyword_coverage.dart';
import 'package:rumbo/features/jobs/domain/job.dart';
import 'package:rumbo/features/profile/domain/profile.dart';

const _profile = Profile(
  fullName: 'Juan Manzano',
  email: 'juan@correo.com',
  phone: '+57 300 000 0000',
  location: 'Bogotá, Colombia',
  links: {'linkedin': 'https://www.linkedin.com/in/juan'},
);

final _draft = ApplicationDraft(
  jobId: 'j',
  resume: TailoredResume(
    headline: 'Desarrollador Flutter',
    summary: 'Desarrollador móvil con 3 años de experiencia en Flutter.',
    experiences: [
      TailoredExperience(
        experienceId: 'e1',
        company: 'GSE',
        role: 'Flutter Developer',
        startDate: DateTime(2024, 9),
        bullets: const ['Reduje el arranque un 40 %'],
      ),
      TailoredExperience(
        experienceId: 'e2',
        company: 'Acme Pagos',
        role: 'QA Analyst',
        startDate: DateTime(2022, 1),
        endDate: DateTime(2024, 8),
        bullets: const ['Automaticé pruebas de regresión'],
      ),
    ],
    skills: const ['Dart', 'Flutter', 'Riverpod'],
  ),
  coverLetter: '',
);

const _education = [Education(institution: 'UFPS', degree: 'Ingeniería')];
const AtsHeadings _headings = (
  summary: 'Perfil profesional',
  experience: 'Experiencia',
  education: 'Estudios',
  skills: 'Habilidades',
);

// Texto real que pdf.js extrae del PDF de Rumbo (con un salto de línea en
// medio de una frase, como hace el lector).
const _goodText = '''
Juan Manzano
 Desarrollador Flutter
 Bogotá, Colombia | juan@correo.com | +57 300 000 0000 | https://www.linkedin.com/in/juan
 PERFIL PROFESIONAL
 Desarrollador móvil con 3 años de experiencia en
Flutter.
 EXPERIENCIA
 Flutter Developer — GSE sept 2024 – Actualidad
 Reduje el arranque un 40 %
 QA Analyst — Acme Pagos ene 2022 – ago 2024
 Automaticé pruebas de regresión
 ESTUDIOS
 Ingeniería — UFPS
 HABILIDADES
 Dart, Flutter, Riverpod
''';

List<AtsCheck> _check(String text, {int pages = 1}) => checkAtsText(
  text: text,
  pages: pages,
  profile: _profile,
  draft: _draft,
  education: _education,
  headings: _headings,
);

void main() {
  test('el PDF de Rumbo pasa todas las comprobaciones', () {
    final checks = _check(_goodText);
    expect(checks.where((c) => !c.passed).map((c) => c.kind), isEmpty);
    expect(checks.map((c) => c.kind), contains(AtsCheckKind.link));
  });

  test('detecta lo que el ATS no puede leer', () {
    final broken = _goodText
        .replaceAll('juan@correo.com', '')
        .replaceAll('HABILIDADES', '')
        .replaceAll('QA Analyst', 'Q� Analyst')
        .replaceAll(RegExp(r'(sept|ene|ago) (\d{4})'), r'01/2022');
    final failed = {
      for (final c in _check(broken, pages: 3))
        if (!c.passed) c.kind: c.detail,
    };
    expect(
      failed.keys,
      containsAll([
        AtsCheckKind.email,
        AtsCheckKind.sections,
        AtsCheckKind.experiences,
        AtsCheckKind.dates,
        AtsCheckKind.characters,
        AtsCheckKind.pages,
      ]),
    );
    expect(failed[AtsCheckKind.sections], 'Habilidades');
    expect(failed[AtsCheckKind.experiences], 'QA Analyst — Acme Pagos');
  });

  test('si casi no hay texto, el PDF no es legible', () {
    final failed = _check('Juan Manzano').where((c) => !c.passed);
    expect(failed.map((c) => c.kind), contains(AtsCheckKind.completeness));
  });

  test('cobertura de palabras clave de la oferta, base frente a adaptada', () {
    final coverage = keywordCoverage(
      job: const Job(
        title: 'Flutter Developer',
        company: 'Acme',
        requirements: ['Riverpod o Bloc', 'Experiencia con CI/CD', 'Firebase'],
        description: 'Buscamos experiencia en Flutter y RESTful APIs.',
      ),
      base: ProfileData(
        profile: const Profile(summary: 'Desarrollo apps con Flutter.'),
        skills: const [
          Skill(name: 'Flutter'),
          Skill(name: 'Firebase'),
        ],
      ),
      tailored: const TailoredResume(
        summary: 'Flutter con Riverpod e integración de APIs REST.',
        skills: ['Flutter', 'Firebase', 'Riverpod'],
      ),
    );
    expect(
      coverage.keywords,
      containsAll([
        'Flutter',
        'Riverpod',
        'Bloc',
        'CI/CD',
        'Firebase',
        'REST API',
      ]),
    );
    expect(coverage.inBase, {'Flutter', 'Firebase'});
    expect(coverage.inTailored, containsAll(['Riverpod', 'REST API']));
    expect(coverage.tailoredPercent, greaterThan(coverage.basePercent));
    expect(coverage.missing, containsAll(['Bloc', 'CI/CD']));
  });
}
