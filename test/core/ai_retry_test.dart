import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/core/ai/ai_errors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Responde con los estados de [statuses] en orden (200 = éxito).
class _FakeFunctions implements FunctionsClient {
  _FakeFunctions(this.statuses);

  final List<int> statuses;
  var calls = 0;

  @override
  Future<FunctionResponse> invoke(
    String functionName, {
    Map<String, String>? headers,
    Object? body,
    Iterable<dynamic>? files,
    Map<String, dynamic>? queryParameters,
    HttpMethod method = HttpMethod.post,
    String? region,
    Future<void>? abortSignal,
  }) async {
    final status = statuses[calls++];
    if (status != 200) {
      throw FunctionException(status: status, details: {'error': 'x'});
    }
    return FunctionResponse(data: {'ok': true}, status: 200);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final waited = <Duration>[];
  Future<void> sleep(Duration wait) async => waited.add(wait);
  setUp(waited.clear);

  test('reintenta si la IA está saturada y devuelve la respuesta', () async {
    final functions = _FakeFunctions([503, 503, 200]);
    final response = await invokeAi(functions, 'analyze-job', sleep: sleep);
    expect(response.data, {'ok': true});
    expect(functions.calls, 3);
    expect(waited, aiRetryWaits);
  });

  test('se rinde tras los reintentos y deja pasar el error', () async {
    final functions = _FakeFunctions([503, 503, 503]);
    await expectLater(
      invokeAi(functions, 'analyze-job', sleep: sleep),
      throwsA(isA<FunctionException>().having((e) => e.status, 'status', 503)),
    );
    expect(functions.calls, 3);
  });

  test('otros errores no se reintentan', () async {
    final functions = _FakeFunctions([429]);
    await expectLater(
      invokeAi(functions, 'analyze-job', sleep: sleep),
      throwsA(isA<FunctionException>()),
    );
    expect(functions.calls, 1);
    expect(waited, isEmpty);
  });
}
