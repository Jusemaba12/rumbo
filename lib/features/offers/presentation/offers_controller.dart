import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../applications/domain/application.dart';
import '../../auth/data/auth_repository.dart';
import '../../jobs/domain/job.dart';
import '../data/offers_repository.dart';
import '../domain/job_offer.dart';

part 'offers_controller.g.dart';

@Riverpod(keepAlive: true)
class OffersController extends _$OffersController {
  @override
  Future<List<JobOffer>> build() {
    ref.watch(sessionChangesProvider);
    return ref.watch(offersRepositoryProvider).list();
  }

  Future<void> save(JobOffer offer) async {
    final repository = ref.read(offersRepositoryProvider);
    await repository.save(offer);
    state = AsyncData(await repository.list());
  }
}

/// Oferta comparable: proceso, condiciones y compatibilidad de la oferta.
typedef OfferRow = ({ApplicationWithJob process, JobOffer offer, int? score});

/// Procesos con oferta (recibida, aceptada o rechazada) y sus condiciones.
List<OfferRow> offerRows(
  List<ApplicationWithJob> applications,
  List<JobOffer> offers,
  List<SavedJob> jobs,
) {
  final byApplication = {for (final o in offers) o.applicationId: o};
  final scores = {for (final s in jobs) s.job.id: s.match?.score};
  return [
    for (final process in applications)
      if (offerStatuses.contains(process.application.status))
        (
          process: process,
          offer:
              byApplication[process.application.id] ??
              JobOffer(applicationId: process.application.id),
          score: scores[process.job.id],
        ),
  ];
}
