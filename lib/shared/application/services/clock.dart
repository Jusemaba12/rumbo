import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

/// Hora actual; se sustituye en los tests para fijar fechas.
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;
