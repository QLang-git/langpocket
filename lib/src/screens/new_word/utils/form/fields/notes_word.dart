import 'package:flutter/material.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class NotesWord extends StatefulWidget {
  const NotesWord({super.key});

  @override
  State<NotesWord> createState() => _NotesWordState();
}

class _NotesWordState extends State<NotesWord> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: TextFormField(
        style: headline3(primaryFontColor),
        maxLines: 5,
        decoration: InputDecoration(
          labelStyle: bodyLarge(primaryColor),
          hintText: 'write some notes for your new words ( optional )',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: secondaryColor),
            borderRadius: BorderRadius.circular(20.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
