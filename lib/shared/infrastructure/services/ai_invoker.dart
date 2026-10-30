import 'package:rumbo/shared/utils/log.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String _tag = 'AiInvoker';

/// Esperas antes de cada reintento cuando la IA está saturada (503).
const List<Duration> aiRetryWaits = <Duration>[
  Duration(seconds: 8),
  Duration(seconds: 20),
];

/// Llama a una función de IA y, si responde que la IA está saturada (503),
/// espera y lo vuelve a intentar sola antes de rendirse.
Future<FunctionResponse> invokeAi({
  required FunctionsClient functions,
  required String name,
  Object? body,
  List<Duration> waits = aiRetryWaits,
  Future<void> Function(Duration wait)? sleep,
}) async {
  for (int attempt = 0; ; attempt++) {
    try {
      return await functions.invoke(name, body: body);
    } on FunctionException catch (error) {
      if (error.status != 503 || attempt >= waits.length) rethrow;
      Log.w(tag: _tag, message: '$name: IA saturada, reintento ${attempt + 1}');
      await (sleep ?? Future<void>.delayed)(waits[attempt]);
    }
  }
}

/// Como [invokeAi], pero devuelve el cuerpo de la respuesta como mapa.
Future<Map<String, dynamic>> invokeAiJson({
  required FunctionsClient functions,
  required String name,
  Object? body,
}) async {
  final FunctionResponse response = await invokeAi(
    functions: functions,
    name: name,
    body: body,
  );
  return (response.data as Map<dynamic, dynamic>).cast<String, dynamic>();
}

/// Código de error que devuelven las funciones en `{"error": "..."}`.
String? functionErrorCode(FunctionException error) {
  final Object? details = error.details;
  if (details is! Map) return null;
  final Object? code = details['error'];
  return code is String ? code : null;
}

/// La persona ya usó la IA el máximo de veces de hoy (límite del servidor
/// para no agotar la cuota gratuita compartida).
bool isDailyLimit(FunctionException error) =>
    error.status == 429 && functionErrorCode(error) == 'daily_limit';
