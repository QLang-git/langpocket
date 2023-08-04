import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/custom_text_form_field.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/features/practice/interactive/dialogs/inter_dialog.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/practice_stepper/step_message.dart';
import 'package:langpocket/src/features/practice/interactive/widgets/steps/listen_and_write/listen_write_controller.dart';
import 'package:langpocket/src/features/practice/spelling/controllers/spelling_word_controller.dart';

class ListenWrite extends ConsumerStatefulWidget {
  final int wordId;
  const ListenWrite({super.key, required this.wordId});

  @override
  ConsumerState<ListenWrite> createState() => _ListenWriteState();
}

class _ListenWriteState extends ConsumerState<ListenWrite> {
  late TextEditingController inputController;
  late ListenWriteController listenWriteController;
  late SpellingWordController spellingWordController;

  late bool isDialogShowing;

  @override
  void initState() {
    super.initState();
    isDialogShowing = false;
    inputController = TextEditingController();
    listenWriteController = ref.read(listenWriteControllerProvider.notifier);
    spellingWordController =
        ref.read(spellingWordControllerProvider(widget.wordId).notifier);
    spellingWordController.setWordRecords(
        countSpelling: 2, countExampleSpelling: 1);
  }

  @override
  Widget build(BuildContext context) {
    final spellingWordState =
        ref.watch(spellingWordControllerProvider(widget.wordId));
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    if (spellingWordState.hasValue) {
      final SpellingWordState(
        :correctness,
        :countSpelling,
        :examplePinter,
        :wordRecord,
      ) = spellingWordState.value!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        listenWriteController.inputCorrectnessStyle(
            correctness, spellingWordController, inputController);
        listenWriteController.stageMapper(
            spellingWordState.value!, spellingWordController);
        // exampleMapper(
        //     countSpelling, activateExample, pointer);
        if (countSpelling == 0 &&
            examplePinter >= wordRecord.wordExamples.length - 1) {
          popUpDialog(context, wordRecord.foreignWord, wordRecord.wordExamples);
        }
      });
    }

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(size: 40, color: colorScheme.primary),
      ),
      child: AsyncValueWidget(
        value: spellingWordState,
        child: (spelling) {
          final SpellingWordState(
            :correctness,
            :wordRecord,
          ) = spelling;
          return Column(
            children: [
              const StepMessage(message: 'Whisper Challenge: Listen and Write'),
              SizedBox(
                height: 150,
                child: ImageView(
                    imageList: wordRecord.wordImages,
                    meanings: wordRecord.wordMeans),
              ),
              const SizedBox(height: 10),
              Container(
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
                  'Listen closely and write it down!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textTheme.labelLarge?.fontSize,
                  ),
                ),
              ),
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
                        onPressed: () => listenWriteController
                            .goBack(), // Disabled regular tap
                        backgroundColor: Colors.indigo[500],

                        elevation: 0,
                        child: const Icon(Icons.arrow_back),
                      )),
                      GestureDetector(
                          child: FloatingActionButton(
                        onPressed: () => listenWriteController.sayText(spelling,
                            spellingWordController), // Disabled regular tap
                        backgroundColor: Colors.indigo[500],
                        elevation: 0,
                        child: const Icon(Icons.volume_up_outlined),
                      )),
                      GestureDetector(
                        child: FloatingActionButton(
                            onPressed: () => listenWriteController.repeatProcess(
                                spelling,
                                spellingWordController), // Disabled regular tap
                            backgroundColor: Colors.indigo[500],
                            elevation: 0,
                            child: const Icon(Icons.repeat_outlined)),
                      )
                    ],
                  )),
              const SizedBox(height: 25),
              CustomTextField(
                readOnly: correctness,
                enableIMEPersonalizedLearning: false,
                enableSuggestions: false,
                autocorrect: false,
                controller: inputController,
                onChanged: (value) {
                  spellingWordController.comparingTexts(value);
                },
                style: textTheme.headlineMedium
                    ?.copyWith(color: colorScheme.outline),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  filled: true,
                  fillColor: correctness
                      ? const Color.fromARGB(255, 104, 198, 107)
                      : null,
                  labelStyle:
                      textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
                  label: const Text('Write it down'),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                // The validator receives the text that the user has entered.
              ),
            ],
          );
        },
      ),
    );
  }

  void popUpDialog(
      BuildContext context, String foreignWord, List<String> examplesList) {
    if (!isDialogShowing) {
      isDialogShowing = true;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return InterDialog(
              word: foreignWord,
              reload: listenWriteController.startOver,
            );
          }).then((value) => isDialogShowing = false);
    }
  }
}
