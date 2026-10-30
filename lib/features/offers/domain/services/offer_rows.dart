import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/offers/domain/entities/job_offer.dart';

/// Oferta comparable: proceso, condiciones y compatibilidad de la oferta.
typedef OfferRow = ({ApplicationWithJob process, JobOffer offer, int? score});

/// Procesos con oferta (recibida, aceptada o rechazada) y sus condiciones.
List<OfferRow> offerRows({
  required List<ApplicationWithJob> applications,
  required List<JobOffer> offers,
  required List<SavedJob> jobs,
}) {
  final Map<String, JobOffer> byApplication = <String, JobOffer>{
    for (final JobOffer o in offers) o.applicationId: o,
  };
  final Map<String, int?> scores = <String, int?>{
    for (final SavedJob s in jobs) s.job.id: s.match?.score,
  };
  return <OfferRow>[
    for (final ApplicationWithJob process in applications)
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
