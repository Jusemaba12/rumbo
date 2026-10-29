import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// Rótulo pequeño en letra monoespaciada encima de un grupo de tarjetas.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Semantics(
      header: true,
      child: Text(text, style: AppTheme.overline(context, color: color)),
    ),
  );
}
