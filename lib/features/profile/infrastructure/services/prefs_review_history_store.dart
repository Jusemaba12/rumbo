import 'dart:convert';

import 'package:rumbo/features/profile/domain/repositories/review_history_store.dart';
import 'package:rumbo/features/profile/domain/services/review_history.dart';
import 'package:rumbo/shared/utils/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsReviewHistoryStore implements ReviewHistoryStore {
  static const String _tag = 'PrefsReviewHistoryStore';
  static const String _key = 'review.history';

  @override
  Future<List<ScorePoint>> load() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? raw = prefs.getString(_key);
      if (raw == null) return const <ScorePoint>[];
      return <ScorePoint>[
        for (final dynamic item in jsonDecode(raw) as List<dynamic>)
          (day: DateTime.parse(item['d'] as String), score: item['s'] as int),
      ];
    } catch (error) {
      Log.w(tag: _tag, message: 'Historial no disponible: $error');
      return const <ScorePoint>[];
    }
  }

  @override
  Future<List<ScorePoint>> record({
    required int score,
    required DateTime now,
  }) async {
    final List<ScorePoint> history = addScore(
      history: await load(),
      score: score,
      now: now,
    );
    final List<ScorePoint> kept = history.length > maxHistoryDays
        ? history.sublist(history.length - maxHistoryDays)
        : history;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _key,
        jsonEncode(<Map<String, Object>>[
          for (final ScorePoint point in kept)
            <String, Object>{
              'd': point.day.toIso8601String(),
              's': point.score,
            },
        ]),
      );
    } catch (error) {
      Log.w(tag: _tag, message: 'Historial no disponible: $error');
    }
    return kept;
  }
}
