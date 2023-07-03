import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:langpocket/src/common_controller/microphone_usage.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
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

class _ListenRepeatState extends State<ListenRepeat>
    with AutomaticKeepAliveClientMixin {
  late ListenRepeatController listenRepeatController;
  late List<Uint8List> images;
  late MicrophoneController microphoneController;

  late String message;
  late int countPron;
  late int pointer;
  late bool example;

  @override
  void initState() {
    final WordRecord(:wordImages, :foreignWord, :wordExamples) =
        widget.wordRecord;
    microphoneController = MicrophoneController(ConstIterMicrophone(),
        onListeningMessages: setMessage,
        onListeningCount: setCounter,
        foreignWord: foreignWord,
        examplesList: wordExamples,
        onExampleSateListening: setExamplesState,
        onPointerListening: setNewPointer);
    images = wordImages;
    listenRepeatController = ListenRepeatController(
        foreignWord: foreignWord, setMicActivation: setMicActivation);
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
        if (count == 0) setMicActivation(false);
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

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    super.build(context);
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
              ImageView(imageList: images),
              const SizedBox(height: 80),
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
                      const Icon(Icons.play_arrow),
                      const Icon(Icons.repeat_outlined)
                    ],
                  )),
            ],
          ),
          micActivation
              ? Positioned(
                  top: 0,
                  bottom: 54.5,
                  left: 0,
                  right: 0,
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
                      )),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
