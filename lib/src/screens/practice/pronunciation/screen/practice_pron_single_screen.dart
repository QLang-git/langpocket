import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/practice/pronunciation/controllers/mic_controller.dart';
import 'package:langpocket/src/screens/practice/pronunciation/controllers/mic_single_controller.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/practice/pronunciation/app_bar/pron_appbar.dart';
import 'package:langpocket/src/screens/practice/pronunciation/widgets/microphone_button.dart';
import 'package:langpocket/src/common_widgets/custom_dialog_practice.dart';
import 'package:langpocket/src/screens/practice/pronunciation/widgets/practice_pronunciation.dart';
import 'package:langpocket/src/utils/constants/messages.dart';

class PracticePronSingleScreen extends ConsumerStatefulWidget {
  final int wordId;
  const PracticePronSingleScreen({
    super.key,
    required this.wordId,
  });

  @override
  ConsumerState<PracticePronSingleScreen> createState() =>
      _PracticePronScreenState();
}

class _PracticePronScreenState extends ConsumerState<PracticePronSingleScreen> {
  late MicController microphoneController;
  late MyMessages myMessages;

  @override
  void initState() {
    myMessages = MyMessages();
    microphoneController =
        ref.read(micSingleControllerProvider(widget.wordId).notifier);
    microphoneController.setWordRecords(
        initialMessage: 'Hold to Start Recording ...');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final micState = ref.watch(micSingleControllerProvider(widget.wordId));
    final ThemeData(:textTheme) = Theme.of(context);

    if (micState.hasValue) {
      addPostFrameCallback(context, myMessages, micState.value!);
    }

    return ResponsiveCenter(
      child: Scaffold(
        appBar: const PronAppBar(),
        body: SingleChildScrollView(
          child: AsyncValueWidget(
            value: micState,
            child: (micWordState) {
              final word = micWordState.wordRecord;
              return PracticePronunciation<MicWordState>(
                wordRecord: word,
                micState: micWordState,
              );
            },
          ),
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
                    micState.hasValue
                        ? micState.value!.micMessage
                        : 'Loading..',
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
                        isAnalyzing: micState.value?.isAnalyzing,
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
                          micState.hasValue
                              ? micState.value!.countPron.toString()
                              : '0',
                          style: textTheme.displayLarge
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

  void addPostFrameCallback(
      BuildContext context, MyMessages myMessage, MicWordState micWordState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      popUpDialogSingle(context, myMessage, micWordState);
      // if (widget.groupId != null) {
      //   popUpDialogGroup(context, myMessage, foreignWord, wordExamples);
      // } else {
      //   popUpDialogSingle(context, myMessage, foreignWord, wordExamples);
      // }
    });
  }

  void popUpDialogSingle(
      BuildContext context, MyMessages myMessage, MicWordState micWordState) {
    if (micWordState.countPron == 0 && !micWordState.activateExample) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogPractice(
              messages: myMessage.getPracticeMessage(
                PracticeMessagesType.practicePronunciation,
                micWordState.wordRecord.foreignWord,
              ),
              reload: microphoneController.startOver,
              activateExamples: microphoneController.exampleActivation,
            );
          });
    } else if (micWordState.countPron == 0 && micWordState.activateExample) {
      if (micWordState.examplePinter <
          micWordState.wordRecord.wordExamples.length - 1) {
        microphoneController.moveToNextExamples(micWordState.examplePinter);
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogPractice(
                messages: myMessage.getPracticeMessage(
                  PracticeMessagesType.practicePronExampleComplete,
                  micWordState.wordRecord.foreignWord,
                ),
                reload: microphoneController.startOver,
                activateExamples: microphoneController.exampleActivation,
              );
            });
      }
    }
  }
}
