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
  final String foreignWord;
  final List<String> examplesList;
  final ValueChanged<int> onListeningCount;
  final ValueChanged<bool> onExampleSateListening;
  final ValueChanged<int> onPointerListening;
  final ValueChanged<bool> onCorrectness;
  final ValueChanged<bool> readOnlyWord;
  final ValueChanged<bool> readOnlyExample;
  final timeAfterCorrectSpell = _timeAfterCorrectSpell;
  final stopWordPeaking = _stopWordPeaking;
  final stopExamplesPeaking = _stopExamplesPeaking;
  int countSpelling = _countWordSpelling;
  bool activateExample = _activateExampleState;
  int pointer = _pointer;

  SpellingController(
      {required this.foreignWord,
      required this.examplesList,
      required this.onListeningCount,
      required this.onExampleSateListening,
      required this.onPointerListening,
      required this.onCorrectness,
      required this.readOnlyWord,
      required this.readOnlyExample});

  ({
    int countSpelling,
    bool activateExample,
    int pointer,
    int countExampleSpelling
  }) initializeControllerValues() {
    return (
      countSpelling: _countWordSpelling,
      activateExample: _activateExampleState,
      pointer: _pointer,
      countExampleSpelling: _countExampleSpelling
    );
  }

  void resetting() {
    countSpelling = _countWordSpelling;
    activateExample = _activateExampleState;
    pointer = _pointer;
    onListeningCount(countSpelling);
    readOnlyWord(false);
    readOnlyExample(false);
    onExampleSateListening(activateExample);
    onPointerListening(pointer);
  }

  void examplesActivation() {
    activateExample = true;
    countSpelling = _countExampleSpelling;
    onExampleSateListening(activateExample);
    onListeningCount(countSpelling);
  }

  void reactivateExample() {
    countSpelling = _countExampleSpelling;
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
    countSpelling = _countExampleSpelling;
    onListeningCount(countSpelling);
    onPointerListening(pointer);
  }

  void resetTextFieldsAfterDelay() {
    if (activateExample) {
      readOnlyExample(false);
      onCorrectness(false);
    } else {
      readOnlyWord(false);
      onCorrectness(false);
    }
  }

  void updateTextFields(
    bool correctness,
  ) {
    if (correctness || activateExample) {
      readOnlyWord(true);
    }
    if (correctness && activateExample) {
      readOnlyExample(true);
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
}
