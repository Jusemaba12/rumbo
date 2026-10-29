import 'package:freezed_annotation/freezed_annotation.dart';

import '../../jobs/domain/job.dart';
import 'application_status.dart';

part 'application.freezed.dart';

/// Proceso de postulación a una oferta (una por oferta).
@freezed
abstract class Application with _$Application {
  const factory Application({
    @Default('') String id,
    required String jobId,
    String? resumeVersionId,
    @Default(ApplicationStatus.saved) ApplicationStatus status,
    String? coverLetter,
    @Default('') String notes,
    DateTime? appliedAt,
    DateTime? nextFollowUpAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Application;
}

enum EventOrigin { manual, email, system }

/// Cambio de estado registrado en el historial.
@freezed
abstract class ApplicationEvent with _$ApplicationEvent {
  const factory ApplicationEvent({
    required String id,
    ApplicationStatus? fromStatus,
    required ApplicationStatus toStatus,
    @Default(EventOrigin.manual) EventOrigin origin,
    String? note,
    required DateTime createdAt,
  }) = _ApplicationEvent;
}

/// Proceso con la oferta a la que pertenece, para mostrar en listas.
@freezed
abstract class ApplicationWithJob with _$ApplicationWithJob {
  const factory ApplicationWithJob({
    required Application application,
    required Job job,
  }) = _ApplicationWithJob;
}
