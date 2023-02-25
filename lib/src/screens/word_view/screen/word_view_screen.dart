import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/examples_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/note_view/note_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/screens/word_view/word_view_appbar/word_view_appbar.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class WordViewScreen extends ConsumerStatefulWidget {
  final WordData word;
  const WordViewScreen({
    super.key,
    required this.word,
  });

  @override
  ConsumerState<WordViewScreen> createState() => _WordViewScreenState();
}

class _WordViewScreenState extends ConsumerState<WordViewScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Scaffold(
        appBar: WordViewAppBar(wordData: widget.word),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              children: [
                ImageView(imageList: widget.word.imagesList()),
                const SizedBox(
                  height: 15,
                ),
                WordView(
                  foreignWord: widget.word.foreignWord,
                  means: widget.word.meansList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                ExamplesView(examples: widget.word.examplesList()),
                const SizedBox(
                  height: 20,
                ),
                NoteView(note: widget.word.wordNote)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
