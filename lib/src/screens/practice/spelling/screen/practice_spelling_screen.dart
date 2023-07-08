import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/practice/spelling/app_bar/spelling_appbar.dart';
import 'package:langpocket/src/common_widgets/custom_dialog_practice.dart';
import 'package:langpocket/src/screens/practice/spelling/controller/spelling_controller.dart';
import 'package:langpocket/src/utils/constants/messages.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class PracticeSpellingScreen extends StatefulWidget {
  final WordRecord word;
  final String? groupId;

  const PracticeSpellingScreen({
    super.key,
    required this.word,
    this.groupId,
  });

  @override
  State<PracticeSpellingScreen> createState() => PracticeSpellingScreenState();
}

class PracticeSpellingScreenState extends State<PracticeSpellingScreen> {
  late WordRecord wordRecord;
  late int countSpelling;
  late int pointer;
  late bool activateExample;
  late bool correctness;
  late SpellingController spellingController;
  late TextEditingController inputController;
  late TextEditingController exampleInputController;
  bool readOnlyWord = false;
  bool readOnlyExample = false;
  late bool isDialogShowing;

  @override
  void initState() {
    wordRecord = widget.word;
    inputController = TextEditingController();
    exampleInputController = TextEditingController();
    isDialogShowing = false;
    correctness = false;
    spellingController = SpellingController(
      onNewWordRecord: setNewWordRecord,
      readOnlyWord: setReadOnlyWord,
      readOnlyExample: setReadOnlyExample,
      foreignWord: wordRecord.foreignWord,
      examplesList: wordRecord.wordExamples,
      onListeningCount: setCounter,
      onExampleSateListening: setExamplesState,
      onPointerListening: setNewPointer,
      onCorrectness: setTextCorrectness,
    );
    final initialValues = spellingController.initializeControllerValues();

    countSpelling = initialValues.countSpelling;
    pointer = initialValues.pointer;
    activateExample = initialValues.activateExample;

    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    exampleInputController.dispose();

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
  void setReadOnlyWord(bool value) {
    readOnlyWord = value;
    value
        ? inputController.text = wordRecord.foreignWord
        : inputController.text = '';
  }

  void setReadOnlyExample(bool value) {
    readOnlyExample = value;
    value
        ? exampleInputController.text = wordRecord.wordExamples[pointer]
        : exampleInputController.text = '';
  }

  void setNewWordRecord(WordRecord newWordRecord) {
    setState(() {
      wordRecord = newWordRecord;
    });
  }

  @override
  Widget build(BuildContext context) {
    final WordRecord(:foreignWord, :wordImages, :wordMeans, :wordExamples) =
        wordRecord;

    final myMessage = MyMessages();
    final ThemeData(:textTheme, :colorScheme) = Theme.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.groupId != null) {
        popUpDialogGroup(context, myMessage, foreignWord, wordExamples);
      } else {
        popUpDialogSingle(context, myMessage, foreignWord, wordExamples);
      }
    });

    setStyleForCorrectness();
    return ResponsiveCenter(
        child: Scaffold(
      appBar: SpellingAppBar(
        spellingController: spellingController,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Column(
            children: [
              ImageView(imageList: wordImages),
              const SizedBox(
                height: 15,
              ),
              countSpelling > spellingController.stopWordPeaking ||
                      activateExample
                  ? WordView(
                      foreignWord: foreignWord,
                      means: wordMeans,
                      noVoiceIcon: true,
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 6,
                        child: TextField(
                          enableIMEPersonalizedLearning: false,
                          enableSuggestions: false,
                          autocorrect: false,
                          readOnly: readOnlyWord,
                          controller: inputController,
                          onChanged: (value) {
                            spellingController.comparingTexts(value);
                          },
                          style: textTheme.headlineMedium
                              ?.copyWith(color: colorScheme.outline),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: correctness || activateExample
                                ? const Color.fromARGB(255, 104, 198, 107)
                                : null,
                            labelStyle: textTheme.bodyLarge
                                ?.copyWith(color: colorScheme.outline),
                            label: const Text('Write it down'),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: colorScheme.onSurface),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                        )),
                    Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        shape: const CircleBorder(),
                        color: Colors.indigo[400],
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: !activateExample
                              ? Text(
                                  countSpelling.toString(),
                                  style: textTheme.labelLarge
                                      ?.copyWith(color: Colors.white),
                                )
                              : Text(
                                  0.toString(),
                                  style: textTheme.labelLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              activateExample
                  ? Column(children: [
                      countSpelling < spellingController.stopExamplesPeaking
                          ? Card(
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
                            )
                          : Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 5),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        wordExamples[pointer],
                                        style: textTheme.headlineLarge
                                            ?.copyWith(
                                                color: colorScheme.outline),
                                        softWrap: true,
                                        maxLines: 3,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ]),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 6,
                                child: TextField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  readOnly: readOnlyExample,
                                  controller: exampleInputController,
                                  onChanged: (value) =>
                                      spellingController.comparingTexts(value),
                                  style: textTheme.headlineMedium
                                      ?.copyWith(color: colorScheme.outline),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: correctness
                                        ? const Color.fromARGB(
                                            255, 104, 198, 107)
                                        : null,
                                    labelStyle: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onSurface),
                                    label: const Text('Write it down'),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: colorScheme.onSurface),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  // The validator receives the text that the user has entered.
                                )),
                            Card(
                                elevation: 5,
                                margin: const EdgeInsets.all(10),
                                shape: const CircleBorder(),
                                color: Colors.indigo[400],
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    countSpelling.toString(),
                                    style: textTheme.labelLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ])
                  : Container()
            ],
          ),
        ),
      ),
    ));
  }

  void setStyleForCorrectness() {
    if (mounted && correctness) {
      Future.delayed(
          Duration(seconds: spellingController.timeAfterCorrectSpell), () {
        if (mounted && correctness) {
          spellingController.resetTextFieldsAfterDelay();
        }
      });

      spellingController.updateTextFields(
        correctness,
      );
    }
  }

  void popUpDialogSingle(BuildContext context, MyMessages myMessage,
      String foreignWord, List<String> examplesList) {
    if (!isDialogShowing) {
      if (countSpelling == 0 && !activateExample) {
        isDialogShowing = true;

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogPractice(
                messages: myMessage.getPracticeMessage(
                  PracticeMessagesType.practiceSpelling,
                  foreignWord,
                ),
                reload: spellingController.resetting,
                activateExamples: spellingController.examplesActivation,
              );
            }).then((value) => isDialogShowing = false);
      } else if (countSpelling == 0 && activateExample) {
        if (pointer < examplesList.length - 1) {
          spellingController.moveToNextExamples();
        } else {
          isDialogShowing = true;
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogPractice(
                  messages: myMessage.getPracticeMessage(
                    PracticeMessagesType.practiceSpellingExampleComplete,
                    foreignWord,
                  ),
                  reload: spellingController.resetting,
                  activateExamples: spellingController.reactivateExample,
                );
              }).then((value) => isDialogShowing = false);
        }
      }
    }
  }

  void popUpDialogGroup(
    BuildContext context,
    MyMessages myMessage,
    String foreignWord,
    List<String> examplesList,
  ) {
    if (!isDialogShowing) {
      if (countSpelling == 0) {
        if (activateExample && pointer < examplesList.length - 1) {
          spellingController.moveToNextExamples();
        } else if (!activateExample) {
          isDialogShowing = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogPractice(
                messages: myMessage.getPracticeMessage(
                  PracticeMessagesType.practiceSpellingGroup,
                  foreignWord,
                ),
                reload: spellingController.isThereNextWord
                    ? spellingController.moveToNextWord
                    : null,
                activateExamples: spellingController.reactivateExample,
              );
            },
          ).then((value) => isDialogShowing = false);
        } else if (countSpelling == 0 &&
            activateExample &&
            spellingController.isThereNextWord) {
          spellingController.moveToNextWord();
          return;
        } else if (countSpelling == 0 && activateExample) {
          isDialogShowing = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogPractice(
                messages: myMessage.getPracticeMessage(
                  PracticeMessagesType.practiceSpellingExampleCompleteGroup,
                  foreignWord,
                ),
                reload: spellingController.resetting,
                activateExamples: spellingController.reactivateExample,
              );
            },
          ).then((value) => isDialogShowing = false);
        }
      }
    }
  }
}
