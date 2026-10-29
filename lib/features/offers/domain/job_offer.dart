import 'package:freezed_annotation/freezed_annotation.dart';

import '../../applications/domain/application_status.dart';
import '../../jobs/domain/job.dart';

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
    final value => period == SalaryPeriod.year ? value / 12 : value,
  };
}

/// Estados en los que un proceso tiene una oferta que registrar.
const offerStatuses = {
  ApplicationStatus.offer,
  ApplicationStatus.accepted,
  ApplicationStatus.declined,
};
