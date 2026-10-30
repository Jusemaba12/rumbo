import 'package:collection/collection.dart';

import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/repositories/resume_versions_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

class InMemoryResumeVersionsRepository implements ResumeVersionsRepository {
  final List<ApplicationDraft> saved = <ApplicationDraft>[];

  @override
  Future<Result<String>> save(ApplicationDraft draft) async {
    saved.add(draft);
    return Ok<String>('version-${saved.length}');
  }

  @override
  Future<Result<ApplicationDraft?>> latestForJob(String jobId) async =>
      Ok<ApplicationDraft?>(
        saved.lastWhereOrNull((ApplicationDraft draft) => draft.jobId == jobId),
      );
}
