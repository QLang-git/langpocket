import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/screens/word_edit/app_bar/word_editor_app_bar.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/edit_word_form.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_word_image/edit_word_image.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class EditModeWordScreen extends StatefulWidget {
  final WordData wordData;

  const EditModeWordScreen({super.key, required this.wordData});

  @override
  State<EditModeWordScreen> createState() => EditModeWordScreenState();
}

class EditModeWordScreenState extends State<EditModeWordScreen> {
  final formKey = GlobalKey<FormState>();
  List<String> updatedWordMeans = List.filled(6, '');
  List<String> updatedWordImages = ['', ''];
  List<String> updatedWordExample = List.filled(6, '');
  String updatedWordNote = '';
  String updatedforeignWord = '';

  void updateWordMeans(String means, int targetIndex) {
    setState(() {
      updatedWordMeans[targetIndex] = means;
    });
  }

  void updateWordExample(String example, int targetIndex) {
    setState(() {
      updatedWordExample[targetIndex] = example;
    });
  }

  void updateWordImages(List<String> images) {
    setState(() {
      updatedWordImages = images;
    });
  }

  void updateForeignWord(String word) {
    setState(() {
      updatedforeignWord = word;
    });
  }

  void updateNote(String note) {
    setState(() {
      updatedWordNote = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
        child: Scaffold(
            appBar: WordEditorAppbar(
              imageList: widget.wordData.imagesList(),
              foreignWord: widget.wordData.foreignWord,
              means: widget.wordData.meansList(),
              examples: widget.wordData.examplesList(),
              note: widget.wordData.wordNote,
              formKey: formKey,
            ),
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    EditWordImage(currentImages: widget.wordData.imagesList()),
                    const SizedBox(
                      height: 40,
                    ),
                    EditWordForm(
                      imageList: widget.wordData.imagesList(),
                      foreignWord: widget.wordData.foreignWord,
                      means: widget.wordData.meansList(),
                      examples: widget.wordData.examplesList(),
                      note: widget.wordData.wordNote,
                      formKey: formKey,
                    )
                  ],
                ),
              ),
            )));
  }
}
