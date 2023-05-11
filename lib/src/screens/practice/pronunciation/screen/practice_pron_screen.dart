import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/practice/pronunciation/app_bar/pron_appbar.dart';
import 'package:langpocket/src/screens/practice/pronunciation/controllers/microphone_controller.dart';
import 'package:langpocket/src/screens/practice/pronunciation/widgets/microphone_button.dart';
import 'package:text_to_speech/text_to_speech.dart';

class PracticePronScreen extends StatefulWidget {
  final List<Uint8List> imageList;
  final String foreignWord;
  final List<String> meanList;
  final List<String> examplesList;
  const PracticePronScreen(
      {super.key,
      required this.imageList,
      required this.foreignWord,
      required this.meanList,
      required this.examplesList});

  @override
  State<PracticePronScreen> createState() => _PracticePronScreenState();
}

class _PracticePronScreenState extends State<PracticePronScreen> {
  late int countPron;
  late bool correct;
  late List<bool> correctExample;
  late List<int> examplePronCount;
  late int pointer;
  late bool example;
  late TextToSpeech tts;
  String message = "Hold to Start Recording ...";

  @override
  void initState() {
    tts = TextToSpeech();
    countPron = 3;
    pointer = 0;
    examplePronCount = List.filled(widget.examplesList.length, 3);
    correctExample = List.filled(widget.examplesList.length, false);
    correct = false;
    example = false;
    super.initState();
  }

  void setUserMessage(String status) {
    if (status == "notListening") {
      setState(() {
        message = "Unable to detect your voice";
      });
    } else if (status == "listening") {
      setState(() {
        message = "Analyzing your pronunciation...";
      });
    } else {
      setState(() {
        message = "Hold to Restart Recording ...";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return ResponsiveCenter(
        child: Scaffold(
      appBar: const PronAppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Stack(children: [
              Column(
                children: [
                  ImageView(imageList: widget.imageList),
                  const SizedBox(
                    height: 15,
                  ),
                  countPron > 2
                      ? WordView(
                          foreignWord: widget.foreignWord,
                          means: widget.meanList,
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
                ],
              ),
            ])),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                padding: const EdgeInsets.all(7),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message,
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
                const SizedBox(width: 100),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer(
                    builder: (context, ref, child) => MicrophoneButton(
                      controller: MicrophoneController(
                          ref: ref,
                          onRecordStart: () {
                            print('starting ....');
                          },
                          onRecordStop: () {
                            print('stopping....');
                          },
                          onListening: (status) {
                            print('listening....$status');
                            setUserMessage(status);
                          }),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    shape: const CircleBorder(),
                    color: Colors.indigo[400],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '3',
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
    ));
  }
}
