import 'package:flutter/material.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:text_to_speech/text_to_speech.dart';

const int _countWordSpelling = 1;
const int _countExampleSpelling = 1;
const bool _activateExampleState = false;
const int _pointer = 0;
const int _timeAfterCorrectSpell = 3; // second
const int _stopWordPeaking = 0;
const int _stopExamplesPeaking = 0;

class SpellingController {
  final int countWordSpelling;
  final int countExampleSpelling;
  String foreignWord;
  List<String> examplesList;
  final ValueChanged<int> onListeningCount;
  final ValueChanged<bool> onExampleSateListening;
  final ValueChanged<int> onPointerListening;
  final ValueChanged<WordRecord> onNewWordRecord;
  final ValueChanged<bool> onCorrectness;
  final ValueChanged<bool>? readOnlyWord;
  final ValueChanged<bool>? readOnlyExample;
  final timeAfterCorrectSpell = _timeAfterCorrectSpell;
  final stopWordPeaking = _stopWordPeaking;
  final stopExamplesPeaking = _stopExamplesPeaking;
  int countSpelling = _countWordSpelling;
  bool activateExample = _activateExampleState;
  int pointer = _pointer;
  int wordPinter = 1;

  SpellingController(
      {this.countWordSpelling = _countWordSpelling,
      this.countExampleSpelling = _countExampleSpelling,
      required this.foreignWord,
      required this.examplesList,
      required this.onListeningCount,
      required this.onExampleSateListening,
      required this.onPointerListening,
      required this.onCorrectness,
      required this.onNewWordRecord,
      this.readOnlyWord,
      this.readOnlyExample});

  ({
    int countSpelling,
    bool activateExample,
    int pointer,
    int countExampleSpelling
  }) initializeControllerValues() {
    countSpelling = countWordSpelling;
    return (
      countSpelling: countWordSpelling,
      activateExample: _activateExampleState,
      pointer: _pointer,
      countExampleSpelling: countExampleSpelling
    );
  }

  void resetting({WordRecord? wordRecord}) {
    countSpelling = countWordSpelling;
    activateExample = _activateExampleState;
    pointer = _pointer;
    if (wordRecord != null) {
      onNewWordRecord(wordRecord);
    } else {
      _startWordsOver();
    }

    onListeningCount(countSpelling);
    _readOnly(_ReadOnlyTypes.both, false);

    onExampleSateListening(activateExample);
    onPointerListening(pointer);
  }

  void examplesActivation() {
    activateExample = true;
    countSpelling = countExampleSpelling;
    onExampleSateListening(activateExample);
    onListeningCount(countSpelling);
  }

  void reactivateExample() {
    activateExample = true;
    countSpelling = countExampleSpelling;
    pointer = _pointer;
    onPointerListening(pointer);
    onExampleSateListening(activateExample);
    onListeningCount(countSpelling);
  }

  void comparingTexts(String text) {
    if (activateExample && countSpelling > 0) {
      final res = _exampleSpellingChecker(text);
      if (res) {
        onCorrectness(res);
      }
    } else if (!activateExample && countSpelling > 0) {
      final res = _wordSpellingChecker(text);
      if (res) {
        onCorrectness(res);
      }
    }
  }

  void moveToNextExamples() {
    pointer += 1;
    countSpelling = countExampleSpelling;
    onListeningCount(countSpelling);
    onPointerListening(pointer);
  }

  void resetTextFieldsAfterDelay() {
    if (activateExample) {
      _readOnly(_ReadOnlyTypes.example, false);
      onCorrectness(false);
    } else {
      _readOnly(_ReadOnlyTypes.word, false);
      onCorrectness(false);
    }
  }

  void updateTextFields(bool correctness) {
    if (correctness || activateExample) {
      _readOnly(_ReadOnlyTypes.word, true);
    }
    if (correctness && activateExample) {
      _readOnly(_ReadOnlyTypes.example, true);
    }
  }

  bool moveToNextWord() {
    final wordList = GroupController.currentWordList;

    if (wordList != null && wordList.length > wordPinter) {
      foreignWord = wordList[wordPinter].foreignWord;
      examplesList = wordList[wordPinter].wordExamples;
      resetting(wordRecord: wordList[wordPinter]);
      wordPinter += 1;
      return true;
    } else {
      return false;
    }
  }

  get isThereNextWord =>
      foreignWord != GroupController.currentWordList!.last.foreignWord;

  void _startWordsOver() {
    final wordList = GroupController.currentWordList!;
    if (wordPinter != 1) {
      wordPinter = 1;
      foreignWord = wordList.first.foreignWord;
      examplesList = wordList.first.wordExamples;

      onNewWordRecord(wordList.first);
    }
  }

  bool _exampleSpellingChecker(String text) {
    if (examplesList[pointer].toLowerCase().trim() ==
        text.toLowerCase().trim()) {
      TextToSpeech().speak(text);
      countSpelling -= 1;
      onListeningCount(countSpelling);
      return true;
    } else {
      return false;
    }
  }

  bool _wordSpellingChecker(String text) {
    if (foreignWord.toLowerCase().trim() == text.toLowerCase().trim()) {
      TextToSpeech().speak(text);
      countSpelling -= 1;
      onListeningCount(countSpelling);
      return true;
    } else {
      return false;
    }
  }

  void _readOnly(_ReadOnlyTypes type, bool state) {
    if (readOnlyExample != null && readOnlyWord != null) {
      if (type == _ReadOnlyTypes.example) {
        readOnlyExample!(state);
      } else if (type == _ReadOnlyTypes.word) {
        readOnlyWord!(state);
      } else if (type == _ReadOnlyTypes.both) {
        readOnlyWord!(state);
        readOnlyExample!(state);
      }
    }
  }
}

enum _ReadOnlyTypes { example, word, both }
