import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/word_edit/app_bar/word_editor_app_bar.dart';
import 'package:langpocket/src/features/word_edit/widgets/edit_form/edit_word_form.dart';
import 'package:langpocket/src/features/word_edit/widgets/edit_word_image/edit_word_image.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class EditModeWordScreen extends StatefulWidget {
  final WordRecord wordData;

  const EditModeWordScreen({super.key, required this.wordData});

  @override
  State<EditModeWordScreen> createState() => EditModeWordScreenState();
}

class EditModeWordScreenState extends State<EditModeWordScreen> {
  final formKey = GlobalKey<FormState>();
  late String newforeignWord;
  late List<String> newMeans;
  late List<Uint8List> newImages;
  late List<String> newExample;
  late String newNote;
  @override
  void initState() {
    newforeignWord = widget.wordData.foreignWord;
    newMeans = [
      ...widget.wordData.wordMeans,
      ...List.filled(6 - widget.wordData.wordMeans.length, '')
    ];
    newImages = widget.wordData.wordImages;
    newExample = [
      ...widget.wordData.wordExamples,
      ...List.filled(6 - widget.wordData.wordExamples.length, '')
    ];
    newNote = widget.wordData.wordNote;
    super.initState();
  }

  void updateWordMeans(String means, int targetIndex) {
    setState(() {
      newMeans[targetIndex] = means;
    });
  }

  void updateWordExample(String example, int targetIndex) {
    setState(() {
      newExample[targetIndex] = example;
    });
  }

  void updateWordImages(List<Uint8List> images) {
    setState(() {
      newImages = images;
    });
  }

  void updateForeignWord(String word) {
    setState(() {
      newforeignWord = word;
    });
  }

  void updateNote(String note) {
    setState(() {
      newNote = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorStyle = Theme.of(context).colorScheme;

    return ResponsiveCenter(
        child: Scaffold(
            appBar: WordEditorAppbar(
              wordData: widget.wordData,
              formKey: formKey,
            ),
            backgroundColor: colorStyle.background,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 19.5),
                child: Column(
                  children: [
                    EditWordImage(currentImages: widget.wordData.wordImages),
                    const SizedBox(
                      height: 40,
                    ),
                    EditWordForm(
                      wordDataToView: widget.wordData,
                      formKey: formKey,
                    )
                  ],
                ),
              ),
            )));
  }
}
