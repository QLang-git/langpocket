import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicrophoneController {
  final String foreignWord;
  final List<String> examplesList;
  final ValueChanged<String> onListeningMessages;
  final ValueChanged<int> onListeningCount;
  bool isRerecording = false;
  int foreignWordCount = 4;
  MicrophoneController({
    required this.onListeningMessages,
    required this.onListeningCount,
    required this.foreignWord,
    required this.examplesList,
  });
  final speechToText = SpeechToText();

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
    }
  }

  void resultListener(SpeechRecognitionResult result) {
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
      message = "listening...";
    } else if (status == RecordingStatus.stop.name) {
      message = "Hold to Restart Recording ...";
    } else if (status == RecordingStatus.correct.name) {
      message = "Great job! You got it right.";
    } else if (status == RecordingStatus.incorrect.name) {
      message = "Oops! The word \"$currentWord\" doesn't match. Try again.";
    } else if (status == RecordingStatus.noVoice.name) {
      message = "No voice detected. Please try again.";
    } else if (status == RecordingStatus.available.name) {
      message = "permission denied. Please enable microphone access.";
    } else {
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

// // in case i found solution for statusListener
//   String _setUserMessage(String status, {String currentWord = ''}) {
//     if (status == "listening") {

//       return "listening...";
//     } else if (status == 'noWordHear') {
//       return "No voice detected. Please try again.";
//     } else if (status == 'correct') {
//       return "Great job! You got it right.";
//     } else if (status == 'incorrect') {
//       return "Oops! The word \"$currentWord\" doesn't match. Try again.";
//     } else if (status == 'notListening') {
//       return "Analyzing your pronunciation...";
//     } else {
//       return "Hold to Restart Recording ...";
//     }
//   }
