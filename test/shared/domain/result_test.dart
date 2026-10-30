import 'package:flutter_test/flutter_test.dart';

import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

void main() {
  test('Ok da el valor y Err el fallo', () {
    const Result<int> done = Ok<int>(3);
    const Result<int> failed = Err<int>(AiBusyFailure());

    expect(done.isOk, isTrue);
    expect(done.valueOrNull, 3);
    expect(done.failureOrNull, isNull);
    expect(done.getOrThrow(), 3);

    expect(failed.isOk, isFalse);
    expect(failed.valueOrNull, isNull);
    expect(failed.failureOrNull, const AiBusyFailure());
    expect(failed.getOrThrow, throwsA(isA<AiBusyFailure>()));
  });

  test('map y andThen conservan el fallo', () async {
    const Result<int> done = Ok<int>(3);
    const Result<int> failed = Err<int>(NetworkFailure());

    expect(done.map((int v) => '$v'), const Ok<String>('3'));
    expect(failed.map((int v) => '$v'), const Err<String>(NetworkFailure()));
    expect(
      await done.andThen((int v) async => Ok<int>(v + 1)),
      const Ok<int>(4),
    );
    expect(
      await failed.andThen((int v) async => Ok<int>(v + 1)),
      const Err<int>(NetworkFailure()),
    );
  });
}
