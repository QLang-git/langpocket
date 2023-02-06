import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/word_previewer/app_bar/word_edit_mode_appbar.dart';
import 'package:langpocket/src/screens/word_previewer/app_bar/word_previewer_appbar.dart';
import 'package:langpocket/src/screens/word_previewer/widgets/examples_view/examples_view.dart';
import 'package:langpocket/src/screens/word_previewer/widgets/note_view/note_view.dart';
import 'package:langpocket/src/screens/word_previewer/widgets/word_view/word_view.dart';
import 'package:langpocket/src/screens/word_previewer/widgets/image_view/image_view.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class WordPreviewerScreen extends StatefulWidget {
  final bool editMode;
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
      super.key,
      required this.editMode});

  @override
  State<WordPreviewerScreen> createState() => _WordPreviewerScreenState();
}

class _WordPreviewerScreenState extends State<WordPreviewerScreen> {
  PreferredSizeWidget? appbar;
  @override
  void initState() {
    if (widget.editMode) {
      appbar = WordEditModeAppBar(
        foreignWord: widget.foreignWord,
        examples: widget.examples,
        imageList: widget.imageList,
        means: widget.means,
        note: widget.note,
      );
    } else {
      appbar = const WordPreviewerAppBar();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
        child: Scaffold(
      appBar: appbar!,
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
