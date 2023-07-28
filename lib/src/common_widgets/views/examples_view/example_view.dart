import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ExampleView extends StatelessWidget {
  final String example;
  final bool noVoiceIcon;
  const ExampleView(
      {super.key, required this.example, this.noVoiceIcon = false});

  @override
  Widget build(BuildContext context) {
    final colorFount = Theme.of(context).colorScheme.outline;
    final textStyle = Theme.of(context).textTheme;
    TextToSpeech tts = TextToSpeech();
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const SizedBox(width: 15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              example,
              style: textStyle.displayLarge?.copyWith(color: colorFount),
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        TextButton(
          onPressed: noVoiceIcon
              ? null
              : () {
                  tts.speak(example);
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: noVoiceIcon
                ? Icon(
                    Icons.edit_note_outlined,
                    color: colorFount,
                    size: 30,
                  )
                : Icon(
                    Icons.volume_up_outlined,
                    color: colorFount,
                    size: 30,
                  ),
          ),
        ),
      ]),
    );
  }
}
