import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/account/presentation/providers/account/account_provider.dart';
import 'package:rumbo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final AuthRepository auth = ref.watch(authRepositoryProvider);
  final _StreamListenable refresh = _StreamListenable(auth.signedInChanges);
  ref.onDispose(refresh.dispose);

  // Aceptar el aviso de privacidad también cambia a dónde se puede ir.
  ref.listen(privacyAcceptedProvider, (_, _) => refresh.notify());

  const SignInRoute signIn = SignInRoute();
  const WelcomeRoute welcome = WelcomeRoute();
  const HomeRoute home = HomeRoute();
  final GoRouter router = GoRouter(
    initialLocation: home.location,
    refreshListenable: refresh,
    redirect: (BuildContext context, GoRouterState state) {
      final String location = state.matchedLocation;
      final bool atSignIn = location == signIn.location;
      if (!auth.isSignedIn) return atSignIn ? null : signIn.location;
      // Mientras se comprueba, no se mueve a nadie.
      final bool? accepted = ref.read(privacyAcceptedProvider).value;
      final bool atWelcome = location == welcome.location;
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
