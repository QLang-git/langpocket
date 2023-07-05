import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/word_edit/screen/edit_mode_word_screen.dart';
import 'package:text_to_speech/text_to_speech.dart';

class EditForeignWord extends StatefulWidget {
  final String currentForeignWord;
  const EditForeignWord({
    Key? key,
    required this.currentForeignWord,
  }) : super(key: key);

  @override
  State<EditForeignWord> createState() => _EditForeignWordState();
}

class _EditForeignWordState extends State<EditForeignWord> {
  TextToSpeech tts = TextToSpeech();
  late TextEditingController inputController;
  String? inputText;
  @override
  void initState() {
    inputText = widget.currentForeignWord;
    inputController = TextEditingController(text: widget.currentForeignWord);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final states = context.findAncestorStateOfType<EditModeWordScreenState>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Consumer(builder: (context, ref, child) {
        return TextFormField(
          controller: inputController,
          onChanged: (value) {
            inputText = value;
            states.updateForeignWord(value);
          },
          style: textStyle.displayMedium?.copyWith(color: colorStyle.outline),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            labelStyle:
                textStyle.bodyLarge?.copyWith(color: colorStyle.outline),
            label: const Text('Word'),
            suffixIcon: TextButton(
              child: Icon(
                Icons.volume_up_outlined,
                color: colorStyle.outline,
              ),
              onPressed: () {
                if (inputText != null) {
                  tts.speak(inputText!);
                }
              },
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: colorStyle.onSurface),
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
              states.updateForeignWord(value);
              return null;
            }
          },
        );
      }),
    );
  }
}
