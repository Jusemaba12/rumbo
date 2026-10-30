import 'package:flutter/material.dart';

/// Tarjeta con filas separadas por líneas finas (listas de ajustes,
/// experiencias, accesos).
class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.children, this.indent = 16});

  final List<Widget> children;

  /// Sangría de las líneas separadoras (52 si las filas llevan icono).
  final double indent;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: <Widget>[
        for (final (int index, Widget child) in children.indexed) ...<Widget>[
          if (index > 0) Divider(indent: indent),
          child,
        ],
      ],
    ),
  );
}

/// Icono sobre un cuadro de color suave, para encabezar filas.
class TileIcon extends StatelessWidget {
  const TileIcon(this.icon, {super.key, this.background, this.foreground});

  final IconData icon;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: background ?? scheme.primaryContainer,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Icon(
        icon,
        size: 20,
        color: foreground ?? scheme.onPrimaryContainer,
      ),
    );
  }
}
