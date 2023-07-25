import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/features/new_word/controller/validation_input.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class NotesWord extends StatefulWidget {
  const NotesWord({super.key});

  @override
  State<NotesWord> createState() => _NotesWordState();
}

class _NotesWordState extends State<NotesWord> {
  final validate = ValidationInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Consumer(
        builder: (context, ref, child) {
          return Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              return TextFormField(
                key: const Key('NotesWord'),
                style: headline3(primaryFontColor),
                maxLines: 5,
                decoration: InputDecoration(
                  labelStyle: bodyLarge(primaryColor),
                  hintText: 'write some notes for your new words optional',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: secondaryColor),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  final (:status, :message) =
                      validate.notesWordsValidation(value ?? '');
                  if (!status) {
                    return message;
                  }
                  ref
                      .read(newWordControllerProvider.notifier)
                      .saveWordNote(value!);
                },
              );
            },
          );
        },
      ),
    );
  }
}
