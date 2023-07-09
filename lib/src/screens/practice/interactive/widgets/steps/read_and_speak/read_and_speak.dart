import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:langpocket/src/common_controller/microphone_usage.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/example_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/practice/interactive/screen/practice_interactive_screen.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/step_message.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/steps_microphone_button.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/steps/read_and_speak/read_and_speak_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class ReadSpeak extends StatefulWidget {
  final WordRecord wordRecord;
  const ReadSpeak({super.key, required this.wordRecord});

  @override
  State<ReadSpeak> createState() => _ReadSpeakState();
}

// Known data points

class _ReadSpeakState extends State<ReadSpeak>
    with AutomaticKeepAliveClientMixin {
  late ReadSpeakController readSpeakController;
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
    microphoneController = MicrophoneController(ConstReadSpeakMicrophone(),
        onListeningMessages: setMessage,
        onListeningCount: setCounter,
        foreignWord: foreignWord,
        examplesList: wordExamples,
        onExampleSateListening: setExamplesState,
        onPointerListening: setNewPointer,
        onNewWordRecord: (WordRecord value) {});

    readSpeakController = ReadSpeakController(
      micActivation: setMicActivation,
      microphoneController: microphoneController,
      globuleStates: globuleStates,
    );

    final initial = microphoneController.initializeControllerValues();
    countPron = initial.countPron;
    example = initial.activateExample;
    pointer = initial.pointer;
    message = initial.initialMessage;
    super.initState();
    microphoneController.initializeSpeechToText();
  }

  bool micActivation = true;
  void setMessage(String currentMessage) => setState(() {
        message = currentMessage;
      });
  void setCounter(int count) => setState(() {
        countPron = count;
      });
  void setNewPointer(int state) => setState(() {
        pointer = state;
      });

  void setExamplesState(bool state) => setState(() {
        example = state;
      });

  void moveToNextStep(int value) => setState(() {
        step = value;
      });
  void setMicActivation(bool state) {
    if (mounted) {
      setState(() {
        micActivation = state;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final WordRecord(:wordImages, :foreignWord, :wordMeans, :wordExamples) =
        widget.wordRecord;

    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    super.build(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readSpeakController.activateExample(countPron, example);
    });

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(size: 40, color: colorScheme.primary),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const StepMessage(message: 'Vocal Voyage: Read and Speak'),
              const SizedBox(height: 30),
              ImageView(imageList: wordImages),
              example
                  ? ExampleView(
                      example: wordExamples[pointer],
                      noVoiceIcon: true,
                    )
                  : WordView(
                      foreignWord: foreignWord,
                      means: wordMeans,
                      noVoiceIcon: true,
                    ),
              const SizedBox(height: 50),
              micActivation
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: textTheme.labelLarge?.fontSize,
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 5),
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
                      GestureDetector(
                          child: FloatingActionButton(
                        onPressed: () => readSpeakController
                            .goBack(), // Disabled regular tap
                        backgroundColor: Colors.indigo[500],

                        elevation: 0,
                        child: const Icon(Icons.arrow_back),
                      )),
                      StepsMicrophoneButton(
                        microphoneController: microphoneController,
                        activation: micActivation,
                      ),
                      GestureDetector(
                        child: FloatingActionButton(
                            onPressed: () => readSpeakController
                                .reset(), // Disabled regular tap
                            backgroundColor: Colors.indigo[500],
                            elevation: 0,
                            child: const Icon(Icons.repeat_outlined)),
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
