import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollCacheExtent;

import '../../../l10n/app_localizations.dart';

String? requiredValidator(BuildContext context, String? value) =>
    (value?.trim().isEmpty ?? true)
    ? AppLocalizations.of(context).requiredField
    : null;

/// Acepta el campo vacío o un enlace http(s) completo.
String? optionalUrlValidator(BuildContext context, String? value) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) return null;
  final uri = Uri.tryParse(text);
  final valid =
      uri != null &&
      (uri.scheme == 'http' || uri.scheme == 'https') &&
      uri.host.contains('.');
  return valid ? null : AppLocalizations.of(context).urlInvalid;
}

List<String> splitLines(String text) => _split(text, '\n');

List<String> splitCommas(String text) => _split(text, ',');

List<String> _split(String text, String separator) => text
    .split(separator)
    .map((part) => part.trim())
    .where((part) => part.isNotEmpty)
    .toList();

/// Ejecuta [save], cierra la pantalla si sale bien y avisa si falla.
Future<void> saveAndClose(
  BuildContext context,
  Future<void> Function() save,
) async {
  final messenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context);
  final errorText = AppLocalizations.of(context).saveError;
  try {
    await save();
    navigator.pop();
  } catch (_) {
    messenger.showSnackBar(SnackBar(content: Text(errorText)));
  }
}

Future<bool> confirmDelete(BuildContext context, String name) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.deleteConfirmTitle(name)),
      content: Text(l10n.deleteConfirmBody),
      actions: [
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
    final l10n = AppLocalizations.of(context);
    final list = ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      // Todos los campos quedan construidos: Form.validate() solo revisa los
      // que existen, y un campo obligatorio fuera de pantalla se saltaría.
      scrollCacheExtent: const ScrollCacheExtent.pixels(100000),
      padding: const EdgeInsets.all(16),
      itemCount: children.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) => index < children.length
          ? children[index]
          : FilledButton(onPressed: onSave, child: Text(l10n.save)),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
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
