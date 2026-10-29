import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/data/auth_repository.dart';

class _FakeAuth implements AuthRepository {
  _FakeAuth({required this._signedIn});

  bool _signedIn;
  final _changes = StreamController<bool>.broadcast();
  String? sentTo;

  @override
  bool get isSignedIn => _signedIn;

  @override
  Stream<bool> get signedInChanges => _changes.stream;

  @override
  Future<void> sendCode(String email) async => sentTo = email;

  @override
  Future<void> verifyCode({required String email, required String code}) async {
    _signedIn = true;
    _changes.add(true);
  }

  @override
  Future<void> signOut() async {
    _signedIn = false;
    _changes.add(false);
  }
}

Future<void> _pumpApp(WidgetTester tester, AuthRepository auth) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(auth)],
      child: const RumboApp(locale: Locale('es')),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('con sesión muestra las cinco pestañas y navega', (tester) async {
    await _pumpApp(tester, _FakeAuth(signedIn: true));

    expect(find.byType(NavigationDestination), findsNWidgets(5));
    expect(find.text('Tu resumen del día'), findsOneWidget);

    await tester.tap(find.text('Procesos'));
    await tester.pumpAndSettle();
    expect(find.text('Aún no tienes postulaciones'), findsOneWidget);
  });

  testWidgets('sin sesión pide el correo y entra con el código', (
    tester,
  ) async {
    final auth = _FakeAuth(signedIn: false);
    await _pumpApp(tester, auth);

    expect(find.text('Entra a Rumbo'), findsOneWidget);

    await tester.tap(find.text('Enviar código'));
    await tester.pump();
    expect(find.text('Escribe un correo válido'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'yo@ejemplo.com');
    await tester.tap(find.text('Enviar código'));
    await tester.pumpAndSettle();
    expect(auth.sentTo, 'yo@ejemplo.com');

    await tester.enterText(find.byType(TextFormField).last, '12345');
    await tester.tap(find.text('Entrar'));
    await tester.pump();
    expect(find.text('El código tiene entre 6 y 10 dígitos'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).last, '12345678');
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();
    expect(find.text('Tu resumen del día'), findsOneWidget);
  });
}
