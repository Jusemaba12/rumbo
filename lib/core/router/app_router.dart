import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/account/presentation/account_controller.dart';
import '../../features/auth/data/auth_repository.dart';
import 'routes.dart';

export 'routes.dart';
export 'tabs_shell.dart' show maxContentWidth, wideLayoutWidth;

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final auth = ref.watch(authRepositoryProvider);
  final refresh = _StreamListenable(auth.signedInChanges);
  ref.onDispose(refresh.dispose);

  // Aceptar el aviso de privacidad también cambia a dónde se puede ir.
  ref.listen(privacyAcceptedProvider, (_, _) => refresh.notify());

  const signIn = SignInRoute();
  const welcome = WelcomeRoute();
  const home = HomeRoute();
  final router = GoRouter(
    initialLocation: home.location,
    refreshListenable: refresh,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final atSignIn = location == signIn.location;
      if (!auth.isSignedIn) return atSignIn ? null : signIn.location;
      // Mientras se comprueba, no se mueve a nadie.
      final accepted = ref.read(privacyAcceptedProvider).value;
      final atWelcome = location == welcome.location;
      if (accepted == false) return atWelcome ? null : welcome.location;
      return atSignIn || atWelcome ? home.location : null;
    },
    routes: $appRoutes,
  );
  ref.onDispose(router.dispose);
  return router;
}

class _StreamListenable extends ChangeNotifier {
  _StreamListenable(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  void notify() => notifyListeners();

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
