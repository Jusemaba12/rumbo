import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/account/domain/entities/app_release.dart';
import 'package:rumbo/features/account/infrastructure/di/account_providers.dart';
import 'package:rumbo/features/account/infrastructure/repositories/local_account_repository.dart';
import 'package:rumbo/features/account/presentation/providers/account/account_provider.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';

const AppRelease _release = AppRelease(
  versionName: '0.3.0',
  versionCode: 10,
  downloadUrl: 'https://example.com/Rumbo-0.3.0.apk',
);

Future<void> _pump(
  WidgetTester tester,
  LocalAccountRepository account, {
  int? installedBuild,
}) async {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
        accountRepositoryProvider.overrideWithValue(account),
        installedBuildProvider.overrideWith((Ref ref) async => installedBuild),
      ],
      child: const RumboApp(locale: Locale('es')),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  test('la versión publicada se compara sin el prefijo de arquitectura', () {
    expect(_release.isNewerThan(9), isTrue);
    expect(_release.isNewerThan(2009), isTrue);
    expect(_release.isNewerThan(2010), isFalse);
    expect(_release.isNewerThan(11), isFalse);
  });

  testWidgets('hay que aceptar el aviso de privacidad antes de entrar', (
    WidgetTester tester,
  ) async {
    final LocalAccountRepository account = LocalAccountRepository(
      accepted: false,
    );
    await _pump(tester, account);
    expect(find.text('Antes de empezar'), findsOneWidget);
    expect(find.textContaining('hasta 40 veces al día'), findsOneWidget);
    expect(find.text('Más'), findsNothing);

    await tester.tap(find.byKey(const Key('acceptPrivacy')));
    await tester.pumpAndSettle();
    expect(account.accepted, isTrue);
    expect(find.text('Antes de empezar'), findsNothing);
    expect(find.text('Más'), findsOneWidget);
  });

  testWidgets('una cuenta nueva ve los primeros pasos', (
    WidgetTester tester,
  ) async {
    await _pump(tester, LocalAccountRepository());
    expect(find.byKey(const Key('firstSteps')), findsOneWidget);
    expect(find.byKey(const Key('firstStepProfile')), findsOneWidget);
    expect(find.byKey(const Key('firstStepSearch')), findsOneWidget);
  });

  testWidgets('avisa de una versión nueva del APK', (
    WidgetTester tester,
  ) async {
    await _pump(
      tester,
      LocalAccountRepository(release: _release),
      installedBuild: 2006,
    );
    expect(find.byKey(const Key('updateBanner')), findsOneWidget);
    expect(
      find.text('Hay una versión nueva de Rumbo (0.3.0).'),
      findsOneWidget,
    );
  });

  testWidgets('sin versión nueva no hay aviso', (WidgetTester tester) async {
    await _pump(
      tester,
      LocalAccountRepository(release: _release),
      installedBuild: 2010,
    );
    expect(find.byKey(const Key('updateBanner')), findsNothing);
  });
}
