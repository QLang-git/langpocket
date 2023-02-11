import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/word_edit/app_bar/word_editor_app_bar.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_form/edit_word_form.dart';
import 'package:langpocket/src/screens/word_edit/widgets/edit_word_image/edit_word_image.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class EditModeWordScreen extends StatefulWidget {
  final String wordId;
  final List<String> imageList;
  final String foreignWord;
  final List<String> means;
  final List<String> examples;
  final String note;
  const EditModeWordScreen(
      {super.key,
      required this.imageList,
      required this.foreignWord,
      required this.means,
      required this.examples,
      required this.note,
      required this.wordId});

  @override
  State<EditModeWordScreen> createState() => EditModeWordScreenState();
}

class EditModeWordScreenState extends State<EditModeWordScreen> {
  final formKey = GlobalKey<FormState>();
  List<String> updatedWordMeans = List.filled(6, '');
  List<String> updatedWordImages = [];
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

  void changeExampleListTo(List<String> examples) {
    setState(() {
      updatedWordExample = examples;
    });
  }

  void changeMeaningListTo(List<String> means) {
    setState(() {
      updatedWordMeans = means;
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
              imageList: widget.imageList,
              foreignWord: widget.foreignWord,
              means: widget.means,
              examples: widget.examples,
              note: widget.note,
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
                    EditWordImage(currentImages: widget.imageList),
                    const SizedBox(
                      height: 40,
                    ),
                    EditWordForm(
                      imageList: widget.imageList,
                      foreignWord: widget.foreignWord,
                      means: widget.means,
                      examples: widget.examples,
                      note: widget.note,
                      formKey: formKey,
                    )
                  ],
                ),
              ),
            )));
  }
}
