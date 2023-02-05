import 'package:flutter/material.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ExamplesView extends StatelessWidget {
  final List<String> examples;
  const ExamplesView({super.key, required this.examples});

  @override
  Widget build(BuildContext context) {
    TextToSpeech tts = TextToSpeech();
    return Column(
      children: examples
          .where((element) => element.isNotEmpty && element != 'notUsed')
          .map((example) => Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          example,
                          style: headline3Bold(primaryFontColor),
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Icon(
                            Icons.volume_up_outlined,
                            color: primaryColor,
                          ),
                        ),
                        onPressed: () {
                          tts.speak(example);
                        },
                      ),
                    ]),
              ))
          .toList(),
    );
  }
}
