import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/presntation/utils/form/fields/example_word.dart';
import 'package:langpocket/src/screens/new_word/presntation/utils/form/fields/foreign_word.dart';
import 'package:langpocket/src/screens/new_word/presntation/utils/form/fields/mean_word.dart';
import 'package:langpocket/src/screens/new_word/presntation/utils/form/fields/notes_word.dart';

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
    // Build a Form widget using the _formKey created above.

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ForeignWord(),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Icon(Icons.compare_arrows_outlined),
                  )),
              Expanded(
                flex: 6,
                child: MeanWord(),
              )
            ],
          ),
          const ExampleWord(),
          const SizedBox(height: 15),
          const NotesWord()
        ],
      ),
    );
  }
}
