/// Nota de la revisión ATS en un día.
typedef ScorePoint = ({DateTime day, int score});

const int maxHistoryDays = 30;

/// Añade o sustituye la nota de hoy y recorta a los últimos días.
List<ScorePoint> addScore({
  required List<ScorePoint> history,
  required int score,
  required DateTime now,
}) {
  final DateTime day = DateTime(now.year, now.month, now.day);
  return <ScorePoint>[
    ...history.where((ScorePoint point) => point.day != day),
    (day: day, score: score),
  ]..sort((ScorePoint a, ScorePoint b) => a.day.compareTo(b.day));
}
