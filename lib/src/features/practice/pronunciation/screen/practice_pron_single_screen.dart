import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_controller.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_single_controller.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/practice/pronunciation/app_bar/pron_appbar.dart';
import 'package:langpocket/src/features/practice/pronunciation/dialogs/pron_single_dialog.dart';
import 'package:langpocket/src/features/practice/pronunciation/widgets/microphone_button.dart';
import 'package:langpocket/src/features/practice/pronunciation/widgets/practice_pronunciation.dart';

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

  @override
  void initState() {
    microphoneController = ref.read(micSingleControllerProvider.notifier);
    microphoneController.setWordRecords(
        wordId: widget.wordId, initialMessage: 'Hold to Start Recording ...');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final micState = ref.watch(micSingleControllerProvider);
    final ThemeData(:textTheme) = Theme.of(context);

    if (micState.hasValue) {
      addPostFrameCallback(context, micState.value!);
    }

    return ResponsiveCenter(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
          height: 190,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      micState.hasValue
                          ? micState.value!.micMessage
                          : 'Loading..',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
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

  void addPostFrameCallback(BuildContext context, MicWordState micWordState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      popUpDialogSingle(context, micWordState);
    });
  }

  void popUpDialogSingle(BuildContext context, MicWordState micWordState) {
    if (micWordState.countPron == 0 && !micWordState.activateExample) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return PronSingleWordDialog(
              word: micWordState.wordRecord.foreignWord,
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
              return PronSingleWordExampleDialog(
                reload: microphoneController.startOver,
                activateExamples: microphoneController.exampleActivation,
              );
            });
      }
    }
  }
}
