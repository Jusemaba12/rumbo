import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/data/review_history.dart';

void main() {
  test(
    'guarda una nota por día: la última del día sustituye a la anterior',
    () {
      var history = addScore(const [], 70, DateTime(2026, 10, 14, 9));
      history = addScore(history, 78, DateTime(2026, 10, 16, 9));
      history = addScore(history, 84, DateTime(2026, 10, 16, 18));
      expect(history.map((p) => p.score).toList(), [70, 84]);
      expect(history.last.day, DateTime(2026, 10, 16));
    },
  );
}
