import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicrophoneController {
  final String foreignWord;
  final List<String> examplesList;
  final ValueChanged<String> onListeningMessages;
  final ValueChanged<int> onListeningCount;
  int foreignWordCount = 4;
  MicrophoneController({
    required this.onListeningMessages,
    required this.onListeningCount,
    required this.foreignWord,
    required this.examplesList,
  });
  final speechToText = SpeechToText();
  RecordingStatus currentStatus = RecordingStatus.noVoice;

  void initializeSpeechToText() async {
    bool available = await speechToText.initialize();
    if (!available) {
      _setAlterUserMessage(RecordingStatus.available.name);
    }
  }

  void startRecording() async {
    if (speechToText.isNotListening) {
      _setAlterUserMessage(RecordingStatus.start.name);
      await speechToText.listen(onResult: resultListener);
    }
  }

  void stopRecording() async {
    if (speechToText.isListening) {
      await speechToText.stop();
      _setAlterUserMessage(RecordingStatus.stop.name);
    }
  }

  void resultListener(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    if (result.finalResult) {
      _comparingWords(RecordingStatus.analyze.name, result.recognizedWords);
    } else {
      _setAlterUserMessage(RecordingStatus.analyze.name);
    }
  }

  void _comparingWords(String status, String recognizedWords) {
    if (status == RecordingStatus.analyze.name && foreignWordCount > 0) {
      if (recognizedWords.toLowerCase() == foreignWord.toLowerCase()) {
        foreignWordCount--;
        onListeningCount(foreignWordCount);
        _setAlterUserMessage(RecordingStatus.correct.name);
      } else {
        recognizedWords.isNotEmpty
            ? _setAlterUserMessage(RecordingStatus.incorrect.name,
                currentWord: recognizedWords)
            : _setAlterUserMessage(RecordingStatus.noVoice.name);
      }
    } else {
      _setAlterUserMessage(RecordingStatus.stop.name);
    }
  }

  void _setAlterUserMessage(String status, {String currentWord = ''}) {
    String message = '';
    if (RecordingStatus.start.name == status) {
      currentStatus = RecordingStatus.start;
      message = "listening...";
    } else if (status == RecordingStatus.stop.name) {
      currentStatus = RecordingStatus.stop;
      message = "Hold to Restart Recording ...";
    } else if (status == RecordingStatus.correct.name) {
      currentStatus = RecordingStatus.correct;
      message = "Great job! You got it right.";
    } else if (status == RecordingStatus.incorrect.name) {
      currentStatus = RecordingStatus.incorrect;
      message = "Oops! \"$currentWord\" doesn't match. Try again.";
    } else if (status == RecordingStatus.noVoice.name) {
      currentStatus = RecordingStatus.noVoice;
      message = "No voice detected. Please try again.";
    } else if (status == RecordingStatus.available.name) {
      currentStatus = RecordingStatus.available;
      message = "permission denied. Please enable microphone access.";
    } else {
      currentStatus = RecordingStatus.analyze;
      message = "Analyzing your pronunciation...";
    }
    onListeningMessages(message);
  }
}

enum RecordingStatus {
  start,
  correct,
  incorrect,
  stop,
  analyze,
  noVoice,
  available
}
