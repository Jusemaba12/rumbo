import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Condiciones de las ofertas recibidas, una por proceso.
abstract interface class OffersRepository {
  Future<Result<List<JobOffer>>> list();

  /// Crea o reemplaza las condiciones del proceso de la oferta.
  Future<Result<void>> save(JobOffer offer);
}
