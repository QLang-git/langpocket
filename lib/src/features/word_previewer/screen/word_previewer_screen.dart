import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/examples_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/note_view/note_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/features/word_previewer/app_bar/word_previewer_appbar.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class WordPreviewerScreen extends ConsumerStatefulWidget {
  const WordPreviewerScreen({
    super.key,
  });

  @override
  ConsumerState<WordPreviewerScreen> createState() =>
      _WordPreviewerScreenState();
}

class _WordPreviewerScreenState extends ConsumerState<WordPreviewerScreen> {
  @override
  Widget build(BuildContext context) {
    final wordState = ref.watch(newWordControllerProvider);

    return ResponsiveCenter(
        child: Scaffold(
      appBar: const WordPreviewerAppBar(),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: AsyncValueWidget(
          value: wordState,
          child: (word) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  ImageView(imageList: word.wordImages),
                  const SizedBox(
                    height: 15,
                  ),
                  WordView(
                    foreignWord: word.foreignWord,
                    means: word.wordMeans,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ExamplesView(examples: word.wordExamples),
                  const SizedBox(
                    height: 20,
                  ),
                  NoteView(note: word.wordNote)
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
