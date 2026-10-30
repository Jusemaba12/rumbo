import 'package:flutter/material.dart';

/// Colores de Rumbo que no caben en [ColorScheme]: estados de los procesos,
/// avisos, compatibilidad y el bloque destacado de Inicio.
///
/// Se leen con `context.colors`.
@immutable
class RumboColors extends ThemeExtension<RumboColors> {
  const RumboColors({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.raised,
    required this.line,
    required this.text,
    required this.muted,
    required this.accent,
    required this.onAccent,
    required this.accentSoft,
    required this.onAccentSoft,
    required this.hero,
    required this.onHero,
    required this.heroMuted,
    required this.heroTile,
    required this.heroAccent,
    required this.heroSignalTile,
    required this.heroSignal,
    required this.info,
    required this.infoSoft,
    required this.onInfoSoft,
    required this.signal,
    required this.signalSoft,
    required this.onSignalSoft,
    required this.risk,
    required this.riskSoft,
    required this.onRiskSoft,
    required this.neutralSoft,
    required this.onNeutralSoft,
  });

  /// Fondo de las pantallas.
  final Color background;

  /// Tarjetas, barras y campos.
  final Color surface;

  /// Fondo de controles segmentados y zonas vacías.
  final Color surfaceMuted;

  /// Elemento elevado sobre [surfaceMuted] (opción activa de un selector):
  /// blanco en claro, más claro que el fondo en oscuro.
  final Color raised;

  /// Bordes y separadores.
  final Color line;
  final Color text;

  /// Texto secundario.
  final Color muted;

  /// Acción principal.
  final Color accent;
  final Color onAccent;
  final Color accentSoft;
  final Color onAccentSoft;

  /// Bloque «Para hoy» de Inicio.
  final Color hero;
  final Color onHero;
  final Color heroMuted;
  final Color heroTile;

  /// Cifras e iconos sobre el bloque «Para hoy».
  final Color heroAccent;

  /// Seguimientos atrasados sobre el bloque «Para hoy».
  final Color heroSignalTile;
  final Color heroSignal;

  /// Postulado, en revisión.
  final Color info;
  final Color infoSoft;
  final Color onInfoSoft;

  /// Atención: entrevistas, seguimientos, compatibilidad media.
  final Color signal;
  final Color signalSoft;
  final Color onSignalSoft;

  /// Riesgo: rechazos, compatibilidad baja, errores.
  final Color risk;
  final Color riskSoft;
  final Color onRiskSoft;

  /// Estados sin urgencia (guardada, preparando, sin respuesta).
  final Color neutralSoft;
  final Color onNeutralSoft;

