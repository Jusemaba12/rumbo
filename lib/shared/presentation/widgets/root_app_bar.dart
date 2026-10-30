import 'package:flutter/material.dart';

import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';

/// Barra de las pantallas raíz de cada pestaña: título grande y acciones.
AppBar rootAppBar(
  BuildContext context,
  String title, {
  List<Widget> actions = const <Widget>[],
}) => AppBar(
  toolbarHeight: 64,
  title: Text(title, style: AppTheme.screenTitle(context)),
  actions: <Widget>[
    ...actions,
    if (actions.isNotEmpty) const SizedBox(width: 12),
  ],
);

/// Botón cuadrado de 44 para la barra raíz: relleno (acción principal) o
/// con borde.
class BarButton extends StatelessWidget {
  const BarButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.filled = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final RumboColors colors = context.colors;
    final RoundedRectangleBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
    );
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: filled
          ? IconButton.filled(
              tooltip: tooltip,
              onPressed: onPressed,
              style: IconButton.styleFrom(
                fixedSize: const Size(44, 44),
                shape: shape,
              ),
              icon: Icon(icon),
            )
          : IconButton.outlined(
              tooltip: tooltip,
              onPressed: onPressed,
              style: IconButton.styleFrom(
                backgroundColor: colors.surface,
                side: BorderSide(color: colors.line),
                fixedSize: const Size(44, 44),
                shape: shape,
              ),
              icon: Icon(icon),
            ),
    );
  }
}
