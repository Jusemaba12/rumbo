import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_draft.freezed.dart';
part 'application_draft.g.dart';

@freezed
abstract class TailoredExperience with _$TailoredExperience {
  const factory TailoredExperience({
    required String experienceId,
    required String company,
    required String role,
    required DateTime startDate,
    DateTime? endDate,
    @Default(<String>[]) List<String> bullets,
  }) = _TailoredExperience;

  factory TailoredExperience.fromJson(Map<String, dynamic> json) =>
      _$TailoredExperienceFromJson(json);
}

/// HV adaptada a una oferta: solo contiene datos respaldados por el perfil.
@freezed
abstract class TailoredResume with _$TailoredResume {
  const factory TailoredResume({
    @Default('') String headline,
    @Default('') String summary,
    @Default(<TailoredExperience>[]) List<TailoredExperience> experiences,
    @Default(<String>[]) List<String> skills,
  }) = _TailoredResume;

  factory TailoredResume.fromJson(Map<String, dynamic> json) =>
      _$TailoredResumeFromJson(json);
}

@freezed
abstract class ResumeChange with _$ResumeChange {
  const factory ResumeChange({
    required String section,
    @Default('') String before,
    @Default('') String after,
    @Default('') String reason,
  }) = _ResumeChange;

  factory ResumeChange.fromJson(Map<String, dynamic> json) =>
      _$ResumeChangeFromJson(json);
}

enum ResumeLanguage { es, en }

/// Todo lo preparado para postularse a una oferta, antes de guardarlo.
@freezed
abstract class ApplicationDraft with _$ApplicationDraft {
  const factory ApplicationDraft({
    required String jobId,
    @Default(ResumeLanguage.es) ResumeLanguage language,
    required TailoredResume resume,
    @Default('') String coverLetter,
    @Default(<ResumeChange>[]) List<ResumeChange> changes,
    @Default(<String>[]) List<String> keywords,

    /// Frases que el validador descartó por no estar en el perfil.
    @Default(<String>[]) List<String> rejected,
  }) = _ApplicationDraft;
}
