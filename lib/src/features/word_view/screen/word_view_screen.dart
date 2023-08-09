import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/example_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/note_view/note_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/features/word_view/controller/word_view_controller.dart';
import 'package:langpocket/src/features/word_view/word_view_appbar/word_view_appbar.dart';

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
    final word = ref.watch(watchWordByIdProvider(widget.wordId));

    return AsyncValueWidget(
      value: word,
      child: (word) {
        final groupId = word.group;
        final wordData = word.decoding();
        return ResponsiveCenter(
          child: Scaffold(
            appBar: WordViewAppBar(wordData: wordData, groupId: groupId),
            backgroundColor: colorStyle.background,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    ImageView(
                        imageList: wordData.wordImages,
                        meanings: wordData.wordMeans),
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
                    Column(
                      children: wordData.wordExamples
                          .map((example) => ExampleView(
                                example: example,
                              ))
                          .toList(),
                    ),
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
