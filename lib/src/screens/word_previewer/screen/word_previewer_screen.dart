import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/examples_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/note_view/note_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/word_previewer/app_bar/word_previewer_appbar.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class WordPreviewerScreen extends StatefulWidget {
  final List<String> imageList;
  final String foreignWord;
  final List<String> means;
  final List<String> examples;
  final String note;
  const WordPreviewerScreen({
    required this.imageList,
    required this.foreignWord,
    required this.means,
    required this.examples,
    required this.note,
    super.key,
  });

  @override
  State<WordPreviewerScreen> createState() => _WordPreviewerScreenState();
}

class _WordPreviewerScreenState extends State<WordPreviewerScreen> {
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
              ImageView(imageList: widget.imageList),
              const SizedBox(
                height: 15,
              ),
              WordView(
                foreignWord: widget.foreignWord,
                means: widget.means,
              ),
              const SizedBox(
                height: 20,
              ),
              ExamplesView(examples: widget.examples),
              const SizedBox(
                height: 20,
              ),
              NoteView(note: widget.note)
            ],
          ),
        ),
      ),
    ));
  }
}
