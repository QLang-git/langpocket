import 'package:flutter_riverpod/flutter_riverpod.dart';

// const int _currentStep = 0;
// const bool _isNextStepAvailable = false;
const int _stepsLength = 3;

final practiceStepperControllerProvider = StateNotifierProvider.autoDispose<
    PracticeStepperController, ({int step, bool isNextStepAvailable})>((ref) {
  return PracticeStepperController();
});

class PracticeStepperController
    extends StateNotifier<({int step, bool isNextStepAvailable})> {
  PracticeStepperController() : super((step: 0, isNextStepAvailable: false));

  void goToNext() {
    if (state.step < _stepsLength) {
      state = (
        step: state.step + 1,
        isNextStepAvailable: state.isNextStepAvailable
      );
    }
  }

  void goToPrevious() {
    if (state.step > 0) {
      state = (
        step: state.step - 1,
        isNextStepAvailable: state.isNextStepAvailable
      );
    }
  }

  void updateNextStepAvailability(bool isAvailability) {
    state = (step: state.step, isNextStepAvailable: isAvailability);
  }

  @override
  void dispose() {
    startOver();
    super.dispose();
  }

  void startOver() => state = (
        step: 0,
        isNextStepAvailable: false,
      );
}
