import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/practice/interactive/controller/practice_stepper_controller.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_single_controller.dart';

final readSpeakControllerProvider =
    StateNotifierProvider.autoDispose<ReadSpeakController, bool>(
  (ref) {
    return ReadSpeakController();
  },
);

class ReadSpeakController extends StateNotifier<bool> {
  ReadSpeakController() : super(true);

  void stepsMapper(
      MicWordState micWordState,
      MicSingleController micSingleController,
      PracticeStepperController practiceStepperController) async {
    final MicWordState(
      :countPron,
      :wordRecord,
      :examplePinter,
      :activateExample
    ) = micWordState;
    if (countPron == 0 && !activateExample) {
      micSingleController.exampleActivation();
    } else if (activateExample &&
        countPron == 0 &&
        examplePinter < wordRecord.wordExamples.length - 1) {
      micSingleController.moveToNextExamples(examplePinter);
    } else if (activateExample &&
        countPron == 0 &&
        examplePinter == wordRecord.wordExamples.length - 1) {
      practiceStepperController.updateNextStepAvailability(true);
      if (mounted) {
        state = false;
      }
    }
  }

  void reset(MicSingleController micSingleController,
      PracticeStepperController practiceStepperController) async {
    micSingleController.startOver();

    practiceStepperController.updateNextStepAvailability(false);
    state = true;
  }
}
