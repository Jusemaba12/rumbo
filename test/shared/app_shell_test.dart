import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

class _FakeAuth implements AuthRepository {
  _FakeAuth({required this._signedIn});

  bool _signedIn;
  final StreamController<bool> _changes = StreamController<bool>.broadcast();
  String? sentTo;

  @override
  bool get isSignedIn => _signedIn;

  @override
  Stream<bool> get signedInChanges => _changes.stream;

  @override
  Future<Result<void>> sendCode(String email) async {
    sentTo = email;
    return ok;
  }

  @override
  Future<Result<void>> verifyCode({
    required String email,
    required String code,
  }) async {
    _signedIn = true;
    _changes.add(true);
    return ok;
  }

  @override
  Future<Result<void>> signOut() async {
    _signedIn = false;
    _changes.add(false);
    return ok;
  }
}

Future<void> _pumpApp(WidgetTester tester, AuthRepository auth) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[authRepositoryProvider.overrideWithValue(auth)],
      child: const RumboApp(locale: Locale('es')),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('con sesión muestra las cinco pestañas y navega', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester, _FakeAuth(signedIn: true));

    expect(find.byType(NavigationDestination), findsNWidgets(5));
    expect(find.text('Tu resumen del día'), findsOneWidget);

    await tester.tap(find.text('Procesos'));
    await tester.pumpAndSettle();
    expect(find.text('Aún no tienes postulaciones'), findsOneWidget);
  });

  testWidgets('sin sesión pide el correo y entra con el código', (
    WidgetTester tester,
  ) async {
    final _FakeAuth auth = _FakeAuth(signedIn: false);
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
