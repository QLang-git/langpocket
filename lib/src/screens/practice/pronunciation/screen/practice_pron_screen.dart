import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/common_controller/microphone_usage.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/example_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/practice/pronunciation/app_bar/pron_appbar.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:langpocket/src/screens/practice/pronunciation/widgets/microphone_button.dart';
import 'package:langpocket/src/common_widgets/custom_dialog_practice.dart';
import 'package:langpocket/src/utils/constants/messages.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class PracticePronScreen extends ConsumerStatefulWidget {
  final WordRecord word;
  final String? groupId;
  const PracticePronScreen({
    super.key,
    required this.word,
    required this.groupId,
  });

  @override
  ConsumerState<PracticePronScreen> createState() => _PracticePronScreenState();
}

class _PracticePronScreenState extends ConsumerState<PracticePronScreen> {
  late int countPron;
  late bool correct;
  late List<bool> correctExample;
  late List<int> examplePronCount;
  late int pointer;
  late bool example;
  late MicrophoneController microphoneController;
  late String message;
  late WordRecord wordRecord;

  @override
  void initState() {
    wordRecord = widget.word;
    microphoneController = MicrophoneController(ConstPronMicrophone(),
        onListeningMessages: setMessage,
        onListeningCount: setCounter,
        foreignWord: widget.word.foreignWord,
        examplesList: widget.word.wordExamples,
        onExampleSateListening: setExamplesState,
        onPointerListening: setNewPointer,
        onNewWordRecord: setNewWordRecord);
    final initial = microphoneController.initializeControllerValues();
    countPron = initial.countPron;
    example = initial.activateExample;
    pointer = initial.pointer;
    message = initial.initialMessage;
    super.initState();
    microphoneController.initializeSpeechToText();
  }

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
  void setNewWordRecord(WordRecord newWordRecord) {
    setState(() {
      wordRecord = newWordRecord;
    });
  }

  @override
  Widget build(BuildContext context) {
    final WordRecord(:foreignWord, :wordImages, :wordExamples, :wordMeans) =
        wordRecord;
    final myMessage = MyMessages();
    final textStyle = Theme.of(context).textTheme;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.groupId != null) {
        popUpDialogGroup(context, myMessage, foreignWord, wordExamples);
      } else {
        popUpDialogSingle(context, myMessage, foreignWord, wordExamples);
      }
    });

    return ResponsiveCenter(
      child: Scaffold(
        appBar: const PronAppBar(),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Stack(children: [
                Column(
                  children: [
                    ImageView(imageList: wordImages),
                    const SizedBox(
                      height: 15,
                    ),
                    countPron > microphoneController.stopPeaking || example
                        ? WordView(
                            foreignWord: foreignWord,
                            means: wordMeans,
                          )
                        : Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.all(10),
                            child: const SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(
                                    Ionicons.eye_off,
                                    size: 40,
                                  ),
                                )),
                          ),
                    example
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 25),
                                child: Divider(
                                  height: 20,
                                ),
                              ),
                              ExampleView(example: wordExamples[pointer])
                            ],
                          )
                        : Container()
                  ],
                ),
              ])),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 230,
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: MicrophoneButton(
                        microphoneController: microphoneController,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(10),
                      shape: const CircleBorder(),
                      color: Colors.indigo[400],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          countPron.toString(),
                          style: textStyle.displayLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void popUpDialogSingle(BuildContext context, MyMessages myMessage,
      String foreignWord, List<String> examplesList) {
    if (countPron == 0 && !example) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogPractice(
              messages: myMessage.getPracticeMessage(
                PracticeMessagesType.practicePronunciation,
                foreignWord,
              ),
              reload: microphoneController.resetting,
              activateExamples: microphoneController.examplesActivation,
            );
          });
    } else if (countPron == 0 && example) {
      if (pointer < examplesList.length - 1) {
        microphoneController.moveToNextExamples();
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogPractice(
                messages: myMessage.getPracticeMessage(
                  PracticeMessagesType.practicePronExampleComplete,
                  foreignWord,
                ),
                reload: microphoneController.resetting,
                activateExamples: microphoneController.examplesActivation,
              );
            });
      }
    }
  }

  void popUpDialogGroup(BuildContext context, MyMessages myMessage,
      String foreignWord, List<String> examplesList) {
    if (countPron == 0) {
      if (example && pointer < examplesList.length - 1) {
        microphoneController.moveToNextExamples();
      } else if (!example) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogPractice(
              messages: myMessage.getPracticeMessage(
                PracticeMessagesType.practicePronunciationGroup,
                foreignWord,
              ),
              reload: microphoneController.isThereNextWord
                  ? microphoneController.moveToNextWord
                  : null,
              activateExamples: microphoneController.examplesActivation,
            );
          },
        );
      } else if (countPron == 0 &&
          example &&
          microphoneController.isThereNextWord) {
        microphoneController.moveToNextWord();
        return;
      } else if (countPron == 0 && example) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogPractice(
              messages: myMessage.getPracticeMessage(
                PracticeMessagesType.practicePronExampleCompleteGroup,
                foreignWord,
              ),
              reload: microphoneController.resetting,
              activateExamples: microphoneController.examplesActivation,
            );
          },
        );
      }
    }
  }
}
