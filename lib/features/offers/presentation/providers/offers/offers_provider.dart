import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/offers/application/use_cases/get_offers_use_case.dart';
import 'package:rumbo/features/offers/application/use_cases/save_offer_use_case.dart';
import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'offers_provider.g.dart';

@Riverpod(keepAlive: true)
class OffersController extends _$OffersController {
  @override
  Future<List<JobOffer>> build() async {
    ref.watch(sessionChangesProvider);
    return (await ref.watch(getOffersUseCaseProvider)()).getOrThrow();
  }

  Future<Result<void>> save(JobOffer offer) async {
    final Result<void> result = await ref.read(saveOfferUseCaseProvider)(offer);
    if (!result.isOk) return result;
    final Result<List<JobOffer>> offers = await ref.read(
      getOffersUseCaseProvider,
    )();
    if (offers case Ok<List<JobOffer>>(:final List<JobOffer> value)) {
      state = AsyncData<List<JobOffer>>(value);
    }
    return result;
  }
}
