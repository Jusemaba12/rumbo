/// Estados por los que pasa una postulación.
///
/// Los nombres coinciden con el enum `application_status` de la base de datos.
enum ApplicationStatus {
  saved,
  preparing,
  applied,
  inReview,
  technicalTest,
  interview,
  offer,
  accepted,
  declined,
  rejected,
  noResponse;

  static const _next = <ApplicationStatus, Set<ApplicationStatus>>{
    saved: {preparing},
    preparing: {applied, saved},
    applied: {inReview, technicalTest, interview, rejected, noResponse},
    inReview: {technicalTest, interview, rejected, noResponse},
    technicalTest: {interview, rejected, noResponse},
    interview: {offer, rejected, noResponse},
    offer: {accepted, declined},
    // Una empresa puede responder después de semanas de silencio.
    noResponse: {inReview, technicalTest, interview, rejected},
    accepted: {},
    declined: {},
    rejected: {},
  };

  /// El proceso terminó y no admite más cambios.
  bool get isClosed => _next[this]!.isEmpty;

  /// Ya se envió y sigue abierto.
  bool get isActive => !isClosed && this != saved && this != preparing;

  bool canMoveTo(ApplicationStatus other) => _next[this]!.contains(other);

  Set<ApplicationStatus> get nextStatuses => _next[this]!;

  /// Valor guardado en la base de datos (snake_case).
  String get dbValue => switch (this) {
    inReview => 'in_review',
    technicalTest => 'technical_test',
    noResponse => 'no_response',
    _ => name,
  };

  static ApplicationStatus fromDb(String value) =>
      values.firstWhere((status) => status.dbValue == value);
}
