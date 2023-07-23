import 'package:flutter/material.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:text_to_speech/text_to_speech.dart';

class AudioController {
  final List<WordRecord> wordRecords;
  final ValueChanged<bool> soundPlaying;
  final tts = TextToSpeech();

  AudioController({required this.wordRecords, required this.soundPlaying});

  void initialization() {}

  void playAudio() async {
    soundPlaying(true);
    for (int i = 0; i < wordRecords.length; i++) {
      await _speakWithDelay(wordRecords[i].foreignWord, i + 1);
      await _speakWithDelay(wordRecords[i].foreignWord, i + 2, rate: 0.4);
      await _speakWithDelay(wordRecords[i].foreignWord, i + 2, rate: 0.7);
      for (var j = 0; j < wordRecords[i].wordExamples.length; j++) {
        await _speakWithDelay(wordRecords[i].wordExamples[j], j + i + 2);
        await _speakWithDelay(wordRecords[i].wordExamples[j], j + i + 3,
            rate: 0.6);
      }
    }
  }

  void audioPause() async {
    soundPlaying(false);
    await tts.pause();
  }

  void audioResume() async {
    soundPlaying(true);
    await tts.resume();
  }

  Future<void> _speakWithDelay(String text, int delay, {double rate = 1}) {
    return Future.delayed(Duration(seconds: delay), () async {
      await tts.setRate(rate);
      await tts.speak(text);
    });
  }
}
