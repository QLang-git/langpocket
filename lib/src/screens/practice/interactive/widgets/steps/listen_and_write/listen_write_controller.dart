import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/practice/interactive/controller/practice_stepper_controller.dart';
import 'package:langpocket/src/screens/practice/spelling/controllers/spelling_word_controller.dart';
import 'package:text_to_speech/text_to_speech.dart';

final listenWriteControllerProvider =
    StateNotifierProvider.autoDispose<ListenWriteController, void>(
  (ref) {
    return ListenWriteController(ref);
  },
);

class ListenWriteController extends StateNotifier<void> {
  final Ref ref;
  ListenWriteController(this.ref) : super(null);
  final tts = TextToSpeech();

  void _initialization(SpellingWordState spellingWordState) {
    tts.setRate(1);
    tts.speak(spellingWordState.wordRecord.foreignWord);
  }

  void stageMapper(SpellingWordState spellingWordState,
      SpellingWordController spellingController) {
    final SpellingWordState(
      :countSpelling,
      :activateExample,
      :wordRecord,
      :examplePinter
    ) = spellingWordState;
    if (countSpelling == 2 && !activateExample) {
      _initialization(spellingWordState);
    } else if (countSpelling == 0 && !activateExample) {
      tts.speak(wordRecord.wordExamples[examplePinter]);
      spellingController.exampleActivation(countExampleSpelling: 1);
    } else if (countSpelling == 0 &&
        activateExample &&
        examplePinter < spellingWordState.wordRecord.wordExamples.length - 1) {
      spellingController.moveToNextExamples(examplePinter,
          countExampleSpelling: 1);
      tts.speak(spellingWordState.wordRecord.wordExamples[examplePinter + 1]);
    }
  }

  void inputCorrectnessStyle(
      bool correctness,
      SpellingWordController spellingWordController,
      TextEditingController inputController) {
    if (correctness) {
      Future.delayed(const Duration(seconds: 2), () {
        inputController.clear();
        spellingWordController.setCorrectness(false);
      });
    }
  }

  void sayText(SpellingWordState spellingWordState,
      SpellingWordController spellingWordController) {
    if (!spellingWordState.activateExample) {
      tts.speak(spellingWordState.wordRecord.foreignWord);
    } else {
      tts.speak(spellingWordState
          .wordRecord.wordExamples[spellingWordState.examplePinter]);
    }
  }

  void repeatProcess(SpellingWordState spellingWordState,
      SpellingWordController spellingWordController) {
    spellingWordController.startOver(countSpelling: 2, countExampleSpelling: 1);
    tts.speak(spellingWordState.wordRecord.foreignWord);
  }

  void startOver() {
    ref.read(practiceStepperControllerProvider.notifier).startOver();
  }

  void goBack() {
    ref.read(practiceStepperControllerProvider.notifier).goToPrevious();
  }
}
