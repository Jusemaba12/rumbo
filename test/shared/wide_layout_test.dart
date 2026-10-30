import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';

Future<void> _pump(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
      ],
      child: const RumboApp(locale: Locale('es')),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('en pantalla ancha usa menú lateral y contenido centrado', (
    WidgetTester tester,
  ) async {
    await _pump(tester, const Size(1280, 800));
    expect(find.byKey(const Key('navigationRail')), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    await tester.tap(find.text('Ofertas').first);
    await tester.pumpAndSettle();
    final Offset title = tester.getTopLeft(find.text('Ofertas').last);
    // El contenido no empieza pegado al menú: está centrado.
    expect(title.dx, greaterThan(200));
  });

  testWidgets('en el móvil mantiene la barra inferior', (
    WidgetTester tester,
  ) async {
    await _pump(tester, const Size(390, 844));
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byKey(const Key('navigationRail')), findsNothing);
  });
}
