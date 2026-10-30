import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';

Map<String, dynamic> applicationToRow(
  Application application,
) => <String, dynamic>{
  'job_id': application.jobId,
  'resume_version_id': application.resumeVersionId,
  'status': application.status.dbValue,
  'cover_letter': application.coverLetter,
  'notes': application.notes,
  'applied_at': application.appliedAt?.toUtc().toIso8601String(),
  'next_follow_up_at': application.nextFollowUpAt?.toUtc().toIso8601String(),
};

DateTime? _date(Object? value) =>
    value is String ? DateTime.parse(value).toLocal() : null;

Application applicationFromRow(Map<String, dynamic> row) => Application(
  id: row['id'] as String,
  jobId: row['job_id'] as String,
  resumeVersionId: row['resume_version_id'] as String?,
  status: ApplicationStatus.fromDb(row['status'] as String),
  coverLetter: row['cover_letter'] as String?,
  notes: row['notes'] as String? ?? '',
  appliedAt: _date(row['applied_at']),
  nextFollowUpAt: _date(row['next_follow_up_at']),
  createdAt: _date(row['created_at']),
  updatedAt: _date(row['updated_at']),
);

ApplicationEvent eventFromRow(Map<String, dynamic> row) => ApplicationEvent(
  id: row['id'] as String,
  fromStatus: row['from_status'] == null
      ? null
      : ApplicationStatus.fromDb(row['from_status'] as String),
  toStatus: ApplicationStatus.fromDb(row['to_status'] as String),
  origin: EventOrigin.values.byName(row['origin'] as String? ?? 'manual'),
  note: row['note'] as String?,
  createdAt: _date(row['created_at'])!,
);
