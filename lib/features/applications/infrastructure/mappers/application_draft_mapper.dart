import 'package:rumbo/features/applications/domain/entities/application_draft.dart';

/// Convierte la respuesta de `tailor-resume`.
ApplicationDraft applicationDraftFromJson({
  required String jobId,
  required Map<String, dynamic> json,
}) {
  final Map<String, dynamic> validation =
      json['validation'] as Map<String, dynamic>? ?? const <String, dynamic>{};
  return ApplicationDraft(
    jobId: jobId,
    language: json['language'] == 'en' ? ResumeLanguage.en : ResumeLanguage.es,
    resume: TailoredResume.fromJson(json['resume'] as Map<String, dynamic>),
    coverLetter: json['cover_letter'] as String? ?? '',
    changes: <ResumeChange>[
      for (final dynamic change
          in json['changes'] as List<dynamic>? ?? const <dynamic>[])
        ResumeChange.fromJson(change as Map<String, dynamic>),
    ],
    keywords: <String>[
      ...(json['keywords'] as List<dynamic>? ?? const <dynamic>[])
          .cast<String>(),
    ],
    rejected: <String>[
      ...(validation['rejected'] as List<dynamic>? ?? const <dynamic>[])
          .cast<String>(),
    ],
  );
}

/// Lo contrario de [resumeVersionToRow].
ApplicationDraft resumeVersionFromRow(Map<String, dynamic> row) {
  final Map<String, dynamic> content = (row['content'] as Map<dynamic, dynamic>)
      .cast<String, dynamic>();
  return ApplicationDraft(
    jobId: row['job_id'] as String,
    language:
        ResumeLanguage.values.asNameMap()[content['language']] ??
        ResumeLanguage.es,
    resume: TailoredResume.fromJson(content),
    coverLetter: content['cover_letter'] as String? ?? '',
    changes: <ResumeChange>[
      for (final dynamic change
          in row['changes'] as List<dynamic>? ?? const <dynamic>[])
        ResumeChange.fromJson(
          (change as Map<dynamic, dynamic>).cast<String, dynamic>(),
        ),
    ],
  );
}

Map<String, dynamic> resumeVersionToRow(ApplicationDraft draft) =>
    <String, dynamic>{
      'job_id': draft.jobId,
      'content': <String, dynamic>{
        ...draft.resume.toJson(),
        'language': draft.language.name,
        'cover_letter': draft.coverLetter,
      },
      'changes': <Map<String, dynamic>>[
        for (final ResumeChange change in draft.changes) change.toJson(),
      ],
    };
