import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf_picker.g.dart';

/// Abre el selector de archivos; devuelve nulo si el usuario cancela.
typedef PdfPicker = Future<Uint8List?> Function();

@Riverpod(keepAlive: true)
PdfPicker pdfPicker(Ref ref) => () async {
  // pickFile elige un solo archivo: basta con tocarlo.
  final PlatformFile? file = await FilePicker.pickFile(
    type: FileType.custom,
    allowedExtensions: const <String>['pdf'],
  );
  return file?.xFile.readAsBytes();
};
