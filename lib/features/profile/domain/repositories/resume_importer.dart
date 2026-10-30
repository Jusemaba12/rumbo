import 'dart:typed_data';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Debe coincidir con MAX_PDF_BYTES en la función `import-resume`.
const int maxResumeBytes = 5 * 1024 * 1024;

/// Lee una HV en PDF y devuelve lo que contiene, sin guardar nada.
abstract interface class ResumeImporter {
  /// Falla con `FileTooLargeFailure` o `UnreadableFileFailure`.
  Future<Result<ProfileData>> extract(Uint8List pdf);
}
