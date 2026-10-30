import 'package:rumbo/features/profile/domain/entities/profile.dart';

abstract final class ProfileTables {
  static const String profiles = 'profiles';
  static const String experiences = 'experiences';
  static const String projects = 'projects';
  static const String skills = 'skills';
  static const String education = 'education';
}

/// Las columnas `date` de Postgres solo admiten `yyyy-MM-dd`.
String dateToRow(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

Map<String, dynamic> profileToRow(Profile profile, {required String userId}) =>
    <String, dynamic>{...profile.toJson(), 'user_id': userId};

Experience experienceFromRow(Map<String, dynamic> row) =>
    Experience.fromJson(row);

Map<String, dynamic> experienceToRow(Experience experience) {
  final DateTime? endDate = experience.endDate;
  return _withoutEmptyId(<String, dynamic>{
    ...experience.toJson(),
    'start_date': dateToRow(experience.startDate),
    'end_date': endDate == null ? null : dateToRow(endDate),
  });
}

Map<String, dynamic> projectToRow(Project project) =>
    _withoutEmptyId(project.toJson());

Map<String, dynamic> skillToRow(Skill skill) => _withoutEmptyId(skill.toJson());

/// Sin id, la base de datos genera uno nuevo y la fila se inserta.
Map<String, dynamic> _withoutEmptyId(Map<String, dynamic> row) =>
    row['id'] == '' ? (Map<String, dynamic>.of(row)..remove('id')) : row;

Map<String, dynamic> educationToRow(Education education) {
  final DateTime? start = education.startDate;
  final DateTime? end = education.endDate;
  return _withoutEmptyId(<String, dynamic>{
    ...education.toJson(),
    'start_date': start == null ? null : dateToRow(start),
    'end_date': end == null ? null : dateToRow(end),
  });
}
