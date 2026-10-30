import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/features/offers/domain/repositories/offers_repository.dart';
import 'package:rumbo/features/offers/infrastructure/di/offers_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_offer_use_case.g.dart';

/// Guarda las condiciones de la oferta de un proceso.
class SaveOfferUseCase {
  const SaveOfferUseCase({required this._repository});

  final OffersRepository _repository;

  Future<Result<void>> call(JobOffer offer) => _repository.save(offer);
}

@Riverpod(keepAlive: true)
SaveOfferUseCase saveOfferUseCase(Ref ref) =>
    SaveOfferUseCase(repository: ref.watch(offersRepositoryProvider));
