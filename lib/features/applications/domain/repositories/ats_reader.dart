import 'dart:typed_data';

import 'package:rumbo/shared/domain/result.dart';

/// Texto que un ATS extrae del PDF.
typedef AtsReading = ({String text, int pages});

/// Lee un PDF como lo haría un ATS (función `ats-read`, sin IA).
abstract interface class AtsReader {
  Future<Result<AtsReading>> read(Uint8List pdf);
}
