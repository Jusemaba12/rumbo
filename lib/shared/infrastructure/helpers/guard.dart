import 'package:http/http.dart' show ClientException;
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:rumbo/shared/utils/log.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Ejecuta [run] y convierte lo que lance en un [Failure]. Los repositorios
/// envuelven así cada operación; dentro pueden lanzar un [Failure] propio
/// (por ejemplo, `NoDescriptionFailure`) y llega tal cual.
Future<Result<T>> guard<T>({
  required String tag,
  required Future<T> Function() run,
}) async {
  try {
    return Ok<T>(await run());
  } on Failure catch (failure) {
    Log.w(tag: tag, message: 'Fallo: $failure');
    return Err<T>(failure);
  } catch (error, stackTrace) {
    final Failure failure = failureFromError(error);
    if (failure is UnexpectedFailure) {
      Log.e(
        tag: tag,
        message: 'Error no controlado',
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      Log.w(tag: tag, message: 'Fallo: $failure ($error)');
    }
    return Err<T>(failure);
  }
}

/// Traduce los errores de Supabase y de red a los fallos comunes.
Failure failureFromError(Object error) => switch (error) {
  final Failure failure => failure,
  final FunctionException e when isDailyLimit(e) => const DailyLimitFailure(),
  FunctionException(status: 429) => const RateLimitedFailure(),
  FunctionException(status: 503) => const AiBusyFailure(),
  PostgrestException(code: '23505') => const DuplicateFailure(),
  AuthRetryableFetchException() => const NetworkFailure(),
  ClientException() => const NetworkFailure(),
  _ => UnexpectedFailure(error),
};
