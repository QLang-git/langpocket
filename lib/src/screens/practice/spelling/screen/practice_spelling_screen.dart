import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/practice/spelling/app_bar/spelling_appbar.dart';
import 'package:langpocket/src/common_widgets/custom_dialog_practice.dart';
import 'package:langpocket/src/screens/practice/spelling/controller/spelling_controller.dart';
import 'package:langpocket/src/utils/constants/messages.dart';
import 'package:ionicons/ionicons.dart';

class PracticeSpellingScreen extends StatefulWidget {
  final List<Uint8List> imageList;
  final String foreignWord;
  final List<String> meanList;
  final List<String> examplesList;
  const PracticeSpellingScreen(
      {super.key,
      required this.imageList,
      required this.foreignWord,
      required this.meanList,
      required this.examplesList});

  @override
  State<PracticeSpellingScreen> createState() => PracticeSpellingScreenState();
}

class PracticeSpellingScreenState extends State<PracticeSpellingScreen> {
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
    inputController = TextEditingController();
    exampleInputController = TextEditingController();
    isDialogShowing = false;
    correctness = false;
    spellingController = SpellingController(
      readOnlyWord: setReadOnlyWord,
      readOnlyExample: setReadOnlyExample,
      foreignWord: widget.foreignWord,
      examplesList: widget.examplesList,
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
        ? inputController.text = widget.foreignWord
        : inputController.text = '';
  }

  void setReadOnlyExample(bool value) {
    readOnlyExample = value;
    value
        ? exampleInputController.text = widget.examplesList[pointer]
        : exampleInputController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final myMessage = MyMessages();
    final ThemeData(:textTheme, :colorScheme) = Theme.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      popUpDialog(context, myMessage);
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
              ImageView(imageList: widget.imageList),
              const SizedBox(
                height: 15,
              ),
              countSpelling > spellingController.stopWordPeaking ||
                      activateExample
                  ? WordView(
                      foreignWord: widget.foreignWord,
                      means: widget.meanList,
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
                                        widget.examplesList[pointer],
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

  void popUpDialog(BuildContext context, MyMessages myMessage) {
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
                  widget.foreignWord,
                ),
                reload: spellingController.resetting,
                activateExamples: spellingController.examplesActivation,
              );
            }).then((value) => isDialogShowing = false);
      } else if (countSpelling == 0 && activateExample) {
        if (pointer < widget.examplesList.length - 1) {
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
                    widget.foreignWord,
                  ),
                  reload: spellingController.resetting,
                  activateExamples: spellingController.reactivateExample,
                );
              }).then((value) => isDialogShowing = false);
        }
      }
    }
  }
}
