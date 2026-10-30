import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/offers/domain/entities/job_offer.dart';

String? _date(DateTime? value) => value == null
    ? null
    : '${value.year.toString().padLeft(4, '0')}-'
          '${value.month.toString().padLeft(2, '0')}-'
          '${value.day.toString().padLeft(2, '0')}';

Map<String, dynamic> offerToRow(JobOffer offer) => <String, dynamic>{
  'application_id': offer.applicationId,
  'salary': offer.salary,
  'currency': offer.currency.trim().toUpperCase(),
  'period': offer.period.name,
  'work_mode': offer.workMode?.name,
  'start_date': _date(offer.startDate),
  'deadline': _date(offer.deadline),
  'benefits': offer.benefits,
  'notes': offer.notes,
};

JobOffer offerFromRow(Map<String, dynamic> row) {
  DateTime? date(String key) =>
      row[key] == null ? null : DateTime.parse(row[key] as String);
  return JobOffer(
    applicationId: row['application_id'] as String,
    salary: (row['salary'] as num?)?.toDouble(),
    currency: row['currency'] as String? ?? 'USD',
    period: row['period'] == 'year' ? SalaryPeriod.year : SalaryPeriod.month,
    workMode: WorkMode.values.asNameMap()[row['work_mode']],
    startDate: date('start_date'),
    deadline: date('deadline'),
    benefits: row['benefits'] as String? ?? '',
    notes: row['notes'] as String? ?? '',
  );
}
