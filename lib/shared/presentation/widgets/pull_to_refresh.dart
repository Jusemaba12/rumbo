import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:rumbo/shared/utils/log.dart';

/// Deslizar hacia abajo para volver a leer los datos del servidor (cambios
/// hechos desde la web, la búsqueda diaria o Gmail). [child] debe ser
/// desplazable; si el contenido es corto, usar [AlwaysScrollableScrollPhysics].
class PullToRefresh extends ConsumerWidget {
  const PullToRefresh({
    super.key,
    required this.providers,
    required this.child,
  });

  /// Lo que se vuelve a leer al deslizar (`xProvider.future`).
  final List<Refreshable<Future<Object?>>> providers;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) => RefreshIndicator(
    onRefresh: () => refreshAll(ref: ref, providers: providers),
    child: child,
  );
}

/// Vuelve a leer [providers] y espera a que terminen. Un fallo no se lanza:
/// cada pantalla ya muestra su propio estado de error.
Future<void> refreshAll({
  required WidgetRef ref,
  required List<Refreshable<Future<Object?>>> providers,
}) async {
  try {
    await Future.wait(<Future<Object?>>[
      for (final Refreshable<Future<Object?>> provider in providers)
        ref.refresh(provider),
    ]);
  } catch (error) {
    Log.w(tag: 'PullToRefresh', message: 'refresh: $error');
  }
}

/// Contenido no desplazable (vacío, error) que aun así se puede deslizar
/// para actualizar.
class RefreshableFill extends StatelessWidget {
  const RefreshableFill({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) =>
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        ),
  );
}
