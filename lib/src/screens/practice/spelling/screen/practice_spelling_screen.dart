import 'dart:async';

import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/practice/spelling/app_bar/spelling_appbar.dart';
import 'package:langpocket/src/screens/practice/spelling/widgets/custom_dialog_spelling.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:text_to_speech/text_to_speech.dart';

class PracticeSpellingScreen extends StatefulWidget {
  final List<String> imageList;
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
  String? inputText;
  late int countSpelling;
  late bool correct;
  late List<bool> courectExample;
  late List<int> exampleSpellingCount;
  late int pointer;
  late bool example;

  @override
  void initState() {
    countSpelling = 5;
    pointer = 0;
    exampleSpellingCount = List.filled(widget.examplesList.length, 3);
    courectExample = List.filled(widget.examplesList.length, false);
    correct = false;
    example = false;

    super.initState();
  }

  void reloadPage() {
    setState(() {
      countSpelling = 5;
      correct = false;
      example = false;
      exampleSpellingCount = List.filled(widget.examplesList.length, 3);
      courectExample = List.filled(widget.examplesList.length, false);
      pointer = 0;
    });
  }

  void activateExamples() {
    setState(() {
      example = true;
    });
  }

  void reactivateExamples() {
    setState(() {
      example = true;
      pointer = 0;
      exampleSpellingCount = List.filled(widget.examplesList.length, 3);
      courectExample = List.filled(widget.examplesList.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextToSpeech tts = TextToSpeech();
    final inputController = TextEditingController();
    final exampleInputController = TextEditingController();
    if (correct) inputController.text = widget.foreignWord;
    if (courectExample[pointer]) {
      exampleInputController.text = widget.examplesList[pointer];
    }
    if (exampleSpellingCount[pointer] == 0 &&
        pointer != widget.examplesList.length - 1) {
      pointer += 1;
    }

    if (countSpelling == 0) {
      inputController.text = widget.foreignWord;
      correct = true;
    }
    if (exampleSpellingCount[pointer] == 0 && courectExample[pointer] == true) {
      exampleInputController.text = widget.examplesList[pointer];
    }

    return ResponsiveCenter(
        child: Scaffold(
      appBar: const SpellingAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Column(
            children: [
              ImageView(imageList: widget.imageList),
              const SizedBox(
                height: 15,
              ),
              countSpelling > 3
                  ? WordView(
                      foreignWord: widget.foreignWord,
                      means: widget.meanList,
                      noVoice: true,
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
                              Icons.swap_horizontal_circle_rounded,
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
                          enableInteractiveSelection: false,
                          enableSuggestions: false,
                          autocorrect: false,
                          readOnly: correct,
                          controller: inputController,
                          onChanged: (value) => {
                            if (value.toLowerCase().trim() ==
                                    widget.foreignWord &&
                                countSpelling > 0)
                              {
                                setState(() {
                                  correct = true;
                                }),
                                tts.speak(value),
                                Timer(const Duration(seconds: 2), () {
                                  setState(() {
                                    correct = false;
                                    countSpelling -= 1;
                                  });
                                })
                              },
                            if (countSpelling == 1 &&
                                value.toLowerCase().trim() ==
                                    widget.foreignWord)
                              {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return CustomDialogSpelling(
                                        enableExamples: activateExamples,
                                        reload: reloadPage,
                                        message:
                                            'You wrote " $value " 5 times correctly.\nKeep practicing  spelling several times for better results.',
                                        withExampleButton:
                                            'Spell this word with sentences ',
                                      );
                                    })
                              }
                          },
                          style: headline3(primaryFontColor),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: correct
                                ? const Color.fromARGB(255, 104, 198, 107)
                                : null,
                            labelStyle: bodyLarge(primaryColor),
                            label: const Text('Write it down'),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: secondaryColor),
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
                            style: bodySmallBold(Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              example
                  ? Column(children: [
                      exampleSpellingCount[pointer] < 3
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
                                      Icons.swap_horizontal_circle_rounded,
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
                                        style: headline2Bold(primaryFontColor),
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
                                  readOnly: courectExample[pointer],
                                  controller: exampleInputController,
                                  onChanged: (value) => {
                                    if (value
                                                .toLowerCase()
                                                .trim()
                                                .replaceAll('  ', '') ==
                                            widget.examplesList[pointer] &&
                                        exampleSpellingCount[pointer] > 0)
                                      {
                                        setState(() {
                                          courectExample[pointer] = true;
                                        }),
                                        tts.speak(value),
                                        Timer(const Duration(seconds: 2), () {
                                          setState(() {
                                            courectExample[
                                                pointer] = (pointer ==
                                                    widget.examplesList.length -
                                                        1 &&
                                                exampleSpellingCount[pointer] ==
                                                    1);
                                            exampleSpellingCount[pointer] -= 1;
                                          });
                                        })
                                      },
                                    if (exampleSpellingCount[
                                                widget.examplesList.length -
                                                    1] ==
                                            1 &&
                                        value
                                                .toLowerCase()
                                                .trim()
                                                .replaceAll('  ', '') ==
                                            widget.examplesList[pointer])
                                      {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return CustomDialogSpelling(
                                                enableExamples:
                                                    reactivateExamples,
                                                reload: reloadPage,
                                                message:
                                                    'You\'ve completed your spelling practice for the word examples also .\nKeep going...',
                                                withExampleButton:
                                                    'Spell with sentences again ',
                                              );
                                            })
                                      }
                                  },
                                  style: headline3(primaryFontColor),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: courectExample[pointer]
                                        ? const Color.fromARGB(
                                            255, 104, 198, 107)
                                        : null,
                                    labelStyle: bodyLarge(primaryColor),
                                    label: const Text('Write it down'),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: secondaryColor),
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
                                    exampleSpellingCount[pointer].toString(),
                                    style: bodySmallBold(Colors.white),
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
}
