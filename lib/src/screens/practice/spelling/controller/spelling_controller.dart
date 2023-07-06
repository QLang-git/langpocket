import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

const int _countWordSpelling = 5;
const int _countExampleSpelling = 3;
const bool _activateExampleState = false;
const int _pointer = 0;
const int _timeAfterCorrectSpell = 3; // second
const int _stopWordPeaking = 3;
const int _stopExamplesPeaking = 3;

class SpellingController {
  final int countWordSpelling;
  final int countExampleSpelling;
  final String foreignWord;
  final List<String> examplesList;
  final ValueChanged<int> onListeningCount;
  final ValueChanged<bool> onExampleSateListening;
  final ValueChanged<int> onPointerListening;
  final ValueChanged<bool> onCorrectness;
  final ValueChanged<bool>? readOnlyWord;
  final ValueChanged<bool>? readOnlyExample;
  final timeAfterCorrectSpell = _timeAfterCorrectSpell;
  final stopWordPeaking = _stopWordPeaking;
  final stopExamplesPeaking = _stopExamplesPeaking;
  int countSpelling = _countWordSpelling;
  bool activateExample = _activateExampleState;
  int pointer = _pointer;

  SpellingController(
      {this.countWordSpelling = _countWordSpelling,
      this.countExampleSpelling = _countExampleSpelling,
      required this.foreignWord,
      required this.examplesList,
      required this.onListeningCount,
      required this.onExampleSateListening,
      required this.onPointerListening,
      required this.onCorrectness,
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

  void resetting() {
    countSpelling = countWordSpelling;
    activateExample = _activateExampleState;
    pointer = _pointer;
    onListeningCount(countSpelling);
    _readOnly(_ReadOnlyTypes.both, false);

    onExampleSateListening(activateExample);
    onPointerListening(pointer);
  }

  void examplesActivation() {
    print('get activation $countExampleSpelling');
    activateExample = true;
    countSpelling = countExampleSpelling;
    onExampleSateListening(activateExample);
    onListeningCount(countSpelling);
  }

  void reactivateExample() {
    countSpelling = countExampleSpelling;
    pointer = _pointer;
    onPointerListening(pointer);
    onListeningCount(countSpelling);
  }

  void comparingTexts(String text) {
    print(text);
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

  void updateTextFields(
    bool correctness,
  ) {
    if (correctness || activateExample) {
      _readOnly(_ReadOnlyTypes.word, true);
    }
    if (correctness && activateExample) {
      _readOnly(_ReadOnlyTypes.example, true);
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
