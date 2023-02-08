import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/fields/edit_example_word.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/fields/edit_foreign_word.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/fields/mean_word.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/fields/notes_word.dart';

class EditWordForm extends ConsumerStatefulWidget {
  final List<String> imageList;
  final String foreignWord;
  final List<String> means;
  final List<String> examples;
  final String note;
  final GlobalKey<FormState> formKey;
  const EditWordForm(
      {required this.imageList,
      required this.foreignWord,
      required this.means,
      required this.examples,
      required this.note,
      super.key,
      required this.formKey});

  @override
  EditWordFormState createState() {
    return EditWordFormState();
  }
}

class EditWordFormState extends ConsumerState<EditWordForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditForeignWord(
                currentForeignWord: widget.foreignWord,
              ),
              const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Icon(Icons.compare_arrows_outlined),
                  )),
              Expanded(
                flex: 6,
                child: EditMeanWord(
                  curentMeans: widget.means,
                ),
              )
            ],
          ),
          EditExampleWord(
            currentExamples: widget.examples,
          ),
          const SizedBox(height: 15),
          EditNotesWord(currentNote: widget.note)
        ],
      ),
    );
  }
}
