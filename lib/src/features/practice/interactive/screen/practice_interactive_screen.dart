import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/practice/interactive/app_bar/practice_interactive_appbar.dart';
import 'package:langpocket/src/features/practice/interactive/controller/practice_stepper_controller.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/practice_stepper/practice_stepper.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/steps/listen_and_repeat/listen_repeat.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/steps/listen_and_write/listen_and_write.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/steps/read_and_speak/read_and_speak.dart';

class PracticeInteractiveScreen extends ConsumerStatefulWidget {
  final int wordId;
  const PracticeInteractiveScreen({
    super.key,
    required this.wordId,
  });

  @override
  ConsumerState<PracticeInteractiveScreen> createState() =>
      PracticePronScreenState();
}

class PracticePronScreenState extends ConsumerState<PracticeInteractiveScreen> {
  late List<Widget> _steps;
  late PracticeStepperController practiceStepperController;

  @override
  void initState() {
    _steps = [
      ListenRepeat(wordId: widget.wordId),
      ReadSpeak(wordId: widget.wordId),
      ListenWrite(wordId: widget.wordId)
    ];
    practiceStepperController =
        ref.refresh(practiceStepperControllerProvider.notifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentState = ref.watch(practiceStepperControllerProvider);
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    return ResponsiveCenter(
      child: Scaffold(
        appBar: const PracticeInteractiveAppBar(),
        backgroundColor: colorScheme.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            child:
                PracticeStepper(steps: _steps, currentStep: currentState.step),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: currentState.step == _steps.length - 1
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedOpacity(
                    opacity: currentState.isNextStepAvailable ? 1.0 : 0.0,
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
                            'Awesome! Level up and Go Next !',
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
                      backgroundColor: currentState.isNextStepAvailable
                          ? colorScheme.primary
                          : Colors.grey,
                      onPressed: currentState.isNextStepAvailable
                          ? () {
                              practiceStepperController.goToNext();
                              practiceStepperController
                                  .updateNextStepAvailability(false);
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
    );
  }
}
