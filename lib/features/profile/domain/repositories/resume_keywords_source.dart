import 'package:rumbo/features/profile/domain/entities/resume_keyword.dart';
import 'package:rumbo/shared/domain/result.dart';

abstract interface class ResumeKeywordsSource {
  /// Las palabras clave guardadas, sin gastar IA; nulo si no hay.
  Future<Result<KeywordsResult?>> cached();

  /// Pide las palabras clave de los cargos de las preferencias. Sin [force]
  /// el servidor devuelve las guardadas si siguen valiendo. Falla con
  /// `NoRolesFailure` si no hay cargos.
  Future<Result<KeywordsResult>> fetch({bool force = false});
}
