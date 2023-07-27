import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/new_word/widgets/form/word_form.dart';
import 'package:langpocket/src/features/new_word/widgets/form/fields/images_dashboard.dart';
import 'package:langpocket/src/features/word_edit/app_bar/word_editor_app_bar.dart';
import 'package:langpocket/src/features/word_edit/controller/word_editor_controller.dart';

class EditModeWordScreen extends ConsumerStatefulWidget {
  final int wordId;

  const EditModeWordScreen({super.key, required this.wordId});

  @override
  ConsumerState<EditModeWordScreen> createState() => _EditModeWordScreenState();
}

class _EditModeWordScreenState extends ConsumerState<EditModeWordScreen> {
  final formKey = GlobalKey<FormState>();
  late EditWordController editWordController;

  @override
  void initState() {
    editWordController = ref.refresh(wordEditorProvider.notifier);
    editWordController.getWord(widget.wordId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final word = ref.watch(wordEditorProvider);
    final colorStyle = Theme.of(context).colorScheme;
    return ResponsiveCenter(
        child: AsyncValueWidget(
      value: word,
      child: (wordData) {
        return Scaffold(
            appBar: WordEditorAppbar(
              editWordController: editWordController,
              wordData: wordData,
              formKey: formKey,
            ),
            backgroundColor: colorStyle.background,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 19.5),
                child: Column(
                  children: [
                    ImagesDashboard(currentImg: wordData.wordImages),
                    const SizedBox(
                      height: 40,
                    ),
                    NewWordForm(
                      wordRecord: wordData,
                      formKey: formKey,
                    )
                  ],
                ),
              ),
            ));
      },
    ));
  }
}
