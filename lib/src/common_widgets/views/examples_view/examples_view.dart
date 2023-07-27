import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ExamplesView extends StatelessWidget {
  final List<String> examples;
  const ExamplesView({super.key, required this.examples});

  @override
  Widget build(BuildContext context) {
    final colorFount = Theme.of(context).colorScheme.outline;
    final textStyle = Theme.of(context).textTheme;
    TextToSpeech tts = TextToSpeech();
    return Column(
      children: examples
          .where((element) => element.isNotEmpty)
          .map((example) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 15),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              example,
                              style: textStyle.displayLarge
                                  ?.copyWith(color: colorFount),
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        TextButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 9),
                            child: Icon(
                              Icons.volume_up_outlined,
                              color: colorFount,
                              size: 30,
                            ),
                          ),
                          onPressed: () {
                            tts.speak(example);
                          },
                        ),
                      ]),
                ),
              ))
          .toList(),
    );
  }
}
