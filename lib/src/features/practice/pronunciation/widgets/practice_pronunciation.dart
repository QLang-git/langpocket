import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/example_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Stack(children: [
          Column(
            children: [
              ImageView(imageList: wordImages),
              const SizedBox(
                height: 15,
              ),
              countPron > 2 || activateExample
                  ? WordView(
                      foreignWord: foreignWord,
                      means: wordMeans,
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
              activateExample
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25),
                          child: Divider(
                            height: 20,
                          ),
                        ),
                        ExampleView(example: wordExamples[examplePinter])
                      ],
                    )
                  : Container()
            ],
          ),
        ]));
  }
}
