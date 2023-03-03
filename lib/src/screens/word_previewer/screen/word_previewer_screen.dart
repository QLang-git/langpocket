import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/examples_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/note_view/note_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/word_previewer/app_bar/word_previewer_appbar.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class WordPreviewerScreen extends StatefulWidget {
  final Word wordData;
  const WordPreviewerScreen({
    required this.wordData,
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
              ImageView(imageList: widget.wordData.wordImages),
              const SizedBox(
                height: 15,
              ),
              WordView(
                foreignWord: widget.wordData.foreignWord,
                means: widget.wordData.wordMeans,
              ),
              const SizedBox(
                height: 20,
              ),
              ExamplesView(examples: widget.wordData.wordExamples),
              const SizedBox(
                height: 20,
              ),
              NoteView(note: widget.wordData.wordNote)
            ],
          ),
        ),
      ),
    ));
  }
}
