import 'package:flutter/material.dart';
import 'package:langpocket/src/data/modules/word_module.dart';
import 'package:langpocket/src/features/new_word/widgets/form/fields/example_word.dart';
import 'package:langpocket/src/features/new_word/widgets/form/fields/foreign_word.dart';
import 'package:langpocket/src/features/new_word/widgets/form/fields/mean_word.dart';
import 'package:langpocket/src/features/new_word/widgets/form/fields/notes_word.dart';

class NewWordForm extends StatefulWidget {
  final WordRecord? wordRecord;
  final GlobalKey<FormState> formKey;
  const NewWordForm({super.key, required this.formKey, this.wordRecord});

  @override
  NewWordFormState createState() {
    return NewWordFormState();
  }
}

class NewWordFormState extends State<NewWordForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          ForeignWord(foreignWord: widget.wordRecord?.foreignWord),
          const RotatedBox(
            quarterTurns: 5,
            child: Icon(Icons.compare_arrows_outlined),
          ),
          MeanWord(wordMeans: widget.wordRecord?.wordMeans),
          ExampleWord(
            examples: widget.wordRecord?.wordExamples,
          ),
          const SizedBox(height: 15),
          NotesWord(note: widget.wordRecord?.wordNote)
        ],
      ),
    );
  }
}
