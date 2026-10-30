import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Responde con los estados de [statuses] en orden (200 = éxito).
class _FakeFunctions implements FunctionsClient {
  _FakeFunctions(this.statuses);

  final List<int> statuses;
  int calls = 0;

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
    final int status = statuses[calls++];
    if (status != 200) {
      throw FunctionException(
        status: status,
        details: <String, String>{'error': 'x'},
      );
    }
    return FunctionResponse(data: <String, bool>{'ok': true}, status: 200);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final List<Duration> waited = <Duration>[];
  Future<void> sleep(Duration wait) async => waited.add(wait);
  setUp(waited.clear);

  test('reintenta si la IA está saturada y devuelve la respuesta', () async {
    final _FakeFunctions functions = _FakeFunctions(<int>[503, 503, 200]);
    final FunctionResponse response = await invokeAi(
      functions: functions,
      name: 'analyze-job',
      sleep: sleep,
    );
    expect(response.data, <String, bool>{'ok': true});
    expect(functions.calls, 3);
    expect(waited, aiRetryWaits);
  });

  test('se rinde tras los reintentos y deja pasar el error', () async {
    final _FakeFunctions functions = _FakeFunctions(<int>[503, 503, 503]);
    await expectLater(
      invokeAi(functions: functions, name: 'analyze-job', sleep: sleep),
      throwsA(
        isA<FunctionException>().having(
          (FunctionException e) => e.status,
          'status',
          503,
        ),
      ),
    );
    expect(functions.calls, 3);
  });

  test('otros errores no se reintentan', () async {
    final _FakeFunctions functions = _FakeFunctions(<int>[429]);
    await expectLater(
      invokeAi(functions: functions, name: 'analyze-job', sleep: sleep),
      throwsA(isA<FunctionException>()),
    );
    expect(functions.calls, 1);
    expect(waited, isEmpty);
  });
}
