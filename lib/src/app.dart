import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(goRouteProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'Lang Pocket',
      routerConfig: goRouter,
      onGenerateTitle: (BuildContext context) => 'Lang Pocket',
      // darkTheme: darkMode,
      // theme: lightMode,
      // themeMode: ref.watch(themeApp),
    );
  }
}
