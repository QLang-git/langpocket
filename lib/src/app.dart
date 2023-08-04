import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_single_controller.dart';
import 'package:langpocket/src/styles/light_mode.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:speech_to_text/speech_to_text.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _initializeSpeechToText(ref);

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

void _initializeSpeechToText(WidgetRef ref) async {
  final speechToText = SpeechToText();
  final permission = await speechToText.initialize(
    onError: (errorNotification) {
      ref
          .read(micSingleControllerProvider.notifier)
          .errorListener(errorNotification.errorMsg);
    },
    onStatus: (status) {
      ref.read(micSingleControllerProvider.notifier).statusListener(status);
    },
  );

  if (!permission) {
    ref
        .read(micSingleControllerProvider.notifier)
        .errorListener('Permission denied. Please enable microphone access.');
  }
  if (!speechToText.isAvailable) {
    ref.read(micSingleControllerProvider.notifier).errorListener(
        'Microphone is unavailable. Check permissions and try again later.');
  }
}
