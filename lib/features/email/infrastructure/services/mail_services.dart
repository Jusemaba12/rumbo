import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:url_launcher/url_launcher.dart';

part 'mail_services.g.dart';

/// URL de la función que recibe los correos del script.
String emailSyncUrl() => '${Env.supabaseUrl}/functions/v1/email-sync';

/// Copia el texto al portapapeles; se sustituye en los tests.
@Riverpod(keepAlive: true)
Future<void> Function(String) clipboardWriter(Ref ref) =>
    (String text) => Clipboard.setData(ClipboardData(text: text));

/// Abre la app de correo con un enlace mailto; falso si no se pudo.
@Riverpod(keepAlive: true)
Future<bool> Function(Uri) mailLauncher(Ref ref) =>
    (Uri uri) => launchUrl(uri, mode: LaunchMode.externalApplication);

/// Abre la app de correo con el PDF adjunto y el borrador. En iOS el menú
/// de compartir no rellena el destinatario (se copia antes); en Android sí.
typedef MailWithAttachment = Future<void> Function({
  required Uint8List pdf,
  required String fileName,
  required String to,
  required String subject,
  required String body,
});

@Riverpod(keepAlive: true)
MailWithAttachment mailWithAttachment(Ref ref) =>
    ({
      required Uint8List pdf,
      required String fileName,
      required String to,
      required String subject,
      required String body,
    }) => Printing.sharePdf(
      bytes: pdf,
      filename: fileName,
      subject: subject,
      body: body,
      emails: <String>[if (to.isNotEmpty) to],
    );
