import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:langpocket/src/screens/practice/interactive/screen/practice_interactive_screen.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ListenRepeatController {
  final PracticePronScreenState globuleSates;
  final MicrophoneController microphoneController;
  final ValueChanged<int> moveToNextStep;
  final ValueChanged<bool> setMicActivation;

  bool mic = false;

  ListenRepeatController({
    required this.globuleSates,
    required this.moveToNextStep,
    required this.microphoneController,
    required this.setMicActivation,
  });
  final tts = TextToSpeech();

  // step 1
  void listen() async {
    final MicrophoneController(:foreignWord) = microphoneController;
    await _speakWithDelay(foreignWord, 0, rate: 1);
    await _speakWithDelay(foreignWord, 2, rate: 0.1);
    await _speakWithDelay(foreignWord, 2, rate: 0.3);
    await _speakWithDelay(foreignWord, 3, rate: 1).then((_) =>
        Future.delayed(const Duration(seconds: 1), () => setMicState(true)));
  }

  void stepsMapper(int step) async {
    final MicrophoneController(:countPron, :examplesList, :pointer) =
        microphoneController;
    final perfectDelay = (examplesList[pointer].split(' ').length * 0.5).ceil();

    //* step 1
    if (countPron == 0 && step == 1) {
      moveToNextStep(2);
    }

    //* step 2
    if (step == 2 && !mic) {
      print('welcome to step 2');

      await _speakWithDelay(examplesList[pointer], 1, rate: 1);
      await _speakWithDelay(examplesList[pointer], perfectDelay, rate: 0.2);
      microphoneController.examplesActivation();

      moveToNextStep(3);
    }
    //* step 3
    if (countPron > 0 && step == 3 && !mic) {
      await Future.delayed(Duration(seconds: perfectDelay));
      setMicState(true);
    }

    if (countPron == 0 && step == 3) {
      await Future.delayed(Duration(seconds: perfectDelay));
      if (pointer < examplesList.length - 1) {
        microphoneController.moveToNextExamples();
        moveToNextStep(2);
        setMicState(false);
      } else {
        // finished
        globuleSates.updateNextStepAvailability(false);
        moveToNextStep(4);
      }
    }
  }

  void reset() {
    moveToNextStep(1);
    microphoneController.resetting();

    globuleSates.updateNextStepAvailability(false);
    listen();
  }

  void activateExamples() {
    final MicrophoneController(:pointer, :examplesList) = microphoneController;
    if (pointer < examplesList.length) {
      microphoneController.examplesActivation();
      _speakExamples(examplesList[microphoneController.pointer]);
    }
  }

  void setMicState(bool status) {
    mic = status;
    setMicActivation(status);
  }

  void _speakExamples(String example) async {
    await _speakWithDelay(example, 1, rate: 1);
    await _speakWithDelay(example, 2, rate: 0.2);
  }

  Future<void> _speakWithDelay(String text, int delay, {double rate = 1}) {
    return Future.delayed(Duration(seconds: delay), () async {
      await tts.setRate(rate);
      await tts.speak(text);
    });
  }

  void playNormal() async {
    final MicrophoneController(:foreignWord, :examplesList) =
        microphoneController;
    await _speakWithDelay(foreignWord, 0, rate: 1);
    for (var example in examplesList) {
      await _speakWithDelay(example, 2, rate: 1);
    }
  }
}
