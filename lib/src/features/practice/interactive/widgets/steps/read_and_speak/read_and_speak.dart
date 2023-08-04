import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/example_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/features/practice/interactive/controller/practice_stepper_controller.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/practice_stepper/step_message.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/practice_stepper/steps_microphone_button.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/steps/read_and_speak/read_and_speak_controller.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_single_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class ReadSpeak extends ConsumerStatefulWidget {
  final int wordId;
  const ReadSpeak({super.key, required this.wordId});

  @override
  ConsumerState<ReadSpeak> createState() => _ReadSpeakState();
}

class _ReadSpeakState extends ConsumerState<ReadSpeak> {
  late MicSingleController micSingleController;
  late PracticeStepperController practiceStepperController;
  late ReadSpeakController readSpeakController;

  @override
  void initState() {
    super.initState();
    micSingleController = ref.refresh(micSingleControllerProvider.notifier);
    readSpeakController = ref.refresh(readSpeakControllerProvider.notifier);
    micSingleController.setWordRecords(
        wordId: widget.wordId,
        countPron: 1,
        countExamplePron: 1,
        exampleActivationMessage:
            'Now your turn : Try to Pronounce the sentence ',
        initialMessage: 'Now your turn : Hold to Start Recording ...');

    practiceStepperController =
        ref.read(practiceStepperControllerProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final rsc = ref.watch(readSpeakControllerProvider);
    final mic = ref.watch(micSingleControllerProvider);

    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    if (mic.hasValue && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        readSpeakController.stepsMapper(
          mic.value!,
          micSingleController,
          practiceStepperController,
        );
      });
    }

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(size: 40, color: colorScheme.primary),
      ),
      child: AsyncValueWidget(
        value: mic,
        child: (micState) {
          final MicWordState(:activateExample, :examplePinter, :micMessage) =
              micState;
          final WordRecord(
            :wordImages,
            :wordExamples,
            :foreignWord,
            :wordMeans
          ) = micState.wordRecord;

          return Column(
            children: [
              const StepMessage(message: 'Vocal Voyage: Read and Speak'),
              SizedBox(
                height: 150,
                child: ImageView(
                  imageList: wordImages,
                  meanings: wordMeans,
                ),
              ),
              activateExample
                  ? ExampleView(
                      example: wordExamples[examplePinter],
                      noVoiceIcon: true,
                    )
                  : WordView(
                      foreignWord: foreignWord,
                      means: wordMeans,
                      noVoiceIcon: true,
                    ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 135,
                child: Stack(children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 80,
                    // adjust this value to your requirements
                    child: AnimatedOpacity(
                      opacity: rsc ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
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
                          micMessage,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: textTheme.labelLarge?.fontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                        height: 75,
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
                              onPressed: () {
                                practiceStepperController.goToPrevious();
                              }, // Disabled regular tap
                              backgroundColor: Colors.indigo[500],

                              elevation: 0,
                              child: const Icon(
                                Icons.arrow_back,
                                size: 40,
                              ),
                            )),
                            StepsMicrophoneButton(
                              isAnalyzing: micState.isAnalyzing,
                              microphoneController: micSingleController,
                              activation: rsc,
                            ),
                            GestureDetector(
                              child: FloatingActionButton(
                                onPressed: () {
                                  readSpeakController.reset(micSingleController,
                                      practiceStepperController);
                                }, // Disabled regular tap
                                backgroundColor: Colors.indigo[500],
                                elevation: 0,
                                child:
                                    const Icon(Icons.repeat_outlined, size: 30),
                              ),
                            )
                          ],
                        )),
                  ),
                ]),
              )
            ],
          );
        },
      ),
    );
  }
}
