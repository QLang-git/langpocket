import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/word_edit/screen/edit_mode_word_screen.dart';

class EditNotesWord extends StatefulWidget {
  final String currentNote;
  const EditNotesWord({super.key, required this.currentNote});

  @override
  State<EditNotesWord> createState() => _EditNotesWordState();
}

class _EditNotesWordState extends State<EditNotesWord> {
  late TextEditingController inputController;

  @override
  void initState() {
    inputController = TextEditingController(text: widget.currentNote);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final states = context.findAncestorStateOfType<EditModeWordScreenState>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Consumer(
        builder: (context, ref, child) {
          return TextFormField(
            controller: inputController,
            onChanged: (value) {
              states.updateNote(value);
            },
            style: textStyle.displayMedium?.copyWith(color: colorStyle.outline),
            maxLines: 5,
            decoration: InputDecoration(
              labelStyle:
                  textStyle.bodyLarge?.copyWith(color: colorStyle.outline),
              hintText: 'write some notes for your new words optional',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: colorStyle.onSurface),
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
