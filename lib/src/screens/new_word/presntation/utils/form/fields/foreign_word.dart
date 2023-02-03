import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/presntation/new_word_screen.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ForeignWord extends StatefulWidget {
  const ForeignWord({
    Key? key,
  }) : super(key: key);

  @override
  State<ForeignWord> createState() => _ForeignWordState();
}

class _ForeignWordState extends State<ForeignWord> {
  TextToSpeech tts = TextToSpeech();
  String? inputText;
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final states = context.findAncestorStateOfType<NewWordScreenState>()!;
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Consumer(builder: (context, ref, child) {
          return TextFormField(
            controller: inputController,
            onChanged: (value) => inputText = value,
            style: headline3(primaryFontColor),
            decoration: InputDecoration(
              labelStyle: bodyLarge(primaryColor),
              label: const Text('Word'),
              suffixIcon: TextButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Icon(
                    Icons.volume_up_outlined,
                    color: primaryColor,
                  ),
                ),
                onPressed: () {
                  if (inputText != null) {
                    tts.speak(inputText!);
                  }
                },
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: secondaryColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the word';
              } else {
                states.setForeignWord(value);
                return null;
              }
            },
          );
        }),
      ),
    );
  }
}
