import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/practice_stepper_controller.dart';

class PracticeStepper extends StatefulWidget {
  final List<Widget> steps;

  const PracticeStepper({super.key, required this.steps});

  @override
  State<PracticeStepper> createState() => _PracticeStepperState();
}

class _PracticeStepperState extends State<PracticeStepper> {
  late int activeStep;
  late PracticeStepperController practiceStepperController;
  @override
  void initState() {
    practiceStepperController = PracticeStepperController(
        moveToNext: moveToNext,
        moveToPrevious: moveToPrevious,
        steps: widget.steps);
    final PracticeStepperController(:initialStep) = practiceStepperController;
    activeStep = initialStep();
    super.initState();
  }

  void moveToNext(int step) {
    setState(() {
      activeStep = step;
    });
  }

  void moveToPrevious(int step) {
    setState(() {
      activeStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double lineLength = constraints.maxWidth * 0.3;
      return Column(
        children: [
          IconStepper(
            lineLength: lineLength,
            stepPadding: 0,
            enableNextPreviousButtons: false,
            enableStepTapping: false,
            stepReachedAnimationEffect: Curves.bounceInOut,
            activeStepBorderColor: colorscheme.outline,
            lineColor: colorscheme.outline,
            activeStepColor: colorscheme.primary,
            icons: const [
              Icon(
                Ionicons.ear_outline,
                color: Colors.white,
              ),
              Icon(
                Icons.record_voice_over_outlined,
                color: Colors.white,
              ),
              Icon(
                Ionicons.pencil_outline,
                color: Colors.white,
              )
            ],
            // activeStep property set to activeStep variable defined above.
            activeStep: activeStep,
          ),
          widget.steps[activeStep]
        ],
      ); // Adjust the multiplier as needed
    });
  }
}
