import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    /// Ya se envió el código y se espera que el usuario lo escriba.
    @Default(false) bool codeSent,
    @Default(false) bool isLoading,
    @Default(false) bool hasFailed,
  }) = _SignInState;
}
