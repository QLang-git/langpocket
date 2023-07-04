import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ListenRepeatController {
  final MicrophoneController microphoneController;
  final ValueChanged<int> moveToNextStep;
  final ValueChanged<bool> setMicActivation;

  bool mic = false;

  ListenRepeatController({
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
    final perfectDelay = (examplesList[pointer].split(' ').length * 0.4).ceil();
    if (countPron == 0 && step == 1) {
      moveToNextStep(2);
    }
    if (step == 2 && !mic) {
      print('welcome to step 2');

      await _speakWithDelay(examplesList[pointer], 1, rate: 1);
      await _speakWithDelay(examplesList[pointer], perfectDelay, rate: 0.2);
      microphoneController.examplesActivation();

      moveToNextStep(3);
    }
    if (countPron > 0 && step == 3 && !mic) {
      await Future.delayed(Duration(seconds: perfectDelay));
      setMicState(true);
    }
    if (countPron == 0 && step == 3) {
      if (pointer < examplesList.length - 1) {
        microphoneController.moveToNextExamples();
        moveToNextStep(2);
        setMicState(false);
      }
      print('thank you you finished this stage ');
    }
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
}