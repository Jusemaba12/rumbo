import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show ClientException;
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class _OwnFailure extends Failure {
  const _OwnFailure();
}

Future<Result<int>> _failingWith(Object error) =>
    guard<int>(tag: 'test', run: () async => throw error);

void main() {
  test('devuelve el valor si todo sale bien', () async {
    expect(await guard<int>(tag: 'test', run: () async => 1), const Ok<int>(1));
  });

  test('deja pasar los fallos propios de cada funcionalidad', () async {
    expect(
      (await _failingWith(const _OwnFailure())).failureOrNull,
      isA<_OwnFailure>(),
    );
  });

  test('traduce los errores de las funciones', () async {
    Future<Failure?> failure(int status, [Object? details]) async =>
        (await _failingWith(
          FunctionException(status: status, details: details),
        )).failureOrNull;

    expect(
      await failure(429, <String, String>{'error': 'daily_limit'}),
      isA<DailyLimitFailure>(),
    );
    expect(await failure(429), isA<RateLimitedFailure>());
    expect(await failure(503), isA<AiBusyFailure>());
    expect(await failure(500), isA<UnexpectedFailure>());
  });

  test('traduce los duplicados y los errores de red', () async {
    expect(
      (await _failingWith(
        const PostgrestException(message: 'duplicate', code: '23505'),
      )).failureOrNull,
      isA<DuplicateFailure>(),
    );
    expect(
      (await _failingWith(ClientException('sin red'))).failureOrNull,
      isA<NetworkFailure>(),
    );
  });
}
