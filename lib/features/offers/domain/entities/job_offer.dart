import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';

part 'job_offer.freezed.dart';

enum SalaryPeriod { month, year }

/// Condiciones de una oferta recibida (una por proceso).
@freezed
abstract class JobOffer with _$JobOffer {
  const JobOffer._();

  const factory JobOffer({
    required String applicationId,
    double? salary,
    @Default('USD') String currency,
    @Default(SalaryPeriod.month) SalaryPeriod period,
    WorkMode? workMode,
    DateTime? startDate,
    DateTime? deadline,
    @Default('') String benefits,
    @Default('') String notes,
  }) = _JobOffer;

  /// Salario mensual equivalente, para comparar ofertas.
  double? get monthlySalary => switch (salary) {
    null => null,
    final double value => period == SalaryPeriod.year ? value / 12 : value,
  };
}

/// Estados en los que un proceso tiene una oferta que registrar.
const Set<ApplicationStatus> offerStatuses = <ApplicationStatus>{
  ApplicationStatus.offer,
  ApplicationStatus.accepted,
  ApplicationStatus.declined,
};
