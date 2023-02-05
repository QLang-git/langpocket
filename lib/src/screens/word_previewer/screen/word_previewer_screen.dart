import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/word_previewer/app_bar/word_previewer_appbar.dart';
import 'package:langpocket/src/screens/word_previewer/widgets/examples_view/examples_view.dart';
import 'package:langpocket/src/screens/word_previewer/widgets/note_view/note_view.dart';
import 'package:langpocket/src/screens/word_previewer/widgets/word_view/word_view.dart';
import 'package:langpocket/src/screens/word_previewer/widgets/image_view/image_view.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class WordPreviewerScreen extends StatelessWidget {
  final List<String> imageList;
  final String foreignWord;
  final List<String> means;
  final List<String> examples;
  final String note;
  const WordPreviewerScreen(
      {required this.imageList,
      required this.foreignWord,
      required this.means,
      required this.examples,
      required this.note,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
        child: Scaffold(
      appBar: const WordPreviewerAppBar(),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Column(
            children: [
              ImageView(imageList: imageList),
              const SizedBox(
                height: 15,
              ),
              WordView(
                foreignWord: foreignWord,
                means: means,
              ),
              const SizedBox(
                height: 20,
              ),
              ExamplesView(examples: examples),
              const SizedBox(
                height: 20,
              ),
              NoteView(note: note)
            ],
          ),
        ),
      ),
    ));
  }
}
