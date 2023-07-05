import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ExampleView extends StatelessWidget {
  final String example;
  const ExampleView({super.key, required this.example});

  @override
  Widget build(BuildContext context) {
    final colorFount = Theme.of(context).colorScheme.outline;
    final textStyle = Theme.of(context).textTheme;
    TextToSpeech tts = TextToSpeech();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        margin: const EdgeInsets.all(10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              example,
              style: textStyle.displayLarge?.copyWith(color: colorFount),
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.fade,
            ),
          ),
          TextButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
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
    );
  }
}
