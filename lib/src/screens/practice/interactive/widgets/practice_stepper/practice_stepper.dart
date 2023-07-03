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
    final ThemeData(:colorScheme) = Theme.of(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double lineLength = constraints.maxWidth * 0.3;
      return Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: Column(
          children: [
            IconStepper(
              lineLength: lineLength,
              stepPadding: 0,
              enableNextPreviousButtons: false,
              enableStepTapping: false,
              stepReachedAnimationEffect: Curves.bounceInOut,
              activeStepBorderColor: colorScheme.outline,
              lineColor: colorScheme.outline,
              activeStepColor: colorScheme.primary,
              icons: const [
                Icon(Ionicons.ear_outline),
                Icon(Icons.record_voice_over_outlined),
                Icon(Ionicons.pencil_outline)
              ],
              // activeStep property set to activeStep variable defined above.
              activeStep: activeStep,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: widget.steps[activeStep],
            )
          ],
        ),
      ); // Adjust the multiplier as needed
    });
  }
}
