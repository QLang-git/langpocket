import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/word_edit/screen/edit_mode_word_screen.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class EditNotesWord extends StatefulWidget {
  final String currentNote;
  const EditNotesWord({super.key, required this.currentNote});

  @override
  State<EditNotesWord> createState() => _EditNotesWordState();
}

class _EditNotesWordState extends State<EditNotesWord> {
  @override
  Widget build(BuildContext context) {
    final states = context.findAncestorStateOfType<EditModeWordScreenState>()!;
    final inputController = TextEditingController(text: widget.currentNote);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Consumer(
        builder: (context, ref, child) {
          return TextFormField(
            controller: inputController,
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
              if (value != null) {
                states.updateNote(value);
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
