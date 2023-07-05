import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:langpocket/src/common_controller/microphone_usage.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/screens/practice/interactive/screen/practice_interactive_screen.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/animated_sound_icon.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/step_message.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/steps_microphone_button.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/steps/listen_and_repeat/listen_repeat_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class ListenRepeat extends StatefulWidget {
  final WordRecord wordRecord;
  const ListenRepeat({super.key, required this.wordRecord});

  @override
  State<ListenRepeat> createState() => _ListenRepeatState();
}

// Known data points
Map<double, double> knownData = {
  500: 0,
  600: 15,
  700: 30,
  800: 62,
  900: 72,
  1000: 82,
  1840: 83
};
const _listStep = 4;

class _ListenRepeatState extends State<ListenRepeat>
    with AutomaticKeepAliveClientMixin {
  late ListenRepeatController listenRepeatController;
  late MicrophoneController microphoneController;

  late String message;
  late int countPron;
  late int pointer;
  late bool example;
  int step = 1;

  @override
  void initState() {
    final globuleStates =
        context.findAncestorStateOfType<PracticePronScreenState>()!;
    final WordRecord(:foreignWord, :wordExamples) = widget.wordRecord;
    microphoneController = MicrophoneController(ConstIterMicrophone(),
        onListeningMessages: setMessage,
        onListeningCount: setCounter,
        foreignWord: foreignWord,
        examplesList: wordExamples,
        onExampleSateListening: setExamplesState,
        onPointerListening: setNewPointer);
    listenRepeatController = ListenRepeatController(
      globuleSates: globuleStates,
      moveToNextStep: moveToNextStep,
      microphoneController: microphoneController,
      setMicActivation: setMicActivation,
    );
    listenRepeatController.listen();
    final initial = microphoneController.initializeControllerValues();
    countPron = initial.countPron;
    example = initial.activateExample;
    pointer = initial.pointer;
    message = initial.initialMessage;
    super.initState();
    microphoneController.initializeSpeechToText();
  }

  bool micActivation = false;

  void setMessage(String currentMessage) => setState(() {
        message = currentMessage;
      });
  void setCounter(int count) => setState(() {
        countPron = count;
        if (count == 0) listenRepeatController.setMicState(false);
      });
  void setNewPointer(int state) => setState(() {
        pointer = state;
      });

  void setExamplesState(bool state) => setState(() {
        example = state;
      });
  void setMicActivation(bool state) => setState(() {
        micActivation = state;
      });

  void moveToNextStep(int value) => setState(() {
        step = value;
      });

  @override
  Widget build(BuildContext context) {
    final WordRecord(:wordImages) = widget.wordRecord;

    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    super.build(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      listenRepeatController.stepsMapper(step);
    });

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(size: 40, color: colorScheme.primary),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const StepMessage(message: 'Echo Mastery: Listen and Repeat'),
              const SizedBox(height: 50),
              ImageView(imageList: wordImages),
              AnimatedSoundIcon(micActivation: micActivation),
              const SizedBox(height: 50),
              Container(
                  alignment: Alignment.bottomLeft,
                  height: 60,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: colorScheme.onSecondary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StepsMicrophoneButton(
                        microphoneController: microphoneController,
                        activation: micActivation,
                      ),
                      GestureDetector(
                          child: FloatingActionButton(
                        onPressed: step != _listStep
                            ? null
                            : () => listenRepeatController
                                .playNormal(), // Disabled regular tap
                        backgroundColor: step == _listStep
                            ? Colors.indigo[500]
                            : Colors.grey,
                        elevation: 0,
                        child: const Icon(Icons.play_arrow),
                      )),
                      GestureDetector(
                        child: FloatingActionButton(
                            onPressed: step != _listStep
                                ? null
                                : () => listenRepeatController
                                    .reset(), // Disabled regular tap
                            backgroundColor: step == _listStep
                                ? Colors.indigo[500]
                                : Colors.grey,
                            elevation: 0,
                            child: const Icon(Icons.repeat_outlined)),
                      )
                    ],
                  )),
            ],
          ),
          Positioned(
            top: 0,
            bottom: 54.5,
            left: _adjustMessageLocation(
                screenWidth), // Adjust the value as needed
            right: 0,
            child: AnimatedOpacity(
              opacity: micActivation ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 82, right: 5),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textTheme.labelLarge?.fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _adjustMessageLocation(double screenWidth) {
    // Find the two nearest known data points
    double lowerScreenSize = 0;
    double upperScreenSize = 1840;

    knownData.forEach((screenSize, position) {
      if (screenSize <= screenWidth && screenSize > lowerScreenSize) {
        lowerScreenSize = screenSize;
      }
      if (screenSize >= screenWidth && screenSize < upperScreenSize) {
        upperScreenSize = screenSize;
      }
    });
    if (lowerScreenSize != upperScreenSize) {
      final lowerPosition = knownData[lowerScreenSize]!;
      final upperPosition = knownData[upperScreenSize]!;

      final factor =
          (screenWidth - lowerScreenSize) / (upperScreenSize - lowerScreenSize);
      return lowerPosition + (upperPosition - lowerPosition) * factor;
    } else {
      return knownData[lowerScreenSize]!;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
