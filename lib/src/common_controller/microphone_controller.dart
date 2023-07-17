import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/data_flow/data_flow.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'microphone_usage.dart';

const bool _activateExampleState = false;
const int _pointer = 0;
const int _stopPeaking = 0;

class MicrophoneController {
  final WidgetRef ref;
  final MicrophoneConst microphoneConst;
  final ValueChanged<String> onListeningMessages;
  final ValueChanged<int> onListeningCount;
  final ValueChanged<bool> onExampleSateListening;
  final ValueChanged<WordRecord> onNewWordRecord;
  final ValueChanged<int> onPointerListening;
  final int stopPeaking = _stopPeaking;
  int countPron = 0;
  bool activateExample = _activateExampleState;
  int pointer = _pointer;
  int wordPinter = 1;
  List<WordRecord> wordList = [];
  String foreignWord = '';
  List<String> examplesList = [];
  MicrophoneController(this.microphoneConst,
      {required this.onListeningMessages,
      required this.ref,
      required this.onNewWordRecord,
      required this.onListeningCount,
      required this.onExampleSateListening,
      required this.onPointerListening});
  final speechToText = SpeechToText();
  RecordingStatus currentStatus = RecordingStatus.noVoice;
  late DataFlow dataFlow;
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
    //dataFlow = DataFlow(ref: ref);
    return (
      countPron: microphoneConst.countWordPron,
      countExamplePron: microphoneConst.countExamplePron,
      activateExample: _activateExampleState,
      pointer: _pointer,
      initialMessage: microphoneConst.initialMessage
    );
  }

  WordRecord? getSingleWord(int wordId) {
    try {
      return wordList.firstWhere((word) => word.id == wordId);
    } catch (e) {
      return null;
    }
  }

  AsyncValue<T> getSingleWordOrAll<T>(int? groupId, int wordId) {
    if (groupId != null) {
      return _getWordsInGroupById(groupId) as AsyncValue<T>;
    } else {
      return _fetchWord(wordId) as AsyncValue<T>;
    }
  }

  set setWordList(List<WordData> words) =>
      wordList = words.map((e) => e.decoding()).toList();

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

  void resetting({WordRecord? wordRecord}) {
    countPron = microphoneConst.countWordPron;
    activateExample = _activateExampleState;
    pointer = _pointer;
    if (wordRecord != null) {
      onNewWordRecord(wordRecord);
    } else {
      _startWordsOver();
    }
    onListeningCount(countPron);
    onExampleSateListening(activateExample);
    onPointerListening(pointer);
    _setAlterUserMessage(RecordingStatus.initial.name);
  }

  void examplesActivation() {
    activateExample = true;
    countPron = microphoneConst.countExamplePron;
    pointer = _pointer;
    onExampleSateListening(activateExample);
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

  get isThereNextWord => foreignWord != wordList.last.foreignWord;

  void moveToNextWord() {
    if (wordList.length > wordPinter) {
      foreignWord = wordList[wordPinter].foreignWord;
      examplesList = wordList[wordPinter].wordExamples;
      resetting(wordRecord: wordList[wordPinter]);
      wordPinter += 1;
    }
  }

  void _comparingWords(
      String status, String recognizedText, String originText) {
    if (status == RecordingStatus.analyze.name && countPron > 0) {
      if (recognizedText.toLowerCase().trim() ==
          originText.toLowerCase().trim()) {
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

  void _startWordsOver() {
    if (wordPinter != 1) {
      wordPinter = 1;
      foreignWord = wordList.first.foreignWord;
      examplesList = wordList.first.wordExamples;

      onNewWordRecord(wordList.first);
    }
  }

  AsyncValue<List<WordData>> _getWordsInGroupById(int currentGroupId) {
    return dataFlow.watchWordsListbyId(currentGroupId);
  }

  AsyncValue<WordData> _fetchWord(int currentWordId) {
    return dataFlow.fetchWordById(currentWordId);
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
      message = microphoneConst.exampleActivationMessage;
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
