import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';
part 'job.g.dart';

enum WorkMode { remote, hybrid, onsite }

/// Cómo pide la publicación que se postule.
enum ApplyMethod {
  email,
  @JsonValue('direct_message')
  directMessage,
  portal,
}

/// Oferta de empleo guardada. Un [id] vacío significa que aún no se guardó.
@freezed
abstract class Job with _$Job {
  const Job._();

  const factory Job({
    @Default('') String id,
    @Default('link') String source,
    String? url,
    required String title,
    required String company,
    @Default('') String location,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    WorkMode? workMode,
    @Default('') String description,
    @Default([]) List<String> requirements,
    double? salaryMin,
    double? salaryMax,
    String? salaryCurrency,
    DateTime? createdAt,

    /// Encontrada por la búsqueda automática y aún no guardada.
    @Default(false) bool discovered,

    /// Sugerencia descartada; se conserva para no volver a sugerirla.
    @Default(false) bool dismissed,

    /// Contacto que da la publicación (lo extrae la IA o lo escribe el
    /// usuario). [recruiterLinkedin] es el perfil o la publicación.
    String? recruiterName,
    String? recruiterEmail,
    String? recruiterLinkedin,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    ApplyMethod? applyMethod,

    /// Asunto exacto que pide la publicación para el correo.
    String? applySubject,

    /// La publicación pide indicar la expectativa salarial.
    @Default(false) bool asksSalary,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  bool get isSuggestion => discovered && !dismissed;

  /// Llegó sin la descripción completa (p. ej. alertas de LinkedIn): la
  /// compatibilidad sale solo del título.
  bool get needsDescription =>
      description.trim().length < minJobDescriptionChars;
  bool get isSaved => !discovered && !dismissed;

  bool get hasContact =>
      recruiterName != null ||
      recruiterEmail != null ||
      recruiterLinkedin != null ||
      applyMethod != null ||
      applySubject != null;

  /// Se postula enviando la HV a un correo.
  bool get appliesByEmail =>
      recruiterEmail != null &&
      (applyMethod == null || applyMethod == ApplyMethod.email);

  /// Identifica la misma oferta publicada en varios portales.
  String get dedupeKey => [
    company,
    title,
    location,
  ].map((part) => part.trim().toLowerCase()).join('|');
}

/// Texto mínimo para analizar una oferta (igual que MIN_DESCRIPTION_CHARS en
/// la función analyze-job).
const minJobDescriptionChars = 200;

/// Completa [job] con el análisis de su descripción ([analyzed]). Conserva
/// lo que identifica la oferta (id, fuente, enlace, cargo, empresa,
/// ubicación y si es sugerencia) para no duplicarla ni perder su proceso.
Job completeJob(Job job, Job analyzed) => job.copyWith(
  description: analyzed.description,
  requirements: analyzed.requirements.isEmpty
      ? job.requirements
      : analyzed.requirements,
  workMode: analyzed.workMode ?? job.workMode,
  salaryMin: analyzed.salaryMin ?? job.salaryMin,
  salaryMax: analyzed.salaryMax ?? job.salaryMax,
  salaryCurrency: analyzed.salaryCurrency ?? job.salaryCurrency,
  // El contacto que ya tenía (p. ej. escrito a mano) no se pisa.
  recruiterName: job.recruiterName ?? analyzed.recruiterName,
  recruiterEmail: job.recruiterEmail ?? analyzed.recruiterEmail,
  recruiterLinkedin: job.recruiterLinkedin ?? analyzed.recruiterLinkedin,
  applyMethod: job.applyMethod ?? analyzed.applyMethod,
  applySubject: job.applySubject ?? analyzed.applySubject,
  asksSalary: job.asksSalary || analyzed.asksSalary,
);

/// Compatibilidad de una oferta con el perfil, calculada por la IA.
@freezed
abstract class JobMatch with _$JobMatch {
  const factory JobMatch({
    required int score,
    @Default([]) List<String> met,
    @Default([]) List<String> missing,
    @Default('') String explanation,
    @Default('') String model,
    @Default('') String promptVersion,
  }) = _JobMatch;

  factory JobMatch.fromJson(Map<String, dynamic> json) =>
      _$JobMatchFromJson(json);
}

@freezed
abstract class SavedJob with _$SavedJob {
  const factory SavedJob({required Job job, JobMatch? match}) = _SavedJob;
}

enum MatchLevel { high, medium, low }

MatchLevel matchLevel(int score) => score >= 75
    ? MatchLevel.high
    : score >= 50
    ? MatchLevel.medium
    : MatchLevel.low;

/// Nombre visible del portal de origen; nulo si se añadió a mano.
String? sourceName(String source) => switch (source) {
  'getonboard' => 'Get on Board',
  'remotive' => 'Remotive',
  'himalayas' => 'Himalayas',
  'remoteok' => 'Remote OK',
  'weworkremotely' => 'We Work Remotely',
  'greenhouse' => 'Greenhouse',
  'lever' => 'Lever',
  'ashby' => 'Ashby',
  'workable' => 'Workable',
  'smartrecruiters' => 'SmartRecruiters',
  'recruitee' => 'Recruitee',
  'teamtailor' => 'Teamtailor',
  'linkedin' => 'LinkedIn',
  // Empresa vigilada que falló en la búsqueda: «greenhouse:acme».
  _ when source.contains(':') =>
    '${sourceName(source.split(':').first) ?? source.split(':').first} '
        '(${source.split(':').last})',
  _ => null,
};
