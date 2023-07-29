import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/features/new_word/controller/validation_input.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class NotesWord extends ConsumerStatefulWidget {
  final String? note;
  const NotesWord({super.key, this.note});

  @override
  ConsumerState<NotesWord> createState() => _NotesWordState();
}

class _NotesWordState extends ConsumerState<NotesWord> {
  final inputController = TextEditingController();

  final validate = ValidationInput();
  @override
  void initState() {
    inputController.text = widget.note ?? '';
    if (widget.note != null) {
      Future.delayed(Duration.zero, () {
        ref.read(newWordControllerProvider.notifier).saveWordNote(widget.note!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: TextFormField(
        controller: inputController,
        onChanged: (value) {
          if (widget.note != null) {
            ref
                .read(newWordControllerProvider.notifier)
                .saveWordNote(inputController.text);
          }
        },
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
          ref.read(newWordControllerProvider.notifier).saveWordNote(value!);
          return null;
        },
      ),
    );
  }
}
