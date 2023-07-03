import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ListenRepeatController {
  final String foreignWord;
  final ValueChanged<bool> setMicActivation;

  ListenRepeatController({
    required this.foreignWord,
    required this.setMicActivation,
  });
  final tts = TextToSpeech();
  void listen() async {
    await _speakWithDelay(foreignWord, const Duration(seconds: 0), rate: 1);
    await _speakWithDelay(foreignWord, const Duration(seconds: 2), rate: 0.1);
    await _speakWithDelay(foreignWord, const Duration(seconds: 2), rate: 0.3);
    await _speakWithDelay(foreignWord, const Duration(seconds: 3), rate: 1)
        .then((_) => Future.delayed(
              const Duration(seconds: 1),
              () => setMicActivation(true),
            ));
  }

  Future<void> _speakWithDelay(String text, Duration delay,
      {double rate = 1}) async {
    await Future.delayed(delay);
    await tts.setRate(rate);
    await tts.speak(text);
  }
}
