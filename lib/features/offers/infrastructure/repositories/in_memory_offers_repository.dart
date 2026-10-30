import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/features/offers/domain/repositories/offers_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

class InMemoryOffersRepository implements OffersRepository {
  final Map<String, JobOffer> _items = <String, JobOffer>{};

  @override
  Future<Result<List<JobOffer>>> list() async =>
      Ok<List<JobOffer>>(<JobOffer>[..._items.values]);

  @override
  Future<Result<void>> save(JobOffer offer) async {
    _items[offer.applicationId] = offer;
    return ok;
  }
}
