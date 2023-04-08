import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/styles/light_mode.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'Lang Pocket',
      routerConfig: goroute,
      onGenerateTitle: (BuildContext context) => 'Lang Pocket',
      // darkTheme: darkMode,
      theme: lightMode,
      themeMode: ThemeMode.light,
    );
  }
}
