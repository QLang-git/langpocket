import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/example_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/features/practice/pronunciation/app_bar/pron_appbar.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_group_controller.dart';
import 'package:langpocket/src/features/practice/pronunciation/widgets/microphone_button.dart';
import 'package:langpocket/src/common_widgets/custom_dialog_practice.dart';
import 'package:langpocket/src/utils/constants/messages.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class PracticePronGroupScreen extends ConsumerStatefulWidget {
  final int groupId;
  const PracticePronGroupScreen({
    super.key,
    required this.groupId,
  });

  @override
  ConsumerState<PracticePronGroupScreen> createState() =>
      _PracticePronScreenState();
}

class _PracticePronScreenState extends ConsumerState<PracticePronGroupScreen> {
  late MicGroupController microphoneController;
  late MyMessages myMessages;

  @override
  void initState() {
    myMessages = MyMessages();
    microphoneController =
        ref.read(micGroupControllerProvider(widget.groupId).notifier);
    microphoneController.setWordRecords(
        initialMessage: 'Hold to Start Recording ...');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final micState = ref.watch(micGroupControllerProvider(widget.groupId));

    final textStyle = Theme.of(context).textTheme;
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
              final MicGroupState(
                :indexWord,
                :countPron,
                :activateExample,
                :examplePinter
              ) = micWordState;

              final WordRecord(
                :foreignWord,
                :wordImages,
                :wordMeans,
                :wordExamples
              ) = micWordState.wordsRecord[indexWord];
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: Stack(children: [
                    Column(
                      children: [
                        ImageView(imageList: wordImages),
                        const SizedBox(
                          height: 15,
                        ),
                        countPron > 2 || activateExample
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Icon(
                                        Ionicons.eye_off,
                                        size: 40,
                                      ),
                                    )),
                              ),
                        activateExample
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
                                  ExampleView(
                                      example: wordExamples[examplePinter])
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ]));
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

  void addPostFrameCallback(
      BuildContext context, MyMessages myMessage, MicGroupState micWordsState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      popUpDialogGroup(context, myMessage, micWordsState);
      // if (widget.groupId != null) {
      //   popUpDialogGroup(context, myMessage, foreignWord, wordExamples);
      // } else {
      //   popUpDialogSingle(context, myMessage, foreignWord, wordExamples);
      // }
    });
  }

  void popUpDialogGroup(
      BuildContext context, MyMessages myMessage, MicGroupState micGroupState) {
    final MicGroupState(
      :countPron,
      :examplePinter,
      :activateExample,
      :wordsRecord,
      :indexWord
    ) = micGroupState;
    final wordRecord = wordsRecord[indexWord];
    if (countPron == 0) {
      if (activateExample &&
          examplePinter < wordRecord.wordExamples.length - 1) {
        microphoneController.moveToNextExamples(examplePinter);
      } else if (!activateExample) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogPractice(
              messages: myMessage.getPracticeMessage(
                PracticeMessagesType.practicePronunciationGroup,
                wordRecord.foreignWord,
              ),
              reload: microphoneController.isThereNextWord
                  ? microphoneController.moveToNextWord
                  : null,
              activateExamples: microphoneController.exampleActivation,
            );
          },
        );
      } else if (countPron == 0 &&
          activateExample &&
          microphoneController.isThereNextWord) {
        microphoneController.moveToNextWord();
        return;
      } else if (countPron == 0 && activateExample) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogPractice(
              messages: myMessage.getPracticeMessage(
                PracticeMessagesType.practicePronExampleCompleteGroup,
                wordRecord.foreignWord,
              ),
              reload: microphoneController.startOver,
              activateExamples: microphoneController.exampleActivation,
            );
          },
        );
      }
    }
  }
}
