import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/services/ats_check.dart';
import 'package:rumbo/features/applications/domain/services/keyword_coverage.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';

const Profile _profile = Profile(
  fullName: 'Juan Manzano',
  email: 'juan@correo.com',
  phone: '+57 300 000 0000',
  location: 'Bogotá, Colombia',
  links: <String, String>{'linkedin': 'https://www.linkedin.com/in/juan'},
);

final ApplicationDraft _draft = ApplicationDraft(
  jobId: 'j',
  resume: TailoredResume(
    headline: 'Desarrollador Flutter',
    summary: 'Desarrollador móvil con 3 años de experiencia en Flutter.',
    experiences: <TailoredExperience>[
      TailoredExperience(
        experienceId: 'e1',
        company: 'GSE',
        role: 'Flutter Developer',
        startDate: DateTime(2024, 9),
        bullets: const <String>['Reduje el arranque un 40 %'],
      ),
      TailoredExperience(
        experienceId: 'e2',
        company: 'Acme Pagos',
        role: 'QA Analyst',
        startDate: DateTime(2022, 1),
        endDate: DateTime(2024, 8),
        bullets: const <String>['Automaticé pruebas de regresión'],
      ),
    ],
    skills: const <String>['Dart', 'Flutter', 'Riverpod'],
  ),
  coverLetter: '',
);

const List<Education> _education = <Education>[
  Education(institution: 'UFPS', degree: 'Ingeniería'),
];
const AtsHeadings _headings = (
  summary: 'Perfil profesional',
  experience: 'Experiencia',
  education: 'Estudios',
  skills: 'Habilidades',
);

// Texto real que pdf.js extrae del PDF de Rumbo (con un salto de línea en
// medio de una frase, como hace el lector).
const String _goodText = '''
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
    final List<AtsCheck> checks = _check(_goodText);
    expect(
      checks.where((AtsCheck c) => !c.passed).map((AtsCheck c) => c.kind),
      isEmpty,
    );
    expect(checks.map((AtsCheck c) => c.kind), contains(AtsCheckKind.link));
  });

  test('detecta lo que el ATS no puede leer', () {
    final String broken = _goodText
        .replaceAll('juan@correo.com', '')
        .replaceAll('HABILIDADES', '')
        .replaceAll('QA Analyst', 'Q� Analyst')
        .replaceAll(RegExp(r'(sept|ene|ago) (\d{4})'), r'01/2022');
    final Map<AtsCheckKind, String> failed = <AtsCheckKind, String>{
      for (final AtsCheck c in _check(broken, pages: 3))
        if (!c.passed) c.kind: c.detail,
    };
    expect(
      failed.keys,
      containsAll(<dynamic>[
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
    final Iterable<AtsCheck> failed = _check('Juan Manzano')
        .where((AtsCheck c) => !c.passed);
    expect(
      failed.map((AtsCheck c) => c.kind),
      contains(AtsCheckKind.completeness),
    );
  });

  test('cobertura de palabras clave de la oferta, base frente a adaptada', () {
    final KeywordCoverage coverage = keywordCoverage(
      job: const Job(
        title: 'Flutter Developer',
        company: 'Acme',
        requirements: <String>[
          'Riverpod o Bloc',
          'Experiencia con CI/CD',
          'Firebase',
        ],
        description: 'Buscamos experiencia en Flutter y RESTful APIs.',
      ),
      base: ProfileData(
        profile: const Profile(summary: 'Desarrollo apps con Flutter.'),
        skills: const <Skill>[
          Skill(name: 'Flutter'),
          Skill(name: 'Firebase'),
        ],
      ),
      tailored: const TailoredResume(
        summary: 'Flutter con Riverpod e integración de APIs REST.',
        skills: <String>['Flutter', 'Firebase', 'Riverpod'],
      ),
    );
    expect(
      coverage.keywords,
      containsAll(<dynamic>[
        'Flutter',
        'Riverpod',
        'Bloc',
        'CI/CD',
        'Firebase',
        'REST API',
      ]),
    );
    expect(coverage.inBase, <String>{'Flutter', 'Firebase'});
    expect(coverage.inTailored, containsAll(<dynamic>['Riverpod', 'REST API']));
    expect(coverage.tailoredPercent, greaterThan(coverage.basePercent));
    expect(coverage.missing, containsAll(<dynamic>['Bloc', 'CI/CD']));
  });
}
