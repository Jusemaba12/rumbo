import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// La persona ya usó la IA el máximo de veces de hoy (límite del servidor
/// para no agotar la cuota gratuita compartida).
bool isDailyLimit(FunctionException error) =>
    error.status == 429 &&
    error.details is Map &&
    (error.details as Map)['error'] == 'daily_limit';

/// Esperas antes de cada reintento cuando la IA está saturada (503).
const aiRetryWaits = [Duration(seconds: 8), Duration(seconds: 20)];

/// Llama a una función de IA y, si responde que la IA está saturada (503),
/// espera y lo vuelve a intentar sola antes de rendirse.
Future<FunctionResponse> invokeAi(
  FunctionsClient functions,
  String name, {
  Object? body,
  List<Duration> waits = aiRetryWaits,
  Future<void> Function(Duration wait)? sleep,
}) async {
  for (var attempt = 0; ; attempt++) {
    try {
      return await functions.invoke(name, body: body);
    } on FunctionException catch (error) {
      if (error.status != 503 || attempt >= waits.length) rethrow;
      debugPrint('$name: IA saturada, reintento ${attempt + 1}');
      await (sleep ?? Future<void>.delayed)(waits[attempt]);
    }
  }
}
