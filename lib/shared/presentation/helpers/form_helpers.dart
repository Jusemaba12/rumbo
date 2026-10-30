import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollCacheExtent;
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';

String? requiredValidator(BuildContext context, String? value) =>
    (value?.trim().isEmpty ?? true) ? context.l10n.requiredField : null;

/// Acepta el campo vacío o un enlace http(s) completo.
String? optionalUrlValidator(BuildContext context, String? value) {
  final String text = value?.trim() ?? '';
  if (text.isEmpty) return null;
  final Uri? uri = Uri.tryParse(text);
  final bool valid =
      uri != null &&
      (uri.scheme == 'http' || uri.scheme == 'https') &&
      uri.host.contains('.');
  return valid ? null : context.l10n.urlInvalid;
}

List<String> splitLines(String text) => _split(text: text, separator: '\n');

List<String> splitCommas(String text) => _split(text: text, separator: ',');

List<String> _split({required String text, required String separator}) => text
    .split(separator)
    .map((String part) => part.trim())
    .where((String part) => part.isNotEmpty)
    .toList();

/// Ejecuta [save], cierra la pantalla si sale bien y avisa si falla.
/// Guarda y, si sale bien, cierra la pantalla (avisando con [success] si se
/// indica); si falla, muestra el error y la deja abierta.
Future<void> saveAndClose(
  BuildContext context,
  Future<Result<Object?>> Function() save, {
  String? success,
}) async {
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  final NavigatorState navigator = Navigator.of(context);
  final AppLocalizations l10n = context.l10n;
  final bool done = showResultSnackBar(
    messenger: messenger,
    l10n: l10n,
    result: await save(),
    success: success,
  );
  if (done) navigator.pop();
}

Future<bool> confirmDelete(BuildContext context, String name) async {
  final AppLocalizations l10n = context.l10n;
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(l10n.deleteConfirmTitle(name)),
      content: Text(l10n.deleteConfirmBody),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.delete),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// Estructura común de las pantallas de edición del perfil.
class ProfileFormScaffold extends StatelessWidget {
  const ProfileFormScaffold({
    super.key,
    required this.title,
    required this.formKey,
    required this.onSave,
    required this.children,
    this.onDelete,
    this.onRefresh,
  });

  final String title;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final List<Widget> children;

  /// Deslizar hacia abajo vuelve a leer lo guardado (descarta lo no guardado).
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ListView list = ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      // Todos los campos quedan construidos: Form.validate() solo revisa los
      // que existen, y un campo obligatorio fuera de pantalla se saltaría.
      scrollCacheExtent: const ScrollCacheExtent.pixels(100000),
      padding: const EdgeInsets.all(16),
      itemCount: children.length + 1,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 16),
      itemBuilder: (BuildContext context, int index) => index < children.length
          ? children[index]
          : FilledButton(onPressed: onSave, child: Text(l10n.save)),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          if (onDelete != null)
            IconButton(
              onPressed: onDelete,
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: onRefresh == null
              ? list
              : RefreshIndicator(onRefresh: onRefresh!, child: list),
        ),
      ),
    );
  }
}
