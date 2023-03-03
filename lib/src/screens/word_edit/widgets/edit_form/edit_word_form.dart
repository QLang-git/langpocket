import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/fields/edit_example_word.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/fields/edit_foreign_word.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/fields/mean_word.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/fields/notes_word.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class EditWordForm extends ConsumerStatefulWidget {
  final Word wordDataToView;
  final GlobalKey<FormState> formKey;
  const EditWordForm({
    required this.wordDataToView,
    required this.formKey,
    super.key,
  });

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
                currentForeignWord: widget.wordDataToView.foreignWord,
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
                  curentMeans: widget.wordDataToView.wordMeans,
                ),
              )
            ],
          ),
          EditExampleWord(
            currentExamples: widget.wordDataToView.wordExamples,
          ),
          const SizedBox(height: 15),
          EditNotesWord(currentNote: widget.wordDataToView.wordNote)
        ],
      ),
    );
  }
}
