import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/env.dart';
import '../../jobs/domain/job.dart';
import '../domain/job_offer.dart';

part 'offers_repository.g.dart';

abstract interface class OffersRepository {
  Future<List<JobOffer>> list();
  Future<void> save(JobOffer offer);
}

String? _date(DateTime? value) => value == null
    ? null
    : '${value.year.toString().padLeft(4, '0')}-'
          '${value.month.toString().padLeft(2, '0')}-'
          '${value.day.toString().padLeft(2, '0')}';

Map<String, dynamic> offerToRow(JobOffer offer) => {
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

class SupabaseOffersRepository implements OffersRepository {
  SupabaseOffersRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<JobOffer>> list() async =>
      (await _client.from('job_offers').select()).map(offerFromRow).toList();

  @override
  Future<void> save(JobOffer offer) =>
      _client.from('job_offers').upsert(offerToRow(offer));
}

class InMemoryOffersRepository implements OffersRepository {
  final _items = <String, JobOffer>{};

  @override
  Future<List<JobOffer>> list() async => [..._items.values];

  @override
  Future<void> save(JobOffer offer) async =>
      _items[offer.applicationId] = offer;
}

@Riverpod(keepAlive: true)
OffersRepository offersRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryOffersRepository();
  return SupabaseOffersRepository(Supabase.instance.client);
}
