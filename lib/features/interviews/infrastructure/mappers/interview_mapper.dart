import 'package:rumbo/features/interviews/domain/entities/interview.dart';

Map<String, dynamic> interviewToRow(Interview interview) => <String, dynamic>{
  'application_id': interview.applicationId,
  'kind': interviewKindDb(interview.kind),
  'scheduled_at': interview.scheduledAt.toUtc().toIso8601String(),
  'duration_minutes': interview.durationMinutes,
  'location': interview.location,
  'notes': interview.notes,
  'outcome': interview.outcome.name,
};

Interview interviewFromRow(Map<String, dynamic> row) => Interview(
  id: row['id'] as String,
  applicationId: row['application_id'] as String,
  kind: interviewKindFromDb(row['kind'] as String),
  scheduledAt: DateTime.parse(row['scheduled_at'] as String).toLocal(),
  durationMinutes: row['duration_minutes'] as int? ?? 60,
  location: row['location'] as String? ?? '',
  notes: row['notes'] as String? ?? '',
  outcome:
      InterviewOutcome.values.asNameMap()[row['outcome']] ??
      InterviewOutcome.pending,
);
