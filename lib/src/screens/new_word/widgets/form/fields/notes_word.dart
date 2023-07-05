import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class NotesWord extends StatefulWidget {
  const NotesWord({super.key});

  @override
  State<NotesWord> createState() => _NotesWordState();
}

class _NotesWordState extends State<NotesWord> {
  @override
  Widget build(BuildContext context) {
    final states = context.findAncestorStateOfType<NewWordScreenState>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Consumer(
        builder: (context, ref, child) {
          return TextFormField(
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
                states.setNote(value);
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
