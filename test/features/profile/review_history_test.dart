import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/domain/services/review_history.dart';

void main() {
  test(
    'guarda una nota por día: la última del día sustituye a la anterior',
    () {
      List<ScorePoint> history = addScore(
        history: const <ScorePoint>[],
        score: 70,
        now: DateTime(2026, 10, 14, 9),
      );
      history = addScore(
        history: history,
        score: 78,
        now: DateTime(2026, 10, 16, 9),
      );
      history = addScore(
        history: history,
        score: 84,
        now: DateTime(2026, 10, 16, 18),
      );
      expect(history.map((ScorePoint p) => p.score).toList(), <int>[70, 84]);
      expect(history.last.day, DateTime(2026, 10, 16));
    },
  );
}
