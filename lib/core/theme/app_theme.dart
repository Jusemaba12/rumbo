import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tema de Rumbo: verde sobre fondo claro (u oscuro), títulos en Bricolage
/// Grotesque, texto en IBM Plex Sans y cifras en IBM Plex Mono.
abstract final class AppTheme {
  static const displayFont = 'Bricolage Grotesque';
  static const bodyFont = 'IBM Plex Sans';
  static const monoFont = 'IBM Plex Mono';

  /// Radios de esquina: controles, tarjetas y bloques grandes.
  static const radiusSmall = 14.0;
  static const radius = 20.0;
  static const radiusLarge = 24.0;

  static ThemeData light() => _build(Brightness.light, RumboColors.light);
  static ThemeData dark() => _build(Brightness.dark, RumboColors.dark);

  /// Estilo para cifras (notas, salarios, contadores): monoespaciado y con
  /// dígitos de ancho fijo.
  static TextStyle numbers(TextStyle? base) =>
      (base ?? const TextStyle()).copyWith(
        fontFamily: monoFont,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  /// Título grande de las pantallas raíz de cada pestaña.
  static TextStyle screenTitle(BuildContext context) => TextStyle(
    fontFamily: displayFont,
    fontWeight: FontWeight.w700,
    fontSize: 30,
    letterSpacing: -0.6,
    color: context.colors.text,
  );

  /// Título de una sección dentro de una pantalla («Novedades del correo»).
  static TextStyle sectionTitle(BuildContext context) => TextStyle(
    fontFamily: displayFont,
    fontWeight: FontWeight.w600,
    fontSize: 19,
    color: context.colors.text,
  );

  /// Etiqueta corta sobre una sección («Necesita acción»).
  static TextStyle overline(BuildContext context, {Color? color}) => TextStyle(
    fontFamily: monoFont,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    letterSpacing: 0.7,
    color: color ?? context.colors.muted,
  );

  static ThemeData _build(Brightness brightness, RumboColors c) {
    final dark = brightness == Brightness.dark;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D6B5B),
          brightness: brightness,
        ).copyWith(
          primary: c.accent,
          onPrimary: c.onAccent,
          primaryContainer: c.accentSoft,
          onPrimaryContainer: c.onAccentSoft,
          secondary: c.info,
          secondaryContainer: c.infoSoft,
          onSecondaryContainer: c.onInfoSoft,
          tertiary: c.signal,
          tertiaryContainer: c.signalSoft,
          onTertiaryContainer: c.onSignalSoft,
          error: c.risk,
          errorContainer: c.riskSoft,
          onErrorContainer: c.onRiskSoft,
          surface: c.background,
          onSurface: c.text,
          onSurfaceVariant: c.muted,
          surfaceContainerLowest: dark
              ? const Color(0xFF0B100E)
              : const Color(0xFFFFFFFF),
          surfaceContainerLow: c.surface,
          surfaceContainer: dark
              ? const Color(0xFF1C2622)
              : const Color(0xFFEEF2F0),
          surfaceContainerHigh: c.surfaceMuted,
          surfaceContainerHighest: dark
              ? const Color(0xFF28342F)
              : const Color(0xFFE1E7E4),
          outline: dark ? const Color(0xFF3A4843) : const Color(0xFFC3CDC9),
          outlineVariant: c.line,
          surfaceTint: Colors.transparent,
        );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: bodyFont,
    );
    final text = _textTheme(base.textTheme, c);

    final controlShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusSmall),
    );
    OutlineInputBorder inputBorder(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
          borderSide: BorderSide(color: color, width: width),
        );

    return base.copyWith(
      textTheme: text,
      scaffoldBackgroundColor: c.background,
      extensions: [c],
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: c.background,
        foregroundColor: c.text,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleTextStyle: text.titleLarge?.copyWith(
          fontFamily: displayFont,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: c.line),
        ),
      ),
      dividerTheme: DividerThemeData(color: c.line, thickness: 1, space: 1),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: bodyFont,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          foregroundColor: c.text,
          backgroundColor: c.surface,
          side: BorderSide(color: c.line),
          shape: controlShape,
          textStyle: const TextStyle(
            fontFamily: bodyFont,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 44),
          shape: controlShape,
          textStyle: const TextStyle(
            fontFamily: bodyFont,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          backgroundColor: c.surface,
          selectedBackgroundColor: c.accentSoft,
          selectedForegroundColor: c.onAccentSoft,
          side: BorderSide(color: c.line),
          shape: controlShape,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        border: inputBorder(c.line),
        enabledBorder: inputBorder(c.line),
        focusedBorder: inputBorder(c.accent, 2),
        errorBorder: inputBorder(c.risk),
        focusedErrorBorder: inputBorder(c.risk, 2),
        labelStyle: TextStyle(color: c.muted),
        floatingLabelStyle: TextStyle(color: c.accent),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.surface,
        selectedColor: c.accentSoft,
        side: BorderSide(color: c.line),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        labelStyle: TextStyle(
          fontFamily: bodyFont,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: c.text,
        ),
        checkmarkColor: c.onAccentSoft,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 68,
        indicatorColor: c.accentSoft,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontFamily: bodyFont,
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
            color: states.contains(WidgetState.selected) ? c.accent : c.muted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? c.accent : c.muted,
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: c.muted,
        subtitleTextStyle: text.bodyMedium?.copyWith(color: c.muted),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.accent,
        foregroundColor: c.onAccent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLarge),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: dark ? c.surfaceMuted : c.text,
        contentTextStyle: TextStyle(
          fontFamily: bodyFont,
          fontSize: 15,
          color: dark ? c.text : c.surface,
        ),
        shape: controlShape,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: c.accent,
        unselectedLabelColor: c.muted,
        indicatorColor: c.accent,
        dividerColor: c.line,
        labelStyle: const TextStyle(
          fontFamily: bodyFont,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: bodyFont,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  /// Títulos grandes en Bricolage; el resto en Plex Sans sin el espaciado
  /// ancho de Material, que con Plex se ve suelto.
  static TextTheme _textTheme(TextTheme base, RumboColors c) {
    TextStyle? display(TextStyle? s, FontWeight weight) => s?.copyWith(
      fontFamily: displayFont,
      fontWeight: weight,
      letterSpacing: -0.4,
      color: c.text,
    );
    TextStyle? body(TextStyle? s, {FontWeight? weight}) => s?.copyWith(
      fontFamily: bodyFont,
      letterSpacing: 0,
      fontWeight: weight,
      color: c.text,
    );
    return base.copyWith(
      displayLarge: display(base.displayLarge, FontWeight.w700),
      displayMedium: display(base.displayMedium, FontWeight.w700),
      displaySmall: display(base.displaySmall, FontWeight.w700),
      headlineLarge: display(base.headlineLarge, FontWeight.w700),
      headlineMedium: display(base.headlineMedium, FontWeight.w700),
      headlineSmall: display(base.headlineSmall, FontWeight.w700),
      titleLarge: display(base.titleLarge, FontWeight.w600),
      titleMedium: body(base.titleMedium, weight: FontWeight.w600),
      titleSmall: body(base.titleSmall, weight: FontWeight.w600),
      bodyLarge: body(base.bodyLarge),
      bodyMedium: body(base.bodyMedium),
      bodySmall: body(base.bodySmall)?.copyWith(color: c.muted),
      labelLarge: body(base.labelLarge, weight: FontWeight.w600),
      labelMedium: body(base.labelMedium, weight: FontWeight.w600),
      labelSmall: body(base.labelSmall, weight: FontWeight.w500),
    );
  }
}
