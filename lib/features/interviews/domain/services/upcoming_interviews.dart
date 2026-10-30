import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';

/// Entrevistas pendientes con su proceso, de la más próxima a la más lejana.
List<(Interview, ApplicationWithJob)> upcomingInterviews({
  required List<Interview> interviews,
  required List<ApplicationWithJob> applications,
  required DateTime now,
}) {
  final Map<String, ApplicationWithJob> byId = <String, ApplicationWithJob>{
    for (final ApplicationWithJob a in applications) a.application.id: a,
  };
  return <(Interview, ApplicationWithJob)>[
    for (final Interview interview in interviews)
      if (interview.isUpcoming(now))
        if (byId[interview.applicationId]
            case final ApplicationWithJob process?)
          (interview, process),
  ];
}
