import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/custom_warning_dialog.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/word_edit/controller/word_editor_controller.dart';
import 'package:langpocket/src/screens/word_edit/screen/edit_mode_word_screen.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class WordEditorAppbar extends StatefulWidget with PreferredSizeWidget {
  final Word wordDataToView;
  final GlobalKey<FormState> formKey;
  const WordEditorAppbar({
    super.key,
    required this.formKey,
    required this.wordDataToView,
  });

  @override
  State<WordEditorAppbar> createState() => _WordEditorAppbarState();
  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _WordEditorAppbarState extends State<WordEditorAppbar> {
  @override
  Widget build(BuildContext context) {
    final states = context.findAncestorStateOfType<EditModeWordScreenState>()!;
    List<String> cleanList(List<String> list) {
      return list.where((element) => element.isNotEmpty).toList();
    }

    Future<void> saveNewUpdate(WidgetRef ref) async {
      if (widget.formKey.currentState!.validate()) {
        final newInfo = NewWordInfo(
            1,
            WordCompanion(
              foreignWord: Value(states.updatedforeignWord),
              wordMeans: Value(states.updatedWordMeans.join('-')),
              wordImages: Value(states.updatedWordImages.join('-')),
              wordExamples: Value(states.updatedWordExample.join('-')),
              wordNote: Value(states.updatedWordNote),
            ));

        final res = ref.read(updateWordInfoProvider(newInfo));
        if (!res.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The word has been updated')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Server Error, try again')),
          );
        }
        widget.formKey.currentState?.reset();
        context.pop();
      }
    }

    return ResponsiveCenter(
      child: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 75,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: (isWordInfoSimilar(states, cleanList))
                ? null
                : () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Consumer(
                              builder: (context, ref, child) =>
                                  CustomWarningDialog(
                                      onCancel: () {},
                                      title: const Text('save changes'),
                                      cancelOption: const Text('Cancel'),
                                      message: const Text(
                                          'Are you sure to save the changes'),
                                      onSave: () => saveNewUpdate(ref)));
                        });
                  },
            icon: Icon(
              Icons.save_alt,
              color: primaryFontColor,
              size: 30,
            ),
          ),
        ],
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                if (isWordInfoSimilar(states, cleanList)) {
                  context.pop();
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Consumer(
                          builder: (context, ref, child) => CustomWarningDialog(
                            onCancel: () => context.pop(),
                            cancelOption: const Text('Leave anyway'),
                            title: const Text('save changes'),
                            message: const Text(
                                'The changes you made wont be saved\n'
                                'if you leaved without saving'),
                            onSave: () => saveNewUpdate(ref),
                          ),
                        );
                      });
                }
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: primaryFontColor,
                size: 30,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center(
                  child: Text(
                    'word Edit',
                    style: headline1Bold(primaryFontColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isWordInfoSimilar(EditModeWordScreenState states,
      List<String> Function(List<String> list) cleanList) {
    return (states.updatedforeignWord.isEmpty ||
            states.updatedforeignWord
                    .compareTo(widget.wordDataToView.foreignWord) ==
                0) &&
        (listEquals(states.updatedWordMeans, List.filled(6, '')) ||
            listEquals(cleanList(states.updatedWordMeans),
                widget.wordDataToView.wordMeans)) &&
        (listEquals(states.updatedWordExample, List.filled(6, '')) ||
            listEquals(cleanList(states.updatedWordExample),
                widget.wordDataToView.wordExamples)) &&
        (listEquals(states.updatedWordImages, ['', '']) ||
            listEquals(
                states.updatedWordImages, widget.wordDataToView.wordImages)) &&
        ((states.updatedWordNote.isEmpty ||
            states.updatedWordNote.compareTo(widget.wordDataToView.wordNote) ==
                0));
  }
}