  static const RumboColors light = RumboColors(
    background: Color(0xFFF4F6F5),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFE7ECEA),
    raised: Color(0xFFFFFFFF),
    line: Color(0xFFDDE4E1),
    text: Color(0xFF142019),
    muted: Color(0xFF56665F),
    accent: Color(0xFF0D6B5B),
    onAccent: Color(0xFFFFFFFF),
    accentSoft: Color(0xFFE0EFEA),
    onAccentSoft: Color(0xFF0A5246),
    hero: Color(0xFF0F3A32),
    onHero: Color(0xFFEAF5F1),
    heroMuted: Color(0xFFA9C9C0),
    heroTile: Color(0xFF1C5045),
    heroAccent: Color(0xFF7FE0C8),
    heroSignalTile: Color(0xFF4A3A16),
    heroSignal: Color(0xFFF2BE6B),
    info: Color(0xFF3E77AE),
    infoSoft: Color(0xFFE3ECF5),
    onInfoSoft: Color(0xFF2F5D8A),
    signal: Color(0xFFC98A2E),
    signalSoft: Color(0xFFFBEEDB),
    onSignalSoft: Color(0xFF8F5205),
    risk: Color(0xFFB03A2E),
    riskSoft: Color(0xFFF8E4E1),
    onRiskSoft: Color(0xFF9A3226),
    neutralSoft: Color(0xFFE7ECEA),
    onNeutralSoft: Color(0xFF3F4D48),
  );

  static const RumboColors dark = RumboColors(
    background: Color(0xFF0F1513),
    surface: Color(0xFF18211E),
    surfaceMuted: Color(0xFF222D29),
    raised: Color(0xFF34423D),
    line: Color(0xFF2A3632),
    text: Color(0xFFE3EBE8),
    muted: Color(0xFF93A49F),
    accent: Color(0xFF52C3AC),
    onAccent: Color(0xFF062520),
    accentSoft: Color(0xFF173A33),
    onAccentSoft: Color(0xFF8FDCCB),
    hero: Color(0xFF133A32),
    onHero: Color(0xFFEAF5F1),
    heroMuted: Color(0xFFA9C9C0),
    heroTile: Color(0xFF1F4D43),
    heroAccent: Color(0xFF7FE0C8),
    heroSignalTile: Color(0xFF4A3A16),
    heroSignal: Color(0xFFF2BE6B),
    info: Color(0xFF6FA4D6),
    infoSoft: Color(0xFF1B2C3D),
    onInfoSoft: Color(0xFF9CC3E8),
    signal: Color(0xFFE3A54E),
    signalSoft: Color(0xFF3A2B16),
    onSignalSoft: Color(0xFFF2C57F),
    risk: Color(0xFFEE8577),
    riskSoft: Color(0xFF3D1F1B),
    onRiskSoft: Color(0xFFF4A99E),
    neutralSoft: Color(0xFF252F2B),
    onNeutralSoft: Color(0xFFB5C3BE),
  );

  @override
  RumboColors copyWith() => this;

  @override
  RumboColors lerp(RumboColors? other, double t) {
    if (other == null) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return RumboColors(
      background: mix(background, other.background),
      surface: mix(surface, other.surface),
      surfaceMuted: mix(surfaceMuted, other.surfaceMuted),
      raised: mix(raised, other.raised),
      line: mix(line, other.line),
      text: mix(text, other.text),
      muted: mix(muted, other.muted),
      accent: mix(accent, other.accent),
      onAccent: mix(onAccent, other.onAccent),
      accentSoft: mix(accentSoft, other.accentSoft),
      onAccentSoft: mix(onAccentSoft, other.onAccentSoft),
      hero: mix(hero, other.hero),
      onHero: mix(onHero, other.onHero),
      heroMuted: mix(heroMuted, other.heroMuted),
      heroTile: mix(heroTile, other.heroTile),
      heroAccent: mix(heroAccent, other.heroAccent),
      heroSignalTile: mix(heroSignalTile, other.heroSignalTile),
      heroSignal: mix(heroSignal, other.heroSignal),
      info: mix(info, other.info),
      infoSoft: mix(infoSoft, other.infoSoft),
      onInfoSoft: mix(onInfoSoft, other.onInfoSoft),
      signal: mix(signal, other.signal),
      signalSoft: mix(signalSoft, other.signalSoft),
      onSignalSoft: mix(onSignalSoft, other.onSignalSoft),
      risk: mix(risk, other.risk),
      riskSoft: mix(riskSoft, other.riskSoft),
      onRiskSoft: mix(onRiskSoft, other.onRiskSoft),
      neutralSoft: mix(neutralSoft, other.neutralSoft),
      onNeutralSoft: mix(onNeutralSoft, other.onNeutralSoft),
    );
  }
}

/// Tonos de los avisos, etiquetas y fichas de color.
enum Tone { accent, info, signal, risk, neutral }

extension RumboColorsContext on BuildContext {
  RumboColors get colors =>
      Theme.of(this).extension<RumboColors>() ?? RumboColors.light;
}

extension ToneColors on RumboColors {
  /// Fondo suave y color de texto/icono para [tone].
  (Color background, Color foreground) soft(Tone tone) => switch (tone) {
    Tone.accent => (accentSoft, onAccentSoft),
    Tone.info => (infoSoft, onInfoSoft),
    Tone.signal => (signalSoft, onSignalSoft),
    Tone.risk => (riskSoft, onRiskSoft),
    Tone.neutral => (neutralSoft, onNeutralSoft),
  };
}
