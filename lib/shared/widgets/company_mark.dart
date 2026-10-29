import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// Iniciales de la empresa sobre un cuadro de color, para reconocerla de un
/// vistazo en listas. El color sale del nombre, así que siempre es el mismo.
class CompanyMark extends StatelessWidget {
  const CompanyMark({super.key, required this.company, this.size = 40});

  final String company;
  final double size;

  static const _tones = [Tone.accent, Tone.info, Tone.signal, Tone.neutral];

  /// «Grupo Mariposa» → «GM»; «Forest» → «FO».
  static String initials(String company) {
    final words = company
        .split(RegExp(r'[\s\-_.]+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return '?';
    if (words.length == 1) {
      final word = words.first;
      return word.substring(0, word.length < 2 ? 1 : 2).toUpperCase();
    }
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final hash = company.trim().toLowerCase().codeUnits.fold(
      0,
      (a, b) => a + b,
    );
    final (background, foreground) = context.colors.soft(
      _tones[hash % _tones.length],
    );
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(size * 0.3),
        ),
        child: Text(
          initials(company),
          style: TextStyle(
            fontFamily: AppTheme.displayFont,
            fontWeight: FontWeight.w700,
            fontSize: size * 0.38,
            color: foreground,
            height: 1,
          ),
        ),
      ),
    );
  }
}
