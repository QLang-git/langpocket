import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/custom_dialog_practice.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/screens/practice/interactive/screen/practice_interactive_screen.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/step_message.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/steps/listen_and_write/listen_write_controller.dart';
import 'package:langpocket/src/screens/practice/spelling/controller/spelling_controller.dart';
import 'package:langpocket/src/utils/constants/messages.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class ListenWrite extends StatefulWidget {
  final WordRecord wordRecord;
  const ListenWrite({super.key, required this.wordRecord});

  @override
  State<ListenWrite> createState() => _ListenWriteState();
}

class _ListenWriteState extends State<ListenWrite>
    with AutomaticKeepAliveClientMixin {
  late int pointer;
  late SpellingController spellingController;
  late int countSpelling;
  late bool activateExample;
  late bool correctness;

  late TextEditingController inputController;
  late ListenWriteController listenWriteController;

  late bool isDialogShowing;

  @override
  void initState() {
    final globuleStates =
        context.findAncestorStateOfType<PracticePronScreenState>()!;
    inputController = TextEditingController();
    final WordRecord(:foreignWord, :wordExamples) = widget.wordRecord;
    spellingController = SpellingController(
      onNewWordRecord: (value) {},
      countExampleSpelling: 1,
      countWordSpelling: 1,
      foreignWord: foreignWord,
      examplesList: wordExamples,
      onListeningCount: setCounter,
      onExampleSateListening: setExamplesState,
      onPointerListening: setNewPointer,
      onCorrectness: setTextCorrectness,
    );
    listenWriteController = ListenWriteController(
        setTextCorrectness: setTextCorrectness,
        inputController: inputController,
        globuleStates: globuleStates,
        spellingController: spellingController);

    final initial = spellingController.initializeControllerValues();

    activateExample = initial.activateExample;
    pointer = initial.pointer;
    countSpelling = 1;
    correctness = false;
    listenWriteController.initialization();
    isDialogShowing = false;
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();

    super.dispose();
  }

  void setCounter(int count) => setState(() {
        countSpelling = count;
      });
  void setNewPointer(int state) => setState(() {
        pointer = state;
      });

  void setExamplesState(bool state) => setState(() {
        activateExample = state;
      });

  void setTextCorrectness(bool res) => setState(() {
        correctness = res;
      });

  @override
  Widget build(BuildContext context) {
    final WordRecord(:wordImages, :foreignWord, :wordExamples) =
        widget.wordRecord;

    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    super.build(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      listenWriteController.inputCorrectnessStyle(correctness);
      listenWriteController.exampleMapper(
          countSpelling, activateExample, pointer);
      if (countSpelling == 0 &&
          pointer >= spellingController.examplesList.length - 1) {
        popUpDialog(context, MyMessages(), foreignWord, wordExamples);
      }
    });

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(size: 40, color: colorScheme.primary),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const StepMessage(message: 'Whisper Challenge: Listen and Write'),
              const SizedBox(height: 25),
              ImageView(imageList: wordImages),
              const SizedBox(height: 5),
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
                        onPressed: () => listenWriteController
                            .sayText(), // Disabled regular tap
                        backgroundColor: Colors.indigo[500],
                        elevation: 0,
                        child: const Icon(Icons.volume_up_outlined),
                      )),
                      GestureDetector(
                        child: FloatingActionButton(
                            onPressed: () => listenWriteController
                                .repeatProcess(), // Disabled regular tap
                            backgroundColor: Colors.indigo[500],
                            elevation: 0,
                            child: const Icon(Icons.repeat_outlined)),
                      )
                    ],
                  )),
              const SizedBox(height: 25),
              TextField(
                readOnly: correctness,
                enableIMEPersonalizedLearning: false,
                enableSuggestions: false,
                autocorrect: false,
                controller: inputController,
                onChanged: (value) {
                  spellingController.comparingTexts(value);
                },
                style: textTheme.headlineMedium
                    ?.copyWith(color: colorScheme.outline),
                decoration: InputDecoration(
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
          ),
        ],
      ),
    );
  }

  void popUpDialog(BuildContext context, MyMessages myMessage,
      String foreignWord, List<String> examplesList) {
    if (!isDialogShowing) {
      isDialogShowing = true;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogPractice(
              messages: myMessage.getPracticeMessage(
                PracticeMessagesType.practiceInteractively,
                foreignWord,
              ),
              reload: listenWriteController.startOver,
            );
          }).then((value) => isDialogShowing = false);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
