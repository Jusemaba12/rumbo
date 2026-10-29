import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// Aviso en línea sobre fondo de color: seguimientos, plazos, advertencias.
class NoticeBanner extends StatelessWidget {
  const NoticeBanner({
    super.key,
    required this.text,
    this.icon = Icons.schedule,
    this.tone = Tone.signal,
    this.action,
  });

  final String text;
  final IconData icon;
  final Tone tone;

  /// Botón opcional a la derecha (normalmente un [TextButton]).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = context.colors.soft(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall - 2),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: foreground),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: foreground),
            ),
          ),
          if (action != null) ...[const SizedBox(width: 8), action!],
        ],
      ),
    );
  }
}
