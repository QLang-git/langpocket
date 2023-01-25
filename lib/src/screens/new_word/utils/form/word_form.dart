import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/utils/form/fields/example_word.dart';
import 'package:langpocket/src/screens/new_word/utils/form/fields/foreign_word.dart';
import 'package:langpocket/src/screens/new_word/utils/form/fields/mean_word.dart';
import 'package:langpocket/src/screens/new_word/utils/form/fields/notes_word.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/global_states.dart';

class NewWordForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  const NewWordForm({super.key, required this.formKey});

  @override
  NewWordFormState createState() {
    return NewWordFormState();
  }
}

class NewWordFormState extends ConsumerState<NewWordForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    final numberOfMeaning = ref.watch(numberOfMeaningProvider);
    final numberOfExamplse = ref.watch(numberOfExamplesProvider);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ForeignWord(),
              const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Icon(Icons.compare_arrows_outlined),
                  )),
              Expanded(
                flex: 6,
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: MeanWord(isAdditional: false),
                  ),
                  for (int i = 0; i < numberOfMeaning; i++) ...[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: MeanWord(isAdditional: true),
                    ),
                  ],
                  //! button to add new meaning for the word
                  if (numberOfMeaning < 3)
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: const CircleBorder(),
                      ),
                      onPressed: numberOfMeaning < 3
                          ? () {
                              setState(() {
                                ref
                                    .read(numberOfMeaningProvider.notifier)
                                    .state += 1;
                              });
                            }
                          : null,
                      child: const Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                ]),
              )
            ],
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
          for (int i = 3; i < numberOfExamplse; i++) ...[
            ExampleWord(exampleNumber: i)
          ],

          //! add new examples

          if (numberOfExamplse < 6)
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
              onPressed: () =>
                  ref.read(numberOfExamplesProvider.notifier).state += 1,
            ),

          const NotesWord()
        ],
      ),
    );
  }
}
