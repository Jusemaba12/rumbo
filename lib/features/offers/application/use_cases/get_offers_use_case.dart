import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/features/offers/domain/repositories/offers_repository.dart';
import 'package:rumbo/features/offers/infrastructure/di/offers_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_offers_use_case.g.dart';

/// Condiciones de todas las ofertas recibidas.
class GetOffersUseCase {
  const GetOffersUseCase({required this._repository});

  final OffersRepository _repository;

  Future<Result<List<JobOffer>>> call() => _repository.list();
}

@Riverpod(keepAlive: true)
GetOffersUseCase getOffersUseCase(Ref ref) =>
    GetOffersUseCase(repository: ref.watch(offersRepositoryProvider));
