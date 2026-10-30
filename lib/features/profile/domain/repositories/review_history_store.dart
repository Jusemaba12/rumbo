import 'package:rumbo/features/profile/domain/services/review_history.dart';

/// Historial de la nota de la HV en este teléfono: un valor por día (el
/// último), los últimos [maxHistoryDays].
abstract interface class ReviewHistoryStore {
  Future<List<ScorePoint>> load();

  Future<List<ScorePoint>> record({required int score, required DateTime now});
}
