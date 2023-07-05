import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/widgets/form/fields/example_word.dart';
import 'package:langpocket/src/screens/new_word/widgets/form/fields/foreign_word.dart';
import 'package:langpocket/src/screens/new_word/widgets/form/fields/mean_word.dart';
import 'package:langpocket/src/screens/new_word/widgets/form/fields/notes_word.dart';

class NewWordForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  const NewWordForm({super.key, required this.formKey});

  @override
  NewWordFormState createState() {
    return NewWordFormState();
  }
}

class NewWordFormState extends ConsumerState<NewWordForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: const Column(
        children: [
          ForeignWord(),
          RotatedBox(
            quarterTurns: 5,
            child: Icon(Icons.compare_arrows_outlined),
          ),
          MeanWord(),
          ExampleWord(),
          SizedBox(height: 15),
          NotesWord()
        ],
      ),
    );
  }
}
