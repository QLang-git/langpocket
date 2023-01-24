import 'package:flutter/material.dart';
import 'package:langpocket/src/screens/new_word/utils/form/fields/example_word.dart';
import 'package:langpocket/src/screens/new_word/utils/form/fields/foreign_word.dart';
import 'package:langpocket/src/screens/new_word/utils/form/fields/mean_word.dart';
import 'package:langpocket/src/screens/new_word/utils/form/fields/notes_word.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class NewWordForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const NewWordForm({super.key, required this.formKey});

  @override
  NewWordFormState createState() {
    return NewWordFormState();
  }
}

class NewWordFormState extends State<NewWordForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              ForeignWord(),
              Expanded(flex: 1, child: Icon(Icons.compare_arrows_outlined)),
              MeanWord(),
            ],
          ),
          //! button to add new meaning for the word
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 270,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: const CircleBorder(),
                ),
                child: const Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),
          //! EXAMLES
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '+ Add examples',
                style: headline2Bold(primaryFontColor),
              ),
            ),
          ),
          //! Examples field
          const ExampleWord(exampleNumber: 1),
          const ExampleWord(exampleNumber: 2),
          const ExampleWord(exampleNumber: 3),
          //! add new examples
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: buttonColor,
              shape: const CircleBorder(),
            ),
            child: const Icon(
              Icons.add,
              size: 50,
              color: Colors.white,
            ),
            onPressed: () {},
          ),

          const NotesWord()
        ],
      ),
    );
  }
}
