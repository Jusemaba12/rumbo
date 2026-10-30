import 'package:flutter/material.dart';

import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';

/// Iniciales de la empresa sobre un cuadro de color, para reconocerla de un
/// vistazo en listas. El color sale del nombre, así que siempre es el mismo.
class CompanyMark extends StatelessWidget {
  const CompanyMark({super.key, required this.company, this.size = 40});

  final String company;
  final double size;

  static const List<Tone> _tones = <Tone>[
    Tone.accent,
    Tone.info,
    Tone.signal,
    Tone.neutral,
  ];

  /// «Grupo Mariposa» → «GM»; «Forest» → «FO».
  static String initials(String company) {
    final List<String> words = company
        .split(RegExp(r'[\s\-_.]+'))
        .where((String w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return '?';
    if (words.length == 1) {
      final String word = words.first;
      return word.substring(0, word.length < 2 ? 1 : 2).toUpperCase();
    }
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final int hash = company.trim().toLowerCase().codeUnits.fold(
      0,
      (int a, int b) => a + b,
    );
    final (Color background, Color foreground) = context.colors.soft(
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
