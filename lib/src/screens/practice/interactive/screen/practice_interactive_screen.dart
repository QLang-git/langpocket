import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/practice/interactive/app_bar/practice_interactive_appbar.dart';
import 'package:langpocket/src/screens/practice/interactive/controller/practice_stepper_controller.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/practice_stepper.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/steps/listen_and_repeat/listen_repeat.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/steps/read_and_speak/read_and_speak.dart';

class PracticeInteractiveScreen extends StatefulWidget {
  final int wordId;
  const PracticeInteractiveScreen({
    super.key,
    required this.wordId,
  });

  @override
  State<PracticeInteractiveScreen> createState() => PracticePronScreenState();
}

class PracticePronScreenState extends State<PracticeInteractiveScreen> {
  late List<Widget> _steps;
  late int activeStep;
  late PracticeStepperController practiceStepperController;
  bool isNextStepAvailable = false;

  @override
  void initState() {
    _steps = [
      ListenRepeat(
        wordId: widget.wordId,
      ),
      ReadSpeak(wordId: widget.wordId),
      // ListenWrite(wordId: widget.wordId)
    ];

    practiceStepperController =
        PracticeStepperController(moveToNext: moveToNext, steps: _steps);
    final PracticeStepperController(:initialStep) = practiceStepperController;
    activeStep = initialStep();
    super.initState();
  }

  void moveToNext(int step) {
    setState(() {
      activeStep = step;
    });
  }

  void updateNextStepAvailability(bool state) => setState(() {
        isNextStepAvailable = state;
      });

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    return ResponsiveCenter(
      child: Scaffold(
        appBar: const PracticeInteractiveAppBar(),
        backgroundColor: colorScheme.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            child: PracticeStepper(steps: _steps, currentStep: activeStep),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: activeStep == _steps.length - 1
            ? null
            : SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedOpacity(
                      opacity: isNextStepAvailable ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 33),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: colorScheme.onSurface,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'Awesome! Level up and move to the next step!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: textTheme.labelLarge?.fontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: FloatingActionButton(
                        backgroundColor: isNextStepAvailable
                            ? colorScheme.primary
                            : Colors.grey,
                        onPressed: isNextStepAvailable
                            ? () {
                                practiceStepperController.goToNext();
                                updateNextStepAvailability(false);
                              }
                            : null,
                        child: const Icon(
                          Icons.skip_next_outlined,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
