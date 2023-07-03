import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'microphone_usage.dart';

const bool _activateExampleState = false;
const int _pointer = 0;
const int _stopPeaking = 2;

class MicrophoneController {
  final MicrophoneConst microphoneConst;
  final String foreignWord;
  final List<String> examplesList;
  final ValueChanged<String> onListeningMessages;
  final ValueChanged<int> onListeningCount;
  final ValueChanged<bool> onExampleSateListening;
  final ValueChanged<int> onPointerListening;
  final int stopPeaking = _stopPeaking;
  int countPron = 0;
  bool activateExample = _activateExampleState;
  int pointer = _pointer;
  MicrophoneController(this.microphoneConst,
      {required this.onListeningMessages,
      required this.onListeningCount,
      required this.foreignWord,
      required this.examplesList,
      required this.onExampleSateListening,
      required this.onPointerListening});
  final speechToText = SpeechToText();
  RecordingStatus currentStatus = RecordingStatus.noVoice;

  void initializeSpeechToText() async {
    countPron = microphoneConst.countWordPron;
    bool available = await speechToText.initialize();
    if (!available) {
      _setAlterUserMessage(RecordingStatus.available.name);
    }
  }

  ({
    int countPron,
    int countExamplePron,
    bool activateExample,
    int pointer,
    String initialMessage
  }) initializeControllerValues() {
    return (
      countPron: microphoneConst.countWordPron,
      countExamplePron: microphoneConst.countExamplePron,
      activateExample: _activateExampleState,
      pointer: _pointer,
      initialMessage: microphoneConst.initialMessage
    );
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
      if (activateExample) {
        _comparingWords(RecordingStatus.analyze.name, result.recognizedWords,
            examplesList[pointer]);
      } else {
        _comparingWords(
            RecordingStatus.analyze.name, result.recognizedWords, foreignWord);
      }
    } else {
      _setAlterUserMessage(RecordingStatus.analyze.name);
    }
  }

  void resetting() {
    countPron = microphoneConst.countWordPron;
    activateExample = _activateExampleState;
    pointer = _pointer;
    onListeningCount(countPron);
    onExampleSateListening(activateExample);
    onPointerListening(pointer);
    _setAlterUserMessage(RecordingStatus.initial.name);
  }

  void examplesActivation() {
    activateExample = true;
    countPron = microphoneConst.countExamplePron;
    onExampleSateListening(activateExample);
    onListeningCount(countPron);
    _setAlterUserMessage(RecordingStatus.exampleActivation.name);
  }

  void reactivateExample() {
    countPron = microphoneConst.countExamplePron;
    pointer = _pointer;
    onPointerListening(pointer);
    onListeningCount(countPron);
    _setAlterUserMessage(RecordingStatus.exampleActivation.name);
  }

  void moveToNextExamples() {
    pointer += 1;
    countPron = microphoneConst.countExamplePron;
    onListeningCount(countPron);
    onPointerListening(pointer);
  }

  void _comparingWords(
      String status, String recognizedText, String originText) {
    if (status == RecordingStatus.analyze.name && countPron > 0) {
      if (recognizedText.toLowerCase() == originText.toLowerCase()) {
        countPron--;
        onListeningCount(countPron);
        _setAlterUserMessage(RecordingStatus.correct.name);
      } else {
        recognizedText.isNotEmpty
            ? _setAlterUserMessage(RecordingStatus.incorrect.name,
                currentWord: recognizedText)
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
      message = " Permission denied. Please enable microphone access.";
    } else if (status == RecordingStatus.exampleActivation.name) {
      message = "Try to Pronounce the following sentence ";
    } else if (status == RecordingStatus.initial.name) {
      message = "Hold to Start Recording ...";
    } else {
      currentStatus = RecordingStatus.analyze;
      message = "Analyzing your pronunciation...";
    }
    onListeningMessages(message);
  }
}

enum RecordingStatus {
  initial,
  start,
  correct,
  incorrect,
  stop,
  analyze,
  noVoice,
  available,
  exampleActivation
}
