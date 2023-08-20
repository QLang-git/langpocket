import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_controller.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_group_controller.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_single_controller.dart';
import 'package:langpocket/src/styles/light_mode.dart';
import 'package:langpocket/src/utils/notifications.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _initializeSpeechToText(ref);
    _initializeAppNotifications();
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'Lang Pocket',
      //builder: Authenticator.builder(),
      routerConfig: goRouter,
      onGenerateTitle: (BuildContext context) => 'Lang Pocket',
      // darkTheme: darkMode,
      theme: lightMode,
      themeMode: ThemeMode.light,
    );
  }

  void _initializeAppNotifications() {
    final notification = AppNotification();
    notification.initializations();
    notification.newGroupNotification();
  }
}

void _initializeSpeechToText(WidgetRef ref) async {
  final speechToText = SpeechToText();
  MicController activeProvider;

  await speechToText.initialize(
    onError: (errorNotification) {
      final isGroupActive = ref.read(micGroupControllerProvider).value;
      if (isGroupActive != null) {
        activeProvider = ref.read(micGroupControllerProvider.notifier);
      } else {
        activeProvider = ref.read(micSingleControllerProvider.notifier);
      }
      activeProvider.errorListener(errorNotification.errorMsg);
    },
    onStatus: (status) {
      final isGroupActive = ref.read(micGroupControllerProvider).value;
      if (isGroupActive != null) {
        activeProvider = ref.read(micGroupControllerProvider.notifier);
      } else {
        activeProvider = ref.read(micSingleControllerProvider.notifier);
      }

      activeProvider.statusListener(status);
    },
  );
}
