import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicrophoneController {
  final VoidCallback onRecordStart;
  final VoidCallback onRecordStop;
  final ValueChanged<String> onListening;
  final WidgetRef ref;
  final SpeechToText _speech = SpeechToText();

  MicrophoneController(
      {required this.ref,
      required this.onRecordStart,
      required this.onRecordStop,
      required this.onListening});

  void initializeSpeechToText() async {
    bool available = await _speech.initialize(
      onStatus: statusListener,
      onError: errorListener,
    );

    if (!available) {
      print("The user has denied the use of speech recognition.");
    }
  }

  void startRecording() async {
    if (!ref.watch(recordingProvider)) {
      onRecordStart();
      await _speech.listen(onResult: resultListener);
      ref.read(recordingProvider.notifier).state = true;
    }
  }

  void stopRecording() async {
    if (ref.watch(recordingProvider)) {
      onRecordStop();
      await _speech.stop();
      ref.read(recordingProvider.notifier).state = false;
    }
  }

  void statusListener(String status) {
    onListening(status);
    // You can handle status updates here
  }

  void errorListener(SpeechRecognitionError error) {
    print('Speech recognition error: $error');
    // You can handle error events here
  }

  void resultListener(SpeechRecognitionResult result) {
    String recognizedWords = result.recognizedWords;
    print('Recognized words: $recognizedWords');
    // Compare recognized words with the given ones here
  }
}

final recordingProvider = StateProvider<bool>((ref) {
  return false;
});
