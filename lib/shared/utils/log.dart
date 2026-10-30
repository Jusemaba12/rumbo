import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Registro de la app. Cada clase define su `static const String _tag`.
/// En release solo se escriben avisos y errores.
abstract final class Log {
  static void d({required String tag, required String message}) =>
      _write(level: 500, tag: tag, message: message);

  static void i({required String tag, required String message}) =>
      _write(level: 800, tag: tag, message: message);

  static void w({required String tag, required String message}) =>
      _write(level: 900, tag: tag, message: message);

  static void e({
    required String tag,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) => _write(
    level: 1000,
    tag: tag,
    message: message,
    error: error,
    stackTrace: stackTrace,
  );

  static void _write({
    required int level,
    required String tag,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode && level < 900) return;
    developer.log(
      message,
      name: tag,
      level: level,
      error: error,
      stackTrace: stackTrace,
    );
    if (!kReleaseMode) {
      debugPrint('[$tag] $message${error == null ? '' : ' · $error'}');
    }
  }
}
