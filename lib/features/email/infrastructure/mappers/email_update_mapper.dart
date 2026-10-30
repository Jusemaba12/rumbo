import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/email/domain/entities/email_update.dart';

EmailUpdate emailUpdateFromRow(Map<String, dynamic> row) {
  DateTime? date(String key) =>
      row[key] == null ? null : DateTime.parse(row[key] as String).toLocal();
  final String? status = row['suggested_status'] as String?;
  return EmailUpdate(
    id: row['id'] as String,
    applicationId: row['application_id'] as String,
    sender: row['sender'] as String? ?? '',
    subject: row['subject'] as String? ?? '',
    summary: row['summary'] as String? ?? '',
    suggestedStatus: status == null ? null : ApplicationStatus.fromDb(status),
    interviewAt: date('interview_at'),
    receivedAt: date('received_at'),
  );
}
