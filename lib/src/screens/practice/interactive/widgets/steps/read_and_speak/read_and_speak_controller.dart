// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:langpocket/src/screens/practice/interactive/screen/practice_interactive_screen.dart';

class ReadSpeakController {
  final MicrophoneController microphoneController;
  final PracticePronScreenState globuleStates;
  final ValueChanged<bool> micActivation;

  ReadSpeakController({
    required this.globuleStates,
    required this.microphoneController,
    required this.micActivation,
  });

  void goBack() {
    globuleStates.moveToNext(0);
  }

  void reset() {
    microphoneController.resetting();
    globuleStates.updateNextStepAvailability(false);
  }

  void activateExample(int currentCount, bool example) {
    if (currentCount == 0 && !example) {
      microphoneController.examplesActivation();
    } else if (example && currentCount == 0 && _checkExamplesListOutOfBounds) {
      microphoneController.moveToNextExamples();
    } else if (example && currentCount == 0 && !_checkExamplesListOutOfBounds) {
      globuleStates.updateNextStepAvailability(true);
      micActivation(false);
    }
  }

  bool get _checkExamplesListOutOfBounds {
    return microphoneController.pointer <
        microphoneController.examplesList.length - 1;
  }
}
