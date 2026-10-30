import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/shared/utils/log.dart';

part 'pdf_services.g.dart';

/// Comparte el PDF (guardar en Archivos, enviar por correo, etc.).
typedef PdfSharer = Future<void> Function(List<int> bytes, String fileName);

@Riverpod(keepAlive: true)
PdfSharer pdfSharer(Ref ref) =>
    (List<int> bytes, String fileName) =>
        Printing.sharePdf(bytes: Uint8List.fromList(bytes), filename: fileName);

/// Fuentes con tildes y eñes; se descargan una vez y quedan en caché.
@Riverpod(keepAlive: true)
Future<(pw.Font, pw.Font)?> resumeFonts(Ref ref) async {
  try {
    return (
      await PdfGoogleFonts.notoSansRegular(),
      await PdfGoogleFonts.notoSansBold(),
    );
  } catch (error) {
    // Sin conexión se usan las fuentes del PDF, sin tildes garantizadas.
    Log.w(tag: 'ResumeFonts', message: 'No se pudieron descargar: $error');
    return null;
  }
}
