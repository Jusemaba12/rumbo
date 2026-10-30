import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application_status.dart';

part 'interview.freezed.dart';

enum InterviewKind { screening, technical, hr, final_, other }

enum InterviewOutcome { pending, passed, failed }

/// Valor en la base de datos (`final` es palabra reservada en Dart).
String interviewKindDb(InterviewKind kind) =>
    kind == InterviewKind.final_ ? 'final' : kind.name;

InterviewKind interviewKindFromDb(String value) => value == 'final'
    ? InterviewKind.final_
    : InterviewKind.values.asNameMap()[value] ?? InterviewKind.other;

@freezed
abstract class Interview with _$Interview {
  const Interview._();

  const factory Interview({
    @Default('') String id,
    required String applicationId,
    @Default(InterviewKind.screening) InterviewKind kind,
    required DateTime scheduledAt,
    @Default(60) int durationMinutes,

    /// Enlace de la videollamada o dirección.
    @Default('') String location,
    @Default('') String notes,
    @Default(InterviewOutcome.pending) InterviewOutcome outcome,
  }) = _Interview;

  DateTime get endsAt => scheduledAt.add(Duration(minutes: durationMinutes));

  bool isUpcoming(DateTime now) => endsAt.isAfter(now);
}

/// Estado al que debería pasar el proceso al programar una entrevista;
/// nulo si ya está en ese punto o más adelante.
ApplicationStatus? statusForInterview({
  required ApplicationStatus current,
  required InterviewKind kind,
}) {
  final ApplicationStatus target = kind == InterviewKind.technical
      ? ApplicationStatus.technicalTest
      : ApplicationStatus.interview;
  if (current.canMoveTo(target)) return target;
  // Una prueba técnica tras una entrevista no hace retroceder el estado.
  if (target == ApplicationStatus.technicalTest &&
      current.canMoveTo(ApplicationStatus.interview)) {
    return ApplicationStatus.interview;
  }
  return null;
}
