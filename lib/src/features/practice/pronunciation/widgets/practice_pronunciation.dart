import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/example_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/data/modules/word_module.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_controller.dart';

class PracticePronunciation<T extends MicStateBase> extends StatelessWidget {
  final WordRecord wordRecord;
  final T micState;
  const PracticePronunciation(
      {super.key, required this.wordRecord, required this.micState});
  @override
  Widget build(BuildContext context) {
    final WordRecord(
      :wordImages,
      :foreignWord,
      :wordExamples,
      :wordMeans,
    ) = wordRecord;
    final T(:activateExample, :examplePinter, :countPron) = micState;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ImageView(imageList: wordImages, meanings: wordMeans),
                const SizedBox(
                  height: 15,
                ),
                countPron > 2 || activateExample
                    ? WordView(
                        foreignWord: foreignWord,
                        means: wordMeans,
                      )
                    : Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 0,
                        ),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                              width: double.infinity,
                              child: Icon(
                                Ionicons.eye_off,
                                size: 30,
                              )),
                        ),
                      ),
                activateExample
                    ? Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Divider(
                              height: 20,
                            ),
                          ),
                          countPron > 1
                              ? ExampleView(
                                  example: wordExamples[examplePinter])
                              : Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: SizedBox(
                                        width: double.infinity,
                                        child: Icon(
                                          Ionicons.eye_off,
                                          size: 30,
                                        )),
                                  ),
                                )
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ]));
  }
}
