import 'package:rumbo/shared/domain/failures/failure.dart';

/// Resultado de una operación que puede fallar. Los repositorios y los casos
/// de uso devuelven [Result] en lugar de lanzar excepciones; la presentación
/// decide qué mostrar con un `switch`.
sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;

  /// El valor si salió bien; nulo si falló.
  T? get valueOrNull => switch (this) {
    Ok<T>(:final T value) => value,
    Err<T>() => null,
  };

  /// El fallo si lo hubo; nulo si salió bien.
  Failure? get failureOrNull => switch (this) {
    Ok<T>() => null,
    Err<T>(:final Failure failure) => failure,
  };

  /// Devuelve el valor o lanza el [Failure]. Para los providers asíncronos,
  /// que convierten la excepción en `AsyncError`, y para los tests.
  T getOrThrow() => switch (this) {
    Ok<T>(:final T value) => value,
    Err<T>(:final Failure failure) => throw failure,
  };

  /// Transforma el valor si salió bien y conserva el fallo si no.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Ok<T>(:final T value) => Ok<R>(transform(value)),
    Err<T>(:final Failure failure) => Err<R>(failure),
  };

  /// Encadena otra operación que también puede fallar.
  Future<Result<R>> andThen<R>(
    Future<Result<R>> Function(T value) next,
  ) async => switch (this) {
    Ok<T>(:final T value) => next(value),
    Err<T>(:final Failure failure) => Err<R>(failure),
  };
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;

  @override
  bool operator ==(Object other) => other is Ok<T> && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Ok($value)';
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is Err<T> && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;

  @override
  String toString() => 'Err($failure)';
}

/// Atajo para las operaciones que solo pueden salir bien o fallar.
const Ok<void> ok = Ok<void>(null);
