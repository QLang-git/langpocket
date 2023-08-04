import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/features/practice/interactive/controller/practice_stepper_controller.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/practice_stepper/animated_sound_icon.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/practice_stepper/step_message.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/practice_stepper/steps_microphone_button.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/steps/listen_and_repeat/listen_repeat_controller.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_single_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class ListenRepeat extends ConsumerStatefulWidget {
  final int wordId;
  const ListenRepeat({super.key, required this.wordId});

  @override
  ConsumerState<ListenRepeat> createState() => _ListenRepeatState();
}

const _listStep = 5;

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

class _ListenRepeatState extends ConsumerState<ListenRepeat> {
  late MicSingleController microphoneController;
  late ListenRepeatController listenRepeatController;
  late PracticeStepperController stepperController;

  @override
  void initState() {
    super.initState();
    stepperController = ref.read(practiceStepperControllerProvider.notifier);
    microphoneController = ref.refresh(micSingleControllerProvider.notifier);
    listenRepeatController = ref.read(listenRepeatControllerProvider.notifier);
    stepperController = ref.read(practiceStepperControllerProvider.notifier);
    microphoneController.setWordRecords(
        id: widget.wordId,
        countPron: 1,
        countExamplePron: 1,
        exampleActivationMessage:
            'Now your turn : Try to Pronounce the sentence ',
        initialMessage: 'Now your turn : Hold to Start Recording ...');
  }

  @override
  Widget build(BuildContext context) {
    final lRs = ref.watch(listenRepeatControllerProvider);
    final mic = ref.watch(micSingleControllerProvider);

    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    if (mounted && mic.hasValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        listenRepeatController.stageMapper(
            mic.value!, microphoneController, stepperController);
      });
    }

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(size: 40, color: colorScheme.primary),
      ),
      child: AsyncValueWidget(
        value: mic,
        child: (micStates) {
          final WordRecord(:wordImages, :wordMeans) = micStates.wordRecord;

          return Column(
            children: [
              const StepMessage(message: 'Echo Mastery: Listen and Repeat'),
              SizedBox(
                height: 150,
                child: ImageView(
                  imageList: wordImages,
                  meanings: wordMeans,
                ),
              ),
              AnimatedSoundIcon(micActivation: lRs.micState),
              SizedBox(
                width: double.infinity,
                height: 160,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 70, // adjust this value to your requirements
                      child: AnimatedOpacity(
                        opacity: lRs.micState ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 60),
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
                                micStates.micMessage,
                                maxLines: 3,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontSize: textTheme.labelLarge?.fontSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
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
                                isAnalyzing: micStates.isAnalyzing,
                                microphoneController: microphoneController,
                                activation: lRs.micState,
                              ),
                              GestureDetector(
                                  child: FloatingActionButton(
                                onPressed: lRs.micState || lRs.stage == 5
                                    ? () {
                                        ref
                                            .read(listenRepeatControllerProvider
                                                .notifier)
                                            .playNormal(micStates);
                                      }
                                    : null, // Disabled regular tap
                                backgroundColor: lRs.micState || lRs.stage == 5
                                    ? Colors.indigo[500]
                                    : Colors.grey,
                                elevation: 0,
                                child: const Icon(Icons.play_arrow, size: 40),
                              )),
                              GestureDetector(
                                child: FloatingActionButton(
                                    onPressed: lRs.stage != _listStep
                                        ? null
                                        : () {
                                            ref
                                                .read(
                                                    listenRepeatControllerProvider
                                                        .notifier)
                                                .reset(microphoneController,
                                                    stepperController);
                                          }, // Disabled regular tap
                                    backgroundColor: lRs.stage == _listStep
                                        ? Colors.indigo[500]
                                        : Colors.grey,
                                    elevation: 0,
                                    child: const Icon(
                                      Icons.repeat_outlined,
                                      size: 30,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
