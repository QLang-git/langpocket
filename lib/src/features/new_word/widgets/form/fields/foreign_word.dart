import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/features/new_word/controller/validation_input.dart';
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
  final validate = ValidationInput();

  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Consumer(builder: (context, ref, child) {
        return TextFormField(
          key: const Key('ForeignWord'),
          controller: inputController,
          onChanged: (value) => inputText = value,
          style: headline3(primaryFontColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            labelStyle: bodyLarge(primaryColor),
            label: const Text('Word'),
            suffixIcon: TextButton(
              child: Icon(
                Icons.volume_up_outlined,
                color: primaryColor,
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
            final (:status, :message) = validate.foreignWordValidation(value);
            if (!status) {
              return message;
            } else {
              ref
                  .read(newWordControllerProvider.notifier)
                  .saveForeignWord(value!);
              return null;
            }
          },
        );
      }),
    );
  }
}
