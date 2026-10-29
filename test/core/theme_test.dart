import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/core/theme/app_colors.dart';
import 'package:rumbo/core/theme/app_theme.dart';
import 'package:rumbo/features/applications/domain/application_status.dart';
import 'package:rumbo/features/applications/presentation/application_widgets.dart';
import 'package:rumbo/features/jobs/presentation/job_widgets.dart';
import 'package:rumbo/l10n/app_localizations.dart';
import 'package:rumbo/shared/widgets/company_mark.dart';

Widget _wrap(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? AppTheme.light(),
  locale: const Locale('es'),
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: Center(child: child)),
);

void main() {
  test('los dos temas llevan los colores de Rumbo', () {
    expect(AppTheme.light().extension<RumboColors>(), RumboColors.light);
    expect(AppTheme.dark().extension<RumboColors>(), RumboColors.dark);
    expect(AppTheme.light().colorScheme.primary, RumboColors.light.accent);
  });

  test('iniciales de la empresa', () {
    expect(CompanyMark.initials('Grupo Mariposa'), 'GM');
    expect(CompanyMark.initials('Forest'), 'FO');
    expect(CompanyMark.initials('routed-labs'), 'RL');
    expect(CompanyMark.initials('X'), 'X');
    expect(CompanyMark.initials('  '), '?');
  });

  testWidgets('la nota muestra cifra y nivel', (tester) async {
    await tester.pumpWidget(_wrap(const ScoreBadge(score: 65)));
    expect(find.text('65'), findsOneWidget);
    expect(find.text('MEDIA'), findsOneWidget);
    expect(find.bySemanticsLabel('Compatibilidad: 65 de 100'), findsOneWidget);
  });

  testWidgets('la nota pequeña omite el nivel', (tester) async {
    await tester.pumpWidget(_wrap(const ScoreBadge(score: 90, size: 36)));
    expect(find.text('90'), findsOneWidget);
    expect(find.text('ALTA'), findsNothing);
  });

  test('cada estado tiene su tono', () {
    expect(statusTone(ApplicationStatus.applied), Tone.info);
    expect(statusTone(ApplicationStatus.interview), Tone.signal);
    expect(statusTone(ApplicationStatus.rejected), Tone.risk);
    expect(statusTone(ApplicationStatus.offer), Tone.accent);
    expect(statusTone(ApplicationStatus.preparing), Tone.neutral);
  });

  testWidgets('las etiquetas de estado se ven en tema oscuro', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const StatusPill(status: ApplicationStatus.interview),
        theme: AppTheme.dark(),
      ),
    );
    final text = tester.widget<Text>(find.text('Entrevista'));
    expect(text.style?.color, RumboColors.dark.onSignalSoft);
  });
}
