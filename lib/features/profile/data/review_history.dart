import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'review_history.g.dart';

/// Nota de la revisión ATS en un día.
typedef ScorePoint = ({DateTime day, int score});

/// Historial de la nota de la HV en este teléfono: un valor por día (el
/// último), los últimos [maxDays].
abstract interface class ReviewHistoryStore {
  Future<List<ScorePoint>> load();
  Future<List<ScorePoint>> record(int score, DateTime now);
}

const maxHistoryDays = 30;

/// Añade o sustituye la nota de hoy y recorta a los últimos días.
List<ScorePoint> addScore(List<ScorePoint> history, int score, DateTime now) {
  final day = DateTime(now.year, now.month, now.day);
  return [
    ...history.where((point) => point.day != day),
    (day: day, score: score),
  ]..sort((a, b) => a.day.compareTo(b.day));
}

class PrefsReviewHistoryStore implements ReviewHistoryStore {
  static const _key = 'review.history';

  @override
  Future<List<ScorePoint>> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null) return const [];
      return [
        for (final item in jsonDecode(raw) as List)
          (day: DateTime.parse(item['d'] as String), score: item['s'] as int),
      ];
    } catch (error) {
      debugPrint('review history: $error');
      return const [];
    }
  }

  @override
  Future<List<ScorePoint>> record(int score, DateTime now) async {
    final history = addScore(await load(), score, now);
    final kept = history.length > maxHistoryDays
        ? history.sublist(history.length - maxHistoryDays)
        : history;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _key,
        jsonEncode([
          for (final point in kept)
            {'d': point.day.toIso8601String(), 's': point.score},
        ]),
      );
    } catch (error) {
      debugPrint('review history: $error');
    }
    return kept;
  }
}

@Riverpod(keepAlive: true)
ReviewHistoryStore reviewHistoryStore(Ref ref) => PrefsReviewHistoryStore();
