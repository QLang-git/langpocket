import 'package:flutter/material.dart';
import 'package:langpocket/src/screens/practice/interactive/screen/practice_interactive_screen.dart';
import 'package:langpocket/src/screens/practice/spelling/controller/spelling_controller.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ListenWriteController {
  final PracticePronScreenState globuleStates;
  final SpellingController spellingController;
  final ValueChanged<bool> setTextCorrectness;
  final TextEditingController inputController;

  ListenWriteController({
    required this.setTextCorrectness,
    required this.inputController,
    required this.globuleStates,
    required this.spellingController,
  });
  final tts = TextToSpeech();

  void initialization() {
    tts.setRate(1);
    tts.speak(spellingController.foreignWord);
  }

  void goBack() {
    globuleStates.moveToNext(1);
  }

  void resting() {
    spellingController.resetting();
  }

  void checker(String text) {
    spellingController.comparingTexts(text);
  }

  void exampleMapper(int countSpelling, bool activateExample, int pointer) {
    if (countSpelling == 0 && !activateExample) {
      tts.speak(spellingController.examplesList[pointer]);
      spellingController.examplesActivation();
    } else if (countSpelling == 0 &&
        activateExample &&
        pointer < spellingController.examplesList.length - 1) {
      spellingController.moveToNextExamples();
      tts.speak(spellingController.examplesList[spellingController.pointer]);
    }
  }

  void inputCorrectnessStyle(bool correctness) {
    if (correctness) {
      Future.delayed(const Duration(seconds: 2), () {
        inputController.clear();
        setTextCorrectness(false);
      });
    }
  }

  void sayText() {
    if (!spellingController.activateExample) {
      tts.speak(spellingController.foreignWord);
    } else {
      tts.speak(spellingController.examplesList[spellingController.pointer]);
    }
  }

  void repeatProcess() {
    spellingController.resetting();
    tts.speak(spellingController.foreignWord);
  }

  void startOver() {
    globuleStates.moveToNext(0);
  }
}
