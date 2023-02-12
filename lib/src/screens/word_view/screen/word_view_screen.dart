import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/examples_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/note_view/note_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/screens/word_view/controller/word_view_controller.dart';
import 'package:langpocket/src/screens/word_view/word_view_appbar/word_view_appbar.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class WordViewScreen extends ConsumerStatefulWidget {
  final String wordId;
  const WordViewScreen({
    super.key,
    required this.wordId,
  });

  @override
  ConsumerState<WordViewScreen> createState() => _WordViewScreenState();
}

class _WordViewScreenState extends ConsumerState<WordViewScreen> {
  @override
  Widget build(BuildContext context) {
    final wordInfo = ref.watch(watchWordbyIdProvider(int.parse(widget.wordId)));
    return ResponsiveCenter(
        child: AsyncValueWidget(
      value: wordInfo,
      data: (word) => Scaffold(
        appBar: WordViewAppBar(wordData: word),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              children: [
                ImageView(imageList: word.imagesList()),
                const SizedBox(
                  height: 15,
                ),
                WordView(
                  foreignWord: word.foreignWord,
                  means: word.meansList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                ExamplesView(examples: word.examplesList()),
                const SizedBox(
                  height: 20,
                ),
                NoteView(note: word.wordNote)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
