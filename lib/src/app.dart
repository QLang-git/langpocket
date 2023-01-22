import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'Lang Pocket',
      home: const Text('home'),
      onGenerateTitle: (BuildContext context) => 'Lang Pocket',
      // darkTheme: darkMode,
      // theme: lightMode,
      // themeMode: ref.watch(themeApp),
    );
  }
}
