import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/examples_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/note_view/note_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';
import 'package:langpocket/src/screens/word_view/controller/word_view_controller.dart';
import 'package:langpocket/src/screens/word_view/word_view_appbar/word_view_appbar.dart';

class WordViewScreen extends ConsumerStatefulWidget {
  final int wordId;
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
    final colorStyle = Theme.of(context).colorScheme;
    final word = ref.watch(watchWordbyIdProvider(widget.wordId));

    return AsyncValueWidget(
      value: word,
      data: (word) {
        final wordData = wordDecoding([word]).first;
        return ResponsiveCenter(
          child: Scaffold(
            appBar: WordViewAppBar(wordData: wordData),
            backgroundColor: colorStyle.background,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  children: [
                    ImageView(imageList: wordData.wordImages),
                    const SizedBox(
                      height: 15,
                    ),
                    WordView(
                      foreignWord: wordData.foreignWord,
                      means: wordData.wordMeans,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ExamplesView(examples: wordData.wordExamples),
                    const SizedBox(
                      height: 20,
                    ),
                    NoteView(note: wordData.wordNote)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
