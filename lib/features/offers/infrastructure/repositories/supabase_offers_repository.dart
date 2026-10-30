import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/features/offers/domain/repositories/offers_repository.dart';
import 'package:rumbo/features/offers/infrastructure/mappers/job_offer_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseOffersRepository implements OffersRepository {
  SupabaseOffersRepository(this._client);

  static const String _tag = 'SupabaseOffersRepository';

  final SupabaseClient _client;

  @override
  Future<Result<List<JobOffer>>> list() => guard(
    tag: _tag,
    run: () async =>
        (await _client.from('job_offers').select()).map(offerFromRow).toList(),
  );

  @override
  Future<Result<void>> save(JobOffer offer) => guard(
    tag: _tag,
    run: () => _client.from('job_offers').upsert(offerToRow(offer)),
  );
}
