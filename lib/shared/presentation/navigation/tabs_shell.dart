import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rumbo/features/jobs/application/use_cases/analyze_job_use_case.dart';
import 'package:rumbo/features/reminders/presentation/helpers/reminder_sync.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/infrastructure/services/shared_text_source.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';

/// Ancho a partir del cual se usa el menú lateral en vez de la barra inferior.
const double wideLayoutWidth = 900.0;

/// Ancho máximo del contenido en pantallas anchas.
const double maxContentWidth = 760.0;

class TabsShell extends ConsumerStatefulWidget {
  const TabsShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  ConsumerState<TabsShell> createState() => _TabsShellState();
}

class _TabsShellState extends ConsumerState<TabsShell> {
  StatefulNavigationShell get shell => widget.shell;

  late final ReminderSync _reminders = ReminderSync(
    ref: ref,
    context: context,
    open: (String route) => mounted ? context.go(route) : null,
  );

  @override
  void initState() {
    super.initState();
    // Ofertas compartidas desde otra app: al abrir y con la app abierta.
    final SharedTextSource source = ref.read(sharedTextSourceProvider);
    source.listen(_openShared);
    Future<void>.microtask(_openShared);
    // Recordatorios locales: se reprograman cuando cambian procesos o
    // entrevistas.
    Future<void>.microtask(_reminders.start);
  }

  @override
  void dispose() {
    _reminders.dispose();
    super.dispose();
  }

  Future<void> _openShared() async {
    final String? shared = await ref.read(sharedTextSourceProvider).take();
    if (!mounted || shared == null || shared.trim().isEmpty) return;
    if (!ref.read(analyzeJobUseCaseProvider).isAvailable) return;
    JobNewRoute(shared: shared).go(context);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final List<(IconData, String)> tabs = <(IconData, String)>[
      (Icons.wb_sunny_outlined, l10n.tabHome),
      (Icons.work_outline, l10n.tabJobs),
      (Icons.view_kanban_outlined, l10n.tabApplications),
      (Icons.description_outlined, l10n.tabResume),
      (Icons.more_horiz, l10n.tabMore),
    ];
    // Tocar la pestaña activa vuelve a su pantalla raíz.
    void select(int index) =>
        shell.goBranch(index, initialLocation: index == shell.currentIndex);
    // En pantallas anchas (web o tableta): menú lateral y contenido centrado
    // a un ancho cómodo de leer.
    if (MediaQuery.sizeOf(context).width >= wideLayoutWidth) {
      return Scaffold(
        body: Row(
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border(right: BorderSide(color: context.colors.line)),
              ),
              child: NavigationRail(
                key: const Key('navigationRail'),
                selectedIndex: shell.currentIndex,
                onDestinationSelected: select,
                labelType: NavigationRailLabelType.all,
                backgroundColor: Colors.transparent,
                destinations: <NavigationRailDestination>[
                  for (final (IconData icon, String label) in tabs)
                    NavigationRailDestination(
                      icon: Icon(icon),
                      label: Text(label),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxContentWidth),
                  child: shell,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: shell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: context.colors.line)),
        ),
        child: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: select,
          destinations: <Widget>[
            for (final (IconData icon, String label) in tabs)
              NavigationDestination(icon: Icon(icon), label: label),
          ],
        ),
      ),
    );
  }
}
